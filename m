Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129627AbQLRGfg>; Mon, 18 Dec 2000 01:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129557AbQLRGf1>; Mon, 18 Dec 2000 01:35:27 -0500
Received: from fe160.worldonline.dk ([212.54.64.198]:34832 "HELO
	fe160.worldonline.dk") by vger.kernel.org with SMTP
	id <S129421AbQLRGfP>; Mon, 18 Dec 2000 01:35:15 -0500
Date: Mon, 18 Dec 2000 07:03:03 +0100 (CET)
From: Niels Kristian Bech Jensen <nkbj@image.dk>
To: J Sloan <jjs@pobox.com>
cc: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: test13-pre3 woes
In-Reply-To: <3A3DA5B0.6BACE66E@pobox.com>
Message-ID: <Pine.LNX.4.30.0012180702380.16423-100000@hafnium.nkbj.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2000, J Sloan wrote:

> Similar problem here - with CONFIG_DRM_TDFX=m
> I have not gotten a tdfx.o module complied since the
> start of the test13-pre series...
>
> So no quake 3 arena unless I want to play at < 1 fps...
>
Does this patch fix your problem?

--- test13-pre3/drivers/char/Makefile	Mon Dec 18 01:21:31 2000
+++ linux/drivers/char/Makefile	Mon Dec 18 06:58:06 2000
@@ -16,6 +16,8 @@

 O_TARGET := char.o

+mod-subdirs := drm
+
 obj-y	 += tty_io.o n_tty.o tty_ioctl.o mem.o raw.o pty.o misc.o random.o

 # All of the (potential) objects that export symbols.

-- 
Niels Kristian Bech Jensen -- nkbj@image.dk -- http://www.image.dk/~nkbj/

----------->>  Stop software piracy --- use free software!  <<-----------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
