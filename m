Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262559AbUCOMlJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 07:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262561AbUCOMlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 07:41:09 -0500
Received: from witte.sonytel.be ([80.88.33.193]:65411 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262559AbUCOMlF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 07:41:05 -0500
Date: Mon, 15 Mar 2004 13:41:02 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kai Germaschewski <kai@germaschewski.name>,
       Sam Ravnborg <sam@ravnborg.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] out-of-tree builds
In-Reply-To: <Pine.GSO.4.58.0403141353470.1231@waterleaf.sonytel.be>
Message-ID: <Pine.GSO.4.58.0403151337120.14245@waterleaf.sonytel.be>
References: <Pine.GSO.4.58.0403141353470.1231@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Mar 2004, Geert Uytterhoeven wrote:
> Although I like the feature to build a kernel in a different directory a lot, I
> don't like its syntax. I prefer to just have a build directory where I can run
> `make whatever'.
>
> The following patch adds a configure script to the kernel. If you run
>
>     /path/to/kernel/source/tree/configure
>
> it will create a Makefile in the current directory, after which you can just do
> `make whatever', just like in the source directory.

Unfortunately not everything works.

E.g. I need to build usr/ with a different (newer) binutils, so when the build
fails on assembling usr/initramfs_data.o, I used to do the following, which no
longer works:

| tux$ PATH=/usr/bin/:$PATH make usr/
| make: `usr/' is up to date.
| tux$

I guess I need a catch-all .PHONY rule, but don't know how to implement it...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
