Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbUKNMK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbUKNMK2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 07:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbUKNMK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 07:10:28 -0500
Received: from aun.it.uu.se ([130.238.12.36]:61084 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261291AbUKNMKX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 07:10:23 -0500
Date: Sun, 14 Nov 2004 13:10:18 +0100 (MET)
Message-Id: <200411141210.iAECAIgd011479@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org, pgallen@gmail.com
Subject: Re: Compiling RHEL WS Kernels
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Nov 2004 22:23:14 -0800, Paul G. Allen wrote:
>I recently installed RHEL WS Update 3 (kernel 2.4.21-20) on my laptop.
>Out of the box it does not recognize any USB devices, my Synaptics
>touchpad, my PCMCIA Wireless (NetGear WAG511G) or the proper
>resolution on my LCD. (NOTE: RH 9 worked perfectly OOTB on this same
>machine. So far I'm not at all impressed with RHEL WS - any more than
>I was with RH 7.0.)
>
>I tried to build a new 2.4.21 kernel based upon a configuration from a
>non-RH kernel (2.4.24) that worked on this machine. Not a single
>module will compile correctly. I had to remove all modules and compile
>them into the kernel. I2C code will not compile at all and it had to
>be completely removed. After this I was able to compile a working
>kernel, but it boots with errors and the NVIDIA driver will not
>compile.
...
>What compiler versions are known to work with this kernel?

I run RHEL3 2.4.21-20.EL on several servers over here,
and in that role it works great.

You should only use gcc-3.2.3 to compile RHEL3 kernels.
The old 2.4 code base has problems with later gcc versions;
they've been fixed in 2.4.28-pre/rc, but that doesn't
help you with your 2.4.21-based RHEL kernel.

And as Arjan wrote, you must do a mrproper before configuring
and building the kernel and modules.

>My next step may be D/L the latest 2.6 stable kernel and try compiling
>that (but that still leaves the question of which gcc version to use).

Just about any one of {2.95.3, 3.2.3, 3.3.5, 3.4.3}.
