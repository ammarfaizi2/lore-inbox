Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVG0IID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVG0IID (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 04:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbVG0IID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 04:08:03 -0400
Received: from fsmlabs.com ([168.103.115.128]:23442 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261888AbVG0IIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 04:08:00 -0400
Date: Wed, 27 Jul 2005 02:13:12 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
cc: "Brown, Len" <len.brown@intel.com>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Variable ticks
In-Reply-To: <1122326750.1472.46.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0507270212080.7784@montezuma.fsmlabs.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B300424AC59@hdsmsx401.amr.corp.intel.com>
 <1122326750.1472.46.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jul 2005, Lee Revell wrote:

> On Mon, 2005-07-25 at 17:19 -0400, Brown, Len wrote:
> >  >>>Question one, are there other actions to consider?
> > >> 
> > >> 
> > >> Yes.
> > >> Speaking for ACPI C3 state, note that DMA also
> > >> wakes up the CPU -- even if there was no device interrupt.
> > >> (aka, "the trouble with USB")
> > >
> > >Trouble? Why would USB do DMA unless there was a device activity?
> > 
> > look here:
> > http://www.google.com/search?hl=en&q=usb+selective+suspend
> > 
> > Linux is working on it too, but it is in development.
> 
> What about audio?  If there is a sound server running then you're going
> to have a constant stream of interrupts and DMA activity from the sound
> card even if the machine is idle and there aren't any sounds playing.

Doesn't artsd at least close the audio device after some configurable idle 
time? In which case that sounds like a userspace issue.
