Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277861AbRJRRxc>; Thu, 18 Oct 2001 13:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277868AbRJRRxW>; Thu, 18 Oct 2001 13:53:22 -0400
Received: from marty.infinity.powertie.org ([63.105.29.14]:36358 "HELO
	marty.infinity.powertie.org") by vger.kernel.org with SMTP
	id <S277861AbRJRRxL>; Thu, 18 Oct 2001 13:53:11 -0400
Date: Thu, 18 Oct 2001 10:38:08 -0700 (PDT)
From: Patrick Mochel <mochelp@infinity.powertie.org>
To: Jonathan Lundell <jlundell@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] New Driver Model for 2.5
In-Reply-To: <p05100303b7f4b90ab170@[207.213.214.37]>
Message-ID: <Pine.LNX.4.21.0110181034050.16868-100000@marty.infinity.powertie.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Thu, 18 Oct 2001, Jonathan Lundell wrote:

> At 11:08 AM -0500 10/18/01, Taral wrote:
> >On Wed, Oct 17, 2001 at 04:52:29PM -0700, Patrick Mochel wrote:
> >>  When a suspend transition is triggered, the device tree is walked first to
> >>  save the state of all the devices in the system. Once this is complete, the
> >>  saved state, now residing in memory, can be written to some non-volatile
> >>  location, like a disk partition or network location.
> >>
> >>  The device tree is then walked again to suspend all of the devices. This
> >>  guarantees that the device controlling the location to write the state is
> >>  still powered on while you have a snapshot of the system state.
> >
> >Aha! A much nicer solution to the problem the ACPI people are having
> >with suspend/resume (ordering problems).
> 
> What happens to state changes between the first and second traversal 
> of the device tree?

State changes of what?

After the first walk (save_state), you essentially have a snapshot of the
system in memory which can be written to disk, memory, etc.

Once that is done, you disable interrupts and walk the tree again to power
off devices. 

	-pat

