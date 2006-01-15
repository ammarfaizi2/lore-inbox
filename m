Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWAONfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWAONfq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 08:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbWAONfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 08:35:46 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:53772 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932067AbWAONfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 08:35:45 -0500
Date: Sun, 15 Jan 2006 14:35:36 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Thomas Fazekas <thomas.fazekas@gmail.com>, linux-kernel@vger.kernel.org,
       arch@archlinux.org
Subject: Re: Modify setterm color palette
Message-ID: <20060115133536.GN7142@w.ods.org>
References: <421547be0601150407v8e087afh55a9ee12ae27ac8e@mail.gmail.com> <Pine.LNX.4.61.0601151313360.4174@yvahk01.tjqt.qr> <20060115131620.GA24976@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060115131620.GA24976@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2006 at 01:16:20PM +0000, Russell King wrote:
> On Sun, Jan 15, 2006 at 01:15:23PM +0100, Jan Engelhardt wrote:
> > drivers/char/vt.c: default_red, default_grn, default_blu
> > 
> > You can also change them with `echo -en "\e]PXRRGGBB"`, where X is a hex 
> > digit (range 0-F), and RGB are the components. Check console_codes(4) and 
> > go figure. :)
> 
> I for one prefer the standard VT100 yellow instead of brown, and I
> have an escape sequence to do that similar to the one you show above.
> 
> However, there's one major flaw - programs recently (and by that I mean
> FC2-like recently) have started to do complete console resets, which
> result in the users settings being completely wiped out.
> 
> For instance, I have:
> 
> if [ "$TERM" = "linux" ]; then
>   echo -ne '\e]P3aaaa00'
> fi
> 
> in the bash login scripts.  Run mutt 1.4 and that gets wiped out.
> Previous version of mutt (1.2?) didn't do this.
> 
> So, in essence, this is a completely useless solution.  I think we need
> a separate escape sequence to modify the system default so that peoples
> preferences do not get inadvertently wiped out by programs.

Why not add an escape sequence to lock/unlock the palette ? It might be
simpler, and we could even stack the locks to ensure recursive protection.

> (I have also considered writing a module to locate the default palette
> and "correct" it.)
> 
> -- 
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:  2.6 Serial core

Regards,
Willy

