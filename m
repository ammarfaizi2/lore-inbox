Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265541AbTFMVfo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 17:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265540AbTFMVfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 17:35:44 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:55814 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265541AbTFMVfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 17:35:42 -0400
Date: Fri, 13 Jun 2003 22:49:27 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Peter Osterlund <petero2@telia.com>
cc: Vojtech Pavlik <vojtech@ucw.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Peter Berg Larsen <pebl@math.ku.dk>
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
In-Reply-To: <m23cidllv6.fsf@telia.com>
Message-ID: <Pine.LNX.4.44.0306132249070.29353-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


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

ABS_AREA


