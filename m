Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265542AbTFMVyc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 17:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265547AbTFMVyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 17:54:32 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:55213 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265542AbTFMVya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 17:54:30 -0400
Date: Sat, 14 Jun 2003 00:08:10 +0200
From: Vojtech Pavlik <vojtech@ucw.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Peter Berg Larsen <pebl@math.ku.dk>
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
Message-ID: <20030614000810.A10851@ucw.cz>
References: <m2smqhqk4k.fsf@p4.localdomain> <20030611170246.A4187@ucw.cz> <m27k7sv5si.fsf@telia.com> <20030611203408.A6961@ucw.cz> <m23cidllv6.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m23cidllv6.fsf@telia.com>; from petero2@telia.com on Fri, Jun 13, 2003 at 11:15:57PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 11:15:57PM +0200, Peter Osterlund wrote:
> Vojtech Pavlik <vojtech@ucw.cz> writes:
> 
> > On Wed, Jun 11, 2003 at 08:16:13PM +0200, Peter Osterlund wrote:
> > 
> > > The w value is somewhat special and not really a real axis. According
> > > to the Synaptics TouchPad Interfacing Guide
> > > (http://www.synaptics.com/decaf/utilities/ACF126.pdf), W is defined as
> > > follows:
> > > 
> > > Value		Needed capability	Interpretation
> > > W = 0		capMultiFinger		Two fingers on the pad.
> > > W = 1		capMultiFinger		Three or more fingers on the pad.
> > > W = 2		capPen			Pen (instead of finger) on the pad.
> > > W = 3		Reserved.
> > > W = 4-7		capPalmDetect		Finger of normal width.
> > > W = 8-14	capPalmDetect		Very wide finger or palm.
> > > W = 15		capPalmDetect		Maximum reportable width; extremely
> > > 					wide contact.
> > > 
> > > Is there a better way than using ABS_MISC to pass the W information to
> > > user space?
> > 
> > We should probably add an EV_MSC, MSC_GESTURE event type for this.
> > That'll be the cleanest solution.
> 
> Peter Berg Larsen suggested in a private email that we shouldn't
> export W directly, because it is too synaptics specific. Better split
> it in "number of fingers" and "finger width", so that other touchpads
> could use the same format.
> 
> What do we call these things? ABS_FINGER_WIDTH and ABS_NR_FINGERS
> maybe?

Could work. Or as James Simmons suggested ABS_AREA.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
