Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262373AbSLZEOS>; Wed, 25 Dec 2002 23:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262384AbSLZEOS>; Wed, 25 Dec 2002 23:14:18 -0500
Received: from CPE-203-51-25-222.nsw.bigpond.net.au ([203.51.25.222]:17653
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S262373AbSLZEOQ>; Wed, 25 Dec 2002 23:14:16 -0500
Message-ID: <3E0A8403.BDCAF9ED@eyal.emu.id.au>
Date: Thu, 26 Dec 2002 15:22:27 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20-e1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21pre2aa1: compile error in fs/buffer.c
References: <20021226010605.GA4223@dualathlon.random>
Content-Type: multipart/mixed;
 boundary="------------11414C0B8DB1E4A7A3DE5756"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------11414C0B8DB1E4A7A3DE5756
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

A declaration at the wrong place was introduced by pre2aa1 in
fs/buffer.c. I simply moved the declaration tot the top of the
relevant block.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
--------------11414C0B8DB1E4A7A3DE5756
Content-Type: text/plain; charset=us-ascii;
 name="2.4.21-pre2-aa1-buffer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.21-pre2-aa1-buffer.patch"

--- linux/fs/buffer.c.orig	Thu Dec 26 15:10:26 2002
+++ linux/fs/buffer.c	Thu Dec 26 15:10:51 2002
@@ -2334,8 +2334,8 @@
 				}
 				if (iobuf->varyio &&
 				    (!(offset & RAWIO_BLOCKMASK))) {
-					iosize = RAWIO_BLOCKSIZE; 
 					int block_iter;
+					iosize = RAWIO_BLOCKSIZE; 
 					if (iosize > length)
 						iosize = length;
 					for (block_iter = 1; block_iter < iosize / size; block_iter++) {

--------------11414C0B8DB1E4A7A3DE5756--

