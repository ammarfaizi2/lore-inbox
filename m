Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262363AbVHAHCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbVHAHCN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 03:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbVHAHCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 03:02:13 -0400
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:27055 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262363AbVHAHCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 03:02:11 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dave Airlie <airlied@gmail.com>, Pavel Machek <pavel@ucw.cz>,
       ambx1@neo.rr.com, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: revert yenta free_irq on suspend
References: <2e00842e116e.2e116e2e0084@columbus.rr.com>
	<Pine.LNX.4.58.0507311550400.14342@g5.osdl.org>
	<20050731230507.GE27580@elf.ucw.cz>
	<Pine.LNX.4.58.0507311622510.14342@g5.osdl.org>
	<20050731232735.GF27580@elf.ucw.cz>
	<Pine.LNX.4.58.0507311635360.14342@g5.osdl.org>
	<21d7e9970507311659259e5560@mail.gmail.com>
	<21d7e9970507311659259e5560@mail.gmail.com>
	<Pine.LNX.4.58.0507311709410.14342@g5.osdl.org>
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Date: 01 Aug 2005 08:01:58 +0100
In-Reply-To: <Pine.LNX.4.58.0507311709410.14342@g5.osdl.org>
Message-ID: <r67jf69m3d.fsf@skye.ra.phy.cam.ac.uk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> slow and steady progress

The oscillations are indeed discouraging.  For S3 sleep/wake on my TP
600X:

2.6.11.4        : works well (the console was hosed with jittering text, but
                  X restores fine), which hugely improved using my laptop.
2.6.12.3        : ditto

But:

2.6.13-rc3      : goes to sleep but hangs when waking up
      -rc3-mm2  : same
      -rc3-mm3  : same
      -rc4-git3 : same

With those 2.6.13 variants, once it has hung, the power switch will
turn it off, but to turn it on I first have to unplug the power and
remove both batteries.

On the good side, swsusp seems to be improving with later kernel
versions.  No luck with 2.6.11.4; reasonable luck with 2.6.12.3; and
good results with 2.6.13*.

-Sanjoy
