Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261305AbTCTDdU>; Wed, 19 Mar 2003 22:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261308AbTCTDdU>; Wed, 19 Mar 2003 22:33:20 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:40973 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S261305AbTCTDdT>; Wed, 19 Mar 2003 22:33:19 -0500
Date: Thu, 20 Mar 2003 12:44:28 +0900 (JST)
Message-Id: <20030320.124428.95965257.yoshfuji@wide.ad.jp>
To: davem@redhat.com
Cc: dlstevens@us.ibm.com, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH] anycast support for IPv6, updated to 2.5.44 
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@wide.ad.jp>
In-Reply-To: <20030319.192331.95884882.davem@redhat.com>
References: <20030319.163105.44963500.davem@redhat.com>
	<20030320.120136.108400165.yoshfuji@wide.ad.jp>
	<20030319.192331.95884882.davem@redhat.com>
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030319.192331.95884882.davem@redhat.com> (at Wed, 19 Mar 2003 19:23:31 -0800 (PST)), "David S. Miller" <davem@redhat.com> says:

>    > I'm going to apply this, with the small change that dev_getany() is
>    > renamed to dev_get_by_flags() which more accurately describes
>    > what the routine does.
>    
>    Again: I don't like API at all.
>    
>    Anycast address management itself in that patch would be ok.
>    However, JOIN/LEAVE is NOT useful and userland application will be 
>    incompatible with other implementation. (sigh...)
>    I think linux likes unicast model (assign address like unicast address), too.
>    
> Please propose alternative API, or do you suggest not
> to export this facility to user at all?

I like to assign address like unicast (using ioctl and rtnetlink 
(RTN_ANYCAST)).
We suggest you not exporting this facilicy until finishing new API
(And, another API would be standardized;
This is another reason why I am against exporting that API for now.)

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
