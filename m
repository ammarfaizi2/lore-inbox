Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131496AbRC0TZk>; Tue, 27 Mar 2001 14:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131497AbRC0TZU>; Tue, 27 Mar 2001 14:25:20 -0500
Received: from bzq-128-3.bezeqint.net ([212.179.127.3]:55819 "HELO arava.co.il")
	by vger.kernel.org with SMTP id <S131496AbRC0TZF>;
	Tue, 27 Mar 2001 14:25:05 -0500
Date: Tue, 27 Mar 2001 19:50:03 +0200 (IST)
From: Matan Ziv-Av <matan@svgalib.org>
Reply-To: Matan Ziv-Av <matan@svgalib.org>
To: James Simmons <jsimmons@linux-fbdev.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: vgacon on which card?
In-Reply-To: <Pine.LNX.4.31.0103270823230.1424-100000@linux.local>
Message-ID: <Pine.LNX.4.21_heb2.09.0103271939590.2723-100000@matan.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2001, James Simmons wrote:

> 
> Say you have several PCI graphics cards in a system but only have vgacon
> running. Is their away to determine which PCI card vgacon is running on?

The enabled one :-)

I don't see a general solution.
You can know if an AGP card's vga portion is enabled by checking the
corresponding bit in the pci bridge configuration space. But for PCI
cards there is no standard way of enabling vga.
If you have only one card with I/O enabled you can know this is the
card. If you have more, you can write to the 0xb8000 region, and see in
what linear aperture the write happens.



-- 
Matan Ziv-Av.                         matan@svgalib.org

