Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266565AbSLJFoi>; Tue, 10 Dec 2002 00:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266576AbSLJFoi>; Tue, 10 Dec 2002 00:44:38 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:30336 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S266565AbSLJFoh>; Tue, 10 Dec 2002 00:44:37 -0500
Date: Tue, 10 Dec 2002 16:52:05 +1100
From: CaT <cat@zip.com.au>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.51 (fbcon issues)
Message-ID: <20021210055205.GA615@zip.com.au>
References: <Pine.LNX.4.44.0212091912180.17200-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212091912180.17200-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2002 at 07:17:19PM -0800, Linus Torvalds wrote:
>   o Ported riva and vga16fb over to new api. Thanks Antonia Daplas!!!
>     More optimizations in fbcon.c

Almost but not quite. It boots fine by default but if I try to set the
vga setting to a 1024x768 screen in garbles a 640x480 rectangle in the
middle of my laptop screen and freezes. This mode worked fine under
2.4.x so I know the chip is capable.

lilo.conf

image=/boot/vmlinuz
        label=linux
        alias=l
        read-only
        vga=0x317
        append="video=vesa:ywrap,mtrr"

relevant bit out of .config:

CONFIG_FB=y
CONFIG_FB_VGA16=y
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

-- 
        All people are equal,
        But some are more equal then others.
            - George W. Bush Jr, President of the United States
              September 21, 2002 (Abridged version of security speech)
