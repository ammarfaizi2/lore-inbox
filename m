Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266578AbUBLUyg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 15:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266589AbUBLUyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 15:54:33 -0500
Received: from gate.crashing.org ([63.228.1.57]:46231 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266578AbUBLUyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 15:54:25 -0500
Subject: Re: Radeon fb patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Panagiotis Papadakos <papadako@csd.uoc.gr>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.58.0402121944170.12860@thanatos.csd.uch.gr>
References: <Pine.GSO.4.58.0402121944170.12860@thanatos.csd.uch.gr>
Content-Type: text/plain
Message-Id: <1076619057.12771.17.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 13 Feb 2004 07:50:58 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-02-13 at 04:59, Panagiotis Papadakos wrote:
> I tried to compile bk2 with the new radeofb patch, but it failed.
> The problem exists if you have enabled drm for radeon, because
> radeon_engine_reset is declared twice, once in drivers/char/drm/
> radeon_cp.c and the second time in drivers/video/aty/radeon_accel.c.
> The attached patch just renames radeon_engine_reset to
> radeonfb_engine_reset in drivers/video/aty and also radeon_engine_init
> to radeonfb_engine_init just for consistency. It compiles fine, but shows
> garbage on my notebook. Don't know if it is my patch or the new radeonfb
> code.

Thanks. I used to call radeonfb_ exposed routines to the outside world
and radeon_ internal ones, but your fix is probably the simplest way to
get out of the conflict with DRI indeed.

What kind of grabage do you get ? Can you re-enable DEBUG in radeonfb.h
and send me a dmesg log after boot ? Did the "old" radeonfb work
properly ? Also, what is the native resolution of your flat panel ?

Ben.


