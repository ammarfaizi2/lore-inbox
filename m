Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWEEBeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWEEBeA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 21:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWEEBeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 21:34:00 -0400
Received: from web.bloglines.com ([65.214.39.152]:56012 "HELO
	blw09bos.io.askjeeves.info") by vger.kernel.org with SMTP
	id S932279AbWEEBd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 21:33:59 -0400
Message-ID: <1146792838.2129823533.18589.sendItem@bloglines.com>
Date: 5 May 2006 01:33:58 -0000
From: grfgguvf.29601511@bloglines.com
To: adaplas@gmail.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Weird framebuffer bug?
MIME-Version: 1.0
Content-Type: text/plain;charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Antonino A. Daplas <adaplas@gmail.com> wrote:
> Does the same thing happens
with different
> color depths?

That was it. With mode vga=0x318 (1024x768
"16m
colours") no matter what colour depth I set X to
the display will be
incorrect. Set to 24bits every
4th (not 5th, that was my bad estimation)
vertical
line is omitted. This is because the framebuffer
is really using
32bits/pixel.

Using mode vga=0x317 (1024x768 "64k colours")
and X set
to 16bits colour depth everything is OK.

This is really an X fbdev driver
problem... It
should use 32bits/pixel by padding the last byte.
I will write
Xorg about this.

> Can you try using the "vesa" driver with X?  If
> the
same thing happens, it might
> be a problem with the BIOS.

[I tried this
first, and as expected X's vesa
driver works.]

Thanks Antonino!

