Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280922AbRKOPrP>; Thu, 15 Nov 2001 10:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280921AbRKOPrG>; Thu, 15 Nov 2001 10:47:06 -0500
Received: from netsrvr.ami.com.au ([203.55.31.38]:30473 "EHLO
	netsrvr.ami.com.au") by vger.kernel.org with ESMTP
	id <S280923AbRKOPqx>; Thu, 15 Nov 2001 10:46:53 -0500
Message-Id: <200111150629.fAF6SKg20602@numbat.os2.ami.com.au>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Linux kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
cc: davem@redhat.com
Subject: BOOTP and 2.4.14
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 15 Nov 2001 14:28:19 +0800
From: summer@os2.ami.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm trying to configure a system to boot with root on NFS. I have it 
working, but there are problems.

The most serious are that the DNS domain name is set wrongly, and NIS 
domain's not set at all.

The IP address offered and accepted in 192.168.1.20.

The DNS domain name being set is 168.1.20, and the host name 192.


I'm looking at the ipconfig.c source, around line 1324 where I see this 
code:
			case 4:
				if ((dp = strchr(ip, '.'))) {
					*dp++ = '\0';
					strncpy(system_utsname.domainname, dp, __NEW_UTS_LEN);
					system_utsname.domainname[__NEW_UTS_LEN] = '\0';
				}
				strncpy(system_utsname.nodename, ip, __NEW_UTS_LEN);
				system_utsname.nodename[__NEW_UTS_LEN] = '\0';
				ic_host_name_set = 1;
				break;


I can see how the dnsdomain name's being set, and it does not look 
right to me.

If someone can prepare a patch for me, I'll be delighted to test it.


-- 
Cheers
John Summerfield

Microsoft's most solid OS: http://www.geocities.com/rcwoolley/

Note: mail delivered to me is deemed to be intended for me, for my 
disposition.



