Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbVGDGZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVGDGZe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 02:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVGDGZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 02:25:34 -0400
Received: from smtp108.sbc.mail.re2.yahoo.com ([68.142.229.97]:40015 "HELO
	smtp108.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261492AbVGDGZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 02:25:23 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Peter Osterlund <petero2@telia.com>
Subject: Re: [PATCH] ALPS: fix enabling hardware tapping
Date: Mon, 4 Jul 2005 01:25:17 -0500
User-Agent: KMail/1.8.1
Cc: Vojtech Pavlik <vojtech@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <200506150138.49880.dtor_core@ameritech.net> <20050703203401.GA3733@ucw.cz> <m3vf3rlbax.fsf@telia.com>
In-Reply-To: <m3vf3rlbax.fsf@telia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507040125.18049.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 July 2005 18:28, Peter Osterlund wrote:
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
the only reason for not doing it unconditionally.

-- 
Dmitry
