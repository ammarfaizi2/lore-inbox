Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266576AbSLJFvv>; Tue, 10 Dec 2002 00:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266578AbSLJFvv>; Tue, 10 Dec 2002 00:51:51 -0500
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:1767 "EHLO
	scaup.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S266576AbSLJFvu>; Tue, 10 Dec 2002 00:51:50 -0500
Date: Mon, 9 Dec 2002 22:52:18 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: CaT <cat@zip.com.au>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.51 (fbcon issues)
In-Reply-To: <20021210055205.GA615@zip.com.au>
Message-ID: <Pine.LNX.4.33.0212092250400.2617-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mon, Dec 09, 2002 at 07:17:19PM -0800, Linus Torvalds wrote:
> >   o Ported riva and vga16fb over to new api. Thanks Antonia Daplas!!!
> >     More optimizations in fbcon.c
>
> Almost but not quite. It boots fine by default but if I try to set the
> vga setting to a 1024x768 screen in garbles a 640x480 rectangle in the
> middle of my laptop screen and freezes. This mode worked fine under
> 2.4.x so I know the chip is capable.
>
> lilo.conf
>
> image=/boot/vmlinuz
>         label=linux
>         alias=l
>         read-only
>         vga=0x317
>         append="video=vesa:ywrap,mtrr"
>
> relevant bit out of .config:
>
> CONFIG_FB=y
> CONFIG_FB_VGA16=y

Remove that. I bet its getting confussed between VESA and the vga16fb
driver.

I would recommend you also disable VGA_CONSOLE.

> CONFIG_FB_VESA=y
> CONFIG_VIDEO_SELECT=y
> CONFIG_VGA_CONSOLE=y
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_FRAMEBUFFER_CONSOLE=y
> CONFIG_PCI_CONSOLE=y
> CONFIG_FONT_8x8=y
> CONFIG_FONT_8x16=y


