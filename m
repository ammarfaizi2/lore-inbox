Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281070AbRKOVW3>; Thu, 15 Nov 2001 16:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281072AbRKOVWV>; Thu, 15 Nov 2001 16:22:21 -0500
Received: from dialin-145-254-150-103.arcor-ip.net ([145.254.150.103]:18962
	"EHLO picklock.adams.family") by vger.kernel.org with ESMTP
	id <S281070AbRKOVWJ>; Thu, 15 Nov 2001 16:22:09 -0500
Message-ID: <3BF43013.30433D08@loewe-komp.de>
Date: Thu, 15 Nov 2001 22:13:55 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: B16
X-Mailer: Mozilla 4.78 [de] (X11; U; Linux 2.4.13-xfs i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: summer@os2.ami.com.au
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: BOOTP and 2.4.14
In-Reply-To: <200111150629.fAF6SKg20602@numbat.os2.ami.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

summer@os2.ami.com.au schrieb:
> 
> I'm trying to configure a system to boot with root on NFS. I have it
> working, but there are problems.
> 
> The most serious are that the DNS domain name is set wrongly, and NIS
> domain's not set at all.
> 
> The IP address offered and accepted in 192.168.1.20.
> 
> The DNS domain name being set is 168.1.20, and the host name 192.
> 


Uh, how about to specify a NAME.DOMAIN.COM instead of an 
dotted IP. Check your bootp configuration.


> I'm looking at the ipconfig.c source, around line 1324 where I see this
> code:
>                         case 4:
>                                 if ((dp = strchr(ip, '.'))) {
>                                         *dp++ = '\0';
>                                         strncpy(system_utsname.domainname, dp, __NEW_UTS_LEN);
>                                         system_utsname.domainname[__NEW_UTS_LEN] = '\0';
>                                 }
>                                 strncpy(system_utsname.nodename, ip, __NEW_UTS_LEN);
>                                 system_utsname.nodename[__NEW_UTS_LEN] = '\0';
>                                 ic_host_name_set = 1;
>                                 break;
> 
> I can see how the dnsdomain name's being set, and it does not look
> right to me.
> 
> If someone can prepare a patch for me, I'll be delighted to test it.
>
