Return-Path: <linux-kernel-owner+w=401wt.eu-S1750962AbXACRG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbXACRG7 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 12:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbXACRG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 12:06:59 -0500
Received: from vsmtp1.tin.it ([212.216.176.141]:40494 "EHLO vsmtp1.tin.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750930AbXACRG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 12:06:58 -0500
Date: Wed, 3 Jan 2007 18:06:09 +0100 (CET)
From: l.genoni@oltrelinux.com
X-X-Sender: venom@Phoenix.oltrelinux.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Grzegorz Kulewski <kangur@polcom.net>, Alan <alan@lxorguk.ukuu.org.uk>,
       Mikael Pettersson <mikpe@it.uu.se>, s0348365@sms.ed.ac.uk,
       76306.1226@compuserve.com, akpm@osdl.org, bunk@stusta.de,
       greg@kroah.com, linux-kernel@vger.kernel.org,
       yanmin_zhang@linux.intel.com
Subject: Re: kernel + gcc 4.1 = several problems
In-Reply-To: <Pine.LNX.4.64.0701030731080.4473@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0701031804320.8503@Phoenix.oltrelinux.com>
References: <200701030212.l032CDXe015365@harpo.it.uu.se>
 <20070103102944.09e81786@localhost.localdomain> <Pine.LNX.4.63.0701031128420.14187@alpha.polcom.net>
 <Pine.LNX.4.64.0701030731080.4473@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just to make clearer why I am so curious, this from X86_64 X2 3800+:

DarkStar:{venom}:/tmp> gcc -DCMOV -Wall -O2 t.c
DarkStar:{venom}:/tmp>time ./a.out
600000000

real    0m0.151s
user    0m0.150s
sys     0m0.000s
DarkStar:{venom}:/tmp> gcc -Wall -O2 t.c
DarkStar:{venom}:/tmp> time ./a.out
600000000

real    0m0.176s
user    0m0.180s
sys     0m0.000s
DarkStar:{venom}:/tmp>gcc -m32 -DCMOV -Wall -O2 t.c
DarkStar:{venom}:/tmp>time ./a.out
600000000

real    0m0.152s
user    0m0.160s
sys     0m0.000s
DarkStar:{venom}:/tmp>gcc -m32  -Wall -O2 t.c
DarkStar:{venom}:/tmp>time ./a.out
600000000

real    0m0.200s
user    0m0.200s
sys     0m0.000s

