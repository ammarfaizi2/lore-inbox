Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264857AbUFTRBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264857AbUFTRBS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 13:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265273AbUFTRBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 13:01:17 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:44424 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S264857AbUFTRBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 13:01:15 -0400
Date: Sun, 20 Jun 2004 19:01:14 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: Matroxfb in 2.6 still doesn't work in 2.6.7
Message-ID: <20040620170114.GA4683@vana.vc.cvut.cz>
References: <20040618211031.GA4048@irc.pl> <20040619190503.GB17053@vana.vc.cvut.cz> <20040619193053.GA3644@irc.pl> <20040619203954.GC17053@vana.vc.cvut.cz> <20040620160437.GA29046@irc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040620160437.GA29046@irc.pl>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2004 at 06:04:37PM +0200, Tomasz Torcz wrote:
> On Sat, Jun 19, 2004 at 10:39:54PM +0200, Petr Vandrovec wrote:
> > > > It works for me, with CRT analog monitor... What if you boot with
> > > > video=matroxfb:outputs:010,1280x1024-16@60 (if you plugged your LCD to analog
> > > > output)
> > 
> > If you want exactly same videomode as you use under X, you should use
> > video=matroxfb:vesa:0x11A,right:48,hslen:112,left:248,hslen:112,lower:1,vslen:3,upper:48
> > maybe with ',sync:3' if +hsync/+vsync are mandatory for your monitor.
> 
>  Neither one works. During kernel boot resolution is switched to 1280x1024, but
> screen become corrupted - there are some green points in upper part of
> monitor. 

It works exactly as your kernel is configured. It switched to graphics, but it does
not paint your console there because you told you kernel to not do that.

>  Also, the patch from platan do not compile:

And this one too - my patch needs fbcon.

> CONFIG_VGA_CONSOLE=y
> CONFIG_MDA_CONSOLE=m
> CONFIG_DUMMY_CONSOLE=y
> # CONFIG_FRAMEBUFFER_CONSOLE is not set

Enable this. Into the kernel, not as a module.
 
> #
> # Logo configuration
> #
> # CONFIG_LOGO is not set

And enable this, so we can find whether fbdev works or not...
								Best regards,
									Petr Vandrovec

