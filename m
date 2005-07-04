Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVGDLAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVGDLAO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 07:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVGDLAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 07:00:12 -0400
Received: from styx.suse.cz ([82.119.242.94]:64154 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261630AbVGDK6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 06:58:30 -0400
Date: Mon, 4 Jul 2005 12:58:29 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] ALPS: fix enabling hardware tapping
Message-ID: <20050704105829.GA13886@ucw.cz>
References: <200506150138.49880.dtor_core@ameritech.net> <m3slyw6reu.fsf@telia.com> <20050703203401.GA3733@ucw.cz> <m3vf3rlbax.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3vf3rlbax.fsf@telia.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2005 at 01:28:06AM +0200, Peter Osterlund wrote:

> Vojtech Pavlik <vojtech@suse.cz> writes:
> 
> > On Sun, Jul 03, 2005 at 01:49:13PM +0200, Peter Osterlund wrote:
> > > Dmitry Torokhov <dtor_core@ameritech.net> writes:
> > > 
> > > > It looks like logic for enabling hardware tapping in ALPS driver was
> > > > inverted and we enable it only if it was already enabled by BIOS or
> > > > firmware.
> > > 
> > > It looks like alps_init() has the same bug.  This patch fixes that
> > > function too by moving the check if the tapping mode needs to change
> > > into the alps_tap_mode() function, so that the test doesn't have to be
> > > duplicated.
> > 
> > This looks good. However - what's the point in checking whether tapping
> > is enabled before enabling it?
> 
> I don't think there is a point. IFAIK this code was added by Dmitry as
> part of the hardware auto-detection changes. In that version the check
> prevented a printk line when the touchpad was already in the correct
> state. That printk is deleted anyway by this patch, so the check can
> be removed. (Modulo weird hardware behavior, which can't be completely
> ruled out because the driver is based largely on reverse engineering,
> since no public docs are available.)
> 
> Signed-off-by: Peter Osterlund <petero2@telia.com>

Thanks; patch applied.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
