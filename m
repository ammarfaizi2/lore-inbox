Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263676AbTIHUnr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 16:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263678AbTIHUnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 16:43:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:2947 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263676AbTIHUnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 16:43:43 -0400
Date: Mon, 8 Sep 2003 13:43:38 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, <willy@debian.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] use size_t for the broken ioctl numbers
In-Reply-To: <20030908222742.A1085@pclin040.win.tue.nl>
Message-ID: <Pine.LNX.4.44.0309081335040.1666-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 8 Sep 2003, Andries Brouwer wrote:
> 
> Got it. Thanks!

Side notes:

 - Jeff made a mailing list if you're really interested in sparse 
   (majordomo@vger.kernel.org, the list name is "linux-sparse")

 - most of the warnings right now seem to be "bad constant expression" due 
   to the adoption of C99 variable-sized arrays in <linux/bitmap.h>. I 
   don't much like it.

 - the rest are mostly due to the address space checks. Some of them are 
   likely trivial to fix, but the most interesting ones (in the networking 
   code) are because the networking code re-uses the same data structures 
   for both kernel and user addresses. David said he'd fix it a long time 
   ago, but he never got around to it..

Finally:

 - it's not seriously usable yet. It's _almost_ there, but especially the 
   networking thing has kept me from being very motivated lately. I've 
   documented some of the preprocessor limitations in the "validation" 
   tests.

Have fun.

		Linus

