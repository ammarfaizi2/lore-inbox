Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263156AbSJHBDh>; Mon, 7 Oct 2002 21:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263157AbSJHBDh>; Mon, 7 Oct 2002 21:03:37 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:9738 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S263156AbSJHBDd>; Mon, 7 Oct 2002 21:03:33 -0400
Date: Tue, 08 Oct 2002 10:08:53 +0900 (JST)
Message-Id: <20021008.100853.123683687.yoshfuji@linux-ipv6.org>
To: jasper@spaans.ds9a.nl
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix IPv6
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20021007210343.GA1486@mayo.ds9a.tudelft.nl>
References: <Pine.LNX.4.33.0210071157270.1917-100000@penguin.transmeta.com>
	<20021007210343.GA1486@mayo.ds9a.tudelft.nl>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021007210343.GA1486@mayo.ds9a.tudelft.nl> (at Mon, 7 Oct 2002 23:03:43 +0200), Jasper Spaans <jasper@spaans.ds9a.nl> says:

> On Mon, Oct 07, 2002 at 12:02:59PM -0700, Linus Torvalds wrote:
> 
> >   o [IPV4/IPV6]: General cleanups
> 
> Some part of this makes my tree noncompilable:
> 
> net/ipv6/addrconf.c: In function `ipv6_addr_type':
> net/ipv6/addrconf.c:155: case label does not reduce to an integer constant
> net/ipv6/addrconf.c:159: case label does not reduce to an integer constant
> etc.

Agreed.

BTW, I repleced __constant_{hton,ntoh}{l,s}() with {hton,htoh}{l,s}(),
but I believe I did NOT do it for "case" in my patch...

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
