Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbUBWUgh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 15:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbUBWUgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 15:36:36 -0500
Received: from pD9E57667.dip.t-dialin.net ([217.229.118.103]:10244 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id S262041AbUBWUfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 15:35:52 -0500
Date: Mon, 23 Feb 2004 20:35:28 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: fbdv/fbcon pending problems
Message-ID: <20040223203528.E433@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	James Simmons <jsimmons@infradead.org>,
	Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1077497593.5960.28.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <1077497593.5960.28.camel@gaston>; from benh@kernel.crashing.org on Mon, Feb 23, 2004 at 11:53:14AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 11:53:14AM +1100, Benjamin Herrenschmidt wrote:
>  - mach64 lockups on LT-G (I'll try on an LT-Pro soon) plus other
> mach64 bugs in the new version in the bk fbdev, I'll have a patch for
> some of the problems, but I didn't find a good explanation for the
> accel lockups yet

Question: Is fbdev supposed to work without BIOS? 

I have an ATI Technologies Inc 3D Rage Pro 215GP in an Alpha AXPpci33,
currently running with MILO as firmware/bootloader. 
For several reasons I want to change to the original SRM firmware. 
Unfortunately its intel_cpu/BIOS emulation locks up on the ATI BIOS. With
the BIOS disabled the SRM succeeds loading the kernel. fbdev seems to
initialize _something_, i.e. the monitor wakes up ans displays a stable
repeating pattern of vertical stripes. But it hangs the machine after
these lines on serial console:

fb0: ATY Mach64 frame buffer device on PCI
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).

Booting the same kernel image (2.6.[13]) with MILO (which has a different
cpu emulation that succeeds executing the BIOS) works fine with fbdev. 

Bye,
Thorsten

-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Kiebitzstr. 14, 49324 Melle, Germany  |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
