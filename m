Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263640AbUGLVWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263640AbUGLVWm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 17:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUGLVWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 17:22:41 -0400
Received: from [203.178.140.15] ([203.178.140.15]:34310 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S263640AbUGLVW2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 17:22:28 -0400
Date: Tue, 13 Jul 2004 06:22:26 +0900 (JST)
Message-Id: <20040713.062226.130914590.yoshfuji@linux-ipv6.org>
To: cra@WPI.EDU
Cc: linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: v2.6 IGMPv3 implementation
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20040712203056.GI7822@angus.ind.WPI.EDU>
References: <20040712203056.GI7822@angus.ind.WPI.EDU>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040712203056.GI7822@angus.ind.WPI.EDU> (at Mon, 12 Jul 2004 16:30:56 -0400), "Charles R. Anderson" <cra@WPI.EDU> says:

> /* Multicast source filter calls */
> #define SIOCSIPMSFILTER        0x89a0          /* set mcast src filter (ipv4) */
> #define SIOCGIPMSFILTER 0x89a1         /* get mcast src filter (ipv4) */
> #define SIOCSMSFILTER  0x89a2          /* set mcast src filter (proto indep) */
> #define SIOCGMSFILTER  0x89a3          /* get mcast src filter (proto indep) */
> 
> These do not appear in the Linus kernel, though.  Does anyone know the
> status of these ioctls and the IGMPv3 implementation in general?  I'm
> trying to get the proper bits stuffed into glibc to make IGMPv3/SSM
> usable, and I'm not sure what to do about these ioctls.  Should 4 new
> ioctl numbers be reserved for these in case an implementation is
> integrated, or should I just leave them out of glibc headers entirely?

These ioctls are "historic" and deprecated API.
So, just kill them to avoid confusion.
We use socket options.

Thanks.

Reference:
D. Thaler, B. Fenner and B. Quinn, "Socket Interface Extensions for 
Multicast Source Filters," RFC3678, January 2004.

--yoshfuji
