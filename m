Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261599AbSKLPnf>; Tue, 12 Nov 2002 10:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266607AbSKLPnf>; Tue, 12 Nov 2002 10:43:35 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:22795 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S261599AbSKLPne>; Tue, 12 Nov 2002 10:43:34 -0500
Date: Wed, 13 Nov 2002 00:50:34 +0900 (JST)
Message-Id: <20021113.005034.03327449.yoshfuji@wide.ad.jp>
To: alan@lxorguk.ukuu.org.uk
Cc: roland@topspin.com, davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] increase MAX_ADDR_LEN
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@wide.ad.jp>
In-Reply-To: <1037116836.8500.55.camel@irongate.swansea.linux.org.uk>
References: <1037111029.8321.12.camel@irongate.swansea.linux.org.uk>
	<521y5qn7l5.fsf@topspin.com>
	<1037116836.8500.55.camel@irongate.swansea.linux.org.uk>
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1037116836.8500.55.camel@irongate.swansea.linux.org.uk> (at 12 Nov 2002 16:00:36 +0000), Alan Cox <alan@lxorguk.ukuu.org.uk> says:

> 2. Add some new address setting ioctls, and ensure the old ones keep the
> old address length limit. That is needed because the old caller wont
> have allocated enough address space for a 20 byte address return.
> 
> You have to solve both though, and the first patch should probably be
> the one to add more sensible address set/get functions.

*BSDs have SIOCGLIFPHYADDR etc., but, they're obsolete; 
we should use rtnetlink (or routing socket in BSDs) to manage 
addresses.  So, not having such ioctls for long addresses 
would be ok.

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
