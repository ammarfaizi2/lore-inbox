Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWEBTF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWEBTF0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 15:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbWEBTF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 15:05:26 -0400
Received: from relais.videotron.ca ([24.201.245.36]:44413 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750873AbWEBTFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 15:05:23 -0400
Date: Tue, 02 May 2006 15:05:22 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: sched_clock() uses are broken
In-reply-to: <20060502185555.GB4223@flint.arm.linux.org.uk>
X-X-Sender: nico@localhost.localdomain
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.64.0605021503230.28543@localhost.localdomain>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_5pYBS5ac+jZyyJ4H2Y3NRw)"
References: <20060502132953.GA30146@flint.arm.linux.org.uk>
 <p73slns5qda.fsf@bragg.suse.de> <20060502165009.GA4223@flint.arm.linux.org.uk>
 <200605021901.13882.ak@suse.de>
 <Pine.LNX.4.64.0605021316380.28543@localhost.localdomain>
 <20060502185555.GB4223@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_5pYBS5ac+jZyyJ4H2Y3NRw)
Content-type: TEXT/PLAIN; charset=iso-8859-1
Content-transfer-encoding: 8BIT

On Tue, 2 May 2006, Russell King wrote:

> On Tue, May 02, 2006 at 01:18:25PM -0400, Nicolas Pitre wrote:
> > On Tue, 2 May 2006, Andi Kleen wrote:
> > 
> > > On Tuesday 02 May 2006 18:50, Russell King wrote:
> > > 
> > > > You're right assuming you have a 64-bit TSC, but ARM has at best a
> > > > 32-bit cycle counter which rolls over about every 179 seconds - with
> > > > gives a range of values from sched_clock from 0 to 178956970625 or
> > > > 0x29AAAAAA81.
> > > > 
> > > > That's rather more of a problem than having it happen every 208 days.
> > > 
> > > Ok but you know it's always 32bit right? You can fix it up then
> > > with your proposal of a sched_diff()
> > > 
> > > The problem would be fixing it up with a unknown number of bits.
> > 
> > Just shift it left so you know you always have the most significant bits 
> > valid.  The sched_diff() would take care of scaling it back to nanosecs.
> 
> sched_clock is currently defined to return nanoseconds so this isn't
> a possibility.

If we're discussing the addition of a sched_clock_diff(), why whouldn't 
shed_clock() return anything it wants in that context?  It could be 
redefined to have a return value meaningful only to shed_clock_diff()é


Nicolas

--Boundary_(ID_5pYBS5ac+jZyyJ4H2Y3NRw)--
