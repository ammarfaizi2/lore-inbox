Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269295AbUJKWFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269295AbUJKWFN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 18:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269321AbUJKWFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 18:05:12 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:62905 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S269295AbUJKWEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 18:04:51 -0400
Date: Mon, 11 Oct 2004 15:04:49 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>, Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc4 - pls test (and no more patches)
Message-ID: <20041011220449.GC8121@smtp.west.cox.net>
References: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 10, 2004 at 08:22:54PM -0700, Linus Torvalds wrote:

>  trying to make ready for the real 2.6.9 in a week or so, so please give
> this a beating, and if you have pending patches, please hold on to them
> for a bit longer, until after the 2.6.9 release. It would be good to have
> a 2.6.9 that doesn't need a dot-release immediately ;)

With 2.6.9-rc4, using matroxfb, I can no longer pass
video=1280x1024-8@85.  This worked on 2.6.8.1, and I'm trying kernels
inbetween now.
$ cat /proc/cmdline 
root=/dev/hda1 ro video=1280x1024-8@85 elevator=cfq 
$ zgrep -E CONFIG_\(FB\|VIDEO\).*= /proc/config.gz 
CONFIG_FB=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_G450=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_I2C=y
$ dmesg | grep matrox
matroxfb: Matrox G450 detected
matroxfb: MTRR's turned on
matroxfb: 640x480x8bpp (virtual: 640x26214)
matroxfb: framebuffer at 0xCC000000, mapped to 0xe0880000, size 33554432
matroxfb_crtc2: secondary head of fb0 was registered as fb1

-- 
Tom Rini
http://gate.crashing.org/~trini/
