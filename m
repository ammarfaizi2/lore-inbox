Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262782AbSJOITV>; Tue, 15 Oct 2002 04:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263276AbSJOITV>; Tue, 15 Oct 2002 04:19:21 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:28609 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S262782AbSJOITU>; Tue, 15 Oct 2002 04:19:20 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 15 Oct 2002 10:22:57 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>,
       Chris Cheney <ccheney@cheney.cx>
Subject: [trivial patch] Re: bttv driver in 2.5.42-bk2
Message-ID: <20021015082256.GA11469@bytesex.org>
References: <20021015054228.GA5074@cheney.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021015054228.GA5074@cheney.cx>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 12:42:28AM -0500, Chris Cheney wrote:
> I wanted to let you know that it appears that bttv no longer compiles in
> 2.5.42-bk2 (in case you weren't aware of that fact yet).

Thanks, hadn't noticed yet.  It is just a missing include, fix below.

  Gerd

==============================[ cut here ]==============================
--- drivers/media/video/bttv-driver.c.fix	Tue Oct 15 10:19:17 2002
+++ drivers/media/video/bttv-driver.c	Tue Oct 15 10:19:34 2002
@@ -31,6 +31,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/interrupt.h>
+#include <linux/init.h>
 #include <linux/kdev_t.h>
 
 #include <asm/io.h>
