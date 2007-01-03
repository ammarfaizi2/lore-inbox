Return-Path: <linux-kernel-owner+w=401wt.eu-S1750886AbXACRpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbXACRpT (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 12:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbXACRpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 12:45:19 -0500
Received: from [139.30.44.16] ([139.30.44.16]:19654 "EHLO
	gockel.physik3.uni-rostock.de" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750886AbXACRpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 12:45:17 -0500
Date: Wed, 3 Jan 2007 18:45:15 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: l.genoni@oltrelinux.com
cc: Linus Torvalds <torvalds@osdl.org>, Grzegorz Kulewski <kangur@polcom.net>,
       Alan <alan@lxorguk.ukuu.org.uk>, Mikael Pettersson <mikpe@it.uu.se>,
       s0348365@sms.ed.ac.uk, 76306.1226@compuserve.com, akpm@osdl.org,
       bunk@stusta.de, greg@kroah.com, linux-kernel@vger.kernel.org,
       yanmin_zhang@linux.intel.com
Subject: Re: kernel + gcc 4.1 = several problems
In-Reply-To: <Pine.LNX.4.64.0701031759030.8415@Phoenix.oltrelinux.com>
Message-ID: <Pine.LNX.4.63.0701031831160.29878@gockel.physik3.uni-rostock.de>
References: <200701030212.l032CDXe015365@harpo.it.uu.se>
 <20070103102944.09e81786@localhost.localdomain> <Pine.LNX.4.63.0701031128420.14187@alpha.polcom.net>
 <Pine.LNX.4.64.0701030731080.4473@woody.osdl.org>
 <Pine.LNX.4.64.0701031759030.8415@Phoenix.oltrelinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, on a P4 (which is supposed to be soo bad) I get:

> gcc -O2 t.c -o t
> foreach x ( 1 2 3 4 5 )
>> time ./t > /dev/null
>> end
0.196u 0.004s 0:00.19 100.0%    0+0k 0+0io 0pf+0w
0.168u 0.004s 0:00.16 100.0%    0+0k 0+0io 0pf+0w
0.168u 0.000s 0:00.16 100.0%    0+0k 0+0io 0pf+0w
0.160u 0.000s 0:00.15 106.6%    0+0k 0+0io 0pf+0w
0.180u 0.000s 0:00.18 100.0%    0+0k 0+0io 0pf+0w
> gcc -DCMOV -O2 t.c -o t
> foreach x ( 1 2 3 4 5 )
>> time ./t > /dev/null
>> end
0.168u 0.000s 0:00.17 94.1%     0+0k 0+0io 0pf+0w
0.152u 0.000s 0:00.15 100.0%    0+0k 0+0io 0pf+0w
0.136u 0.004s 0:00.13 100.0%    0+0k 0+0io 0pf+0w
0.168u 0.000s 0:00.16 100.0%    0+0k 0+0io 0pf+0w
0.172u 0.000s 0:00.17 100.0%    0+0k 0+0io 0pf+0w

see?
