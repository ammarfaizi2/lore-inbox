Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWA0XFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWA0XFu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 18:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWA0XFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 18:05:50 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14227 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751329AbWA0XFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 18:05:49 -0500
Date: Sat, 28 Jan 2006 00:05:35 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Luca <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suspend to RAM: help with whitelist wanted
Message-ID: <20060127230535.GA1617@elf.ucw.cz>
References: <20060126213611.GA1668@elf.ucw.cz> <20060127170406.GA6164@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060127170406.GA6164@dreamland.darkstar.lan>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 27-01-06 18:04:06, Luca wrote:
> Pavel Machek <pavel@suse.cz> ha scritto:
> > Hi!
> > 
> > On www.sf.net/projects/suspend , there's s2ram.c program for
> > suspending machines. It contains whitelist of known machines, along
> > with methods to get their video working (similar to
> > Doc*/power/video.txt). Unfortunately, video.txt does not allow me to
> > fill in whitelist automatically, so I need your help.
> > 
> > I do not yet have solution for machines that need vbetool; fortunately
> > my machines do not need that :-), and it is pretty complex (includes
> > x86 emulator).
> 
> What about adding something like:
> 
> void s2ram_restore(void) {
>         if (needed)
>                 fork_and_exec(vbetool);
> }

Yes... that's what I wanted to avoid. ... ...

I originally wanted to avoid calling external problems. That way,
s2ram code could be pagelocked and you would get your video back even
in case of disk problems etc.

[I thought that it would bring problems with suspend-to-both; but I
was wrong, no such problem exists.]

> Ugly? Maybe, but you don't have to fiddle with a x86 emulator.

...and then there's a issue of how to do vbetool vbestate
save. According to docs it should be done just once, but that looks
pretty fragile to me. Perhaps we can just do it unconditionaly?

								Pavel
-- 
Thanks, Sharp!
