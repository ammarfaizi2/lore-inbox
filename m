Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261307AbTCTCui>; Wed, 19 Mar 2003 21:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263184AbTCTCui>; Wed, 19 Mar 2003 21:50:38 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:24845 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S261307AbTCTCug>; Wed, 19 Mar 2003 21:50:36 -0500
Date: Thu, 20 Mar 2003 12:01:36 +0900 (JST)
Message-Id: <20030320.120136.108400165.yoshfuji@wide.ad.jp>
To: davem@redhat.com
Cc: dlstevens@us.ibm.com, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH] anycast support for IPv6, updated to 2.5.44 
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@wide.ad.jp>
In-Reply-To: <20030319.163105.44963500.davem@redhat.com>
References: <OFC909BFEE.F581E26E-ON88256C60.0072A662@boulder.ibm.com>
	<20030319.163105.44963500.davem@redhat.com>
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030319.163105.44963500.davem@redhat.com> (at Wed, 19 Mar 2003 16:31:05 -0800 (PST)), "David S. Miller" <davem@redhat.com> says:

>    From: "David Stevens" <dlstevens@us.ibm.com>
>    Date: Mon, 28 Oct 2002 14:06:00 -0700
>    
>    Below is a patch to add anycast support for IPv6. It's the same patch as
>    I've posted previously, but updated with comments from Chris Hellwig and
>    for kernel version 2.5.44.
> 
> I'm going to apply this, with the small change that dev_getany() is
> renamed to dev_get_by_flags() which more accurately describes
> what the routine does.

Again: I don't like API at all.

Anycast address management itself in that patch would be ok.
However, JOIN/LEAVE is NOT useful and userland application will be 
incompatible with other implementation. (sigh...)
I think linux likes unicast model (assign address like unicast address), too.

And, we see __constant_{hton,ntoh}{l,h}() again...

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
