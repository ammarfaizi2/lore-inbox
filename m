Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262964AbTEMAIL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 20:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262985AbTEMAIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 20:08:11 -0400
Received: from fmr02.intel.com ([192.55.52.25]:61129 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S262964AbTEMAIK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 20:08:10 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780CCB042C@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'William Lee Irwin III'" <wli@holomorphy.com>
Cc: "'Chris Friesen'" <cfriesen@nortelnetworks.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: how to measure scheduler latency on powerpc?  realfeel doesn'
	 t work due to /dev/rtc issues
Date: Mon, 12 May 2003 17:20:39 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: William Lee Irwin III [mailto:wli@holomorphy.com]
> 
> William Lee Irwin III wrote:
> >>> I don't understand why you're obsessed with interrupts. Just run your
> >>> load and spray the scheduler latency stats out /proc/
> 
> From: Chris Friesen [mailto:cfriesen@nortelnetworks.com]
> >> I'm obsessed with interrupts because it gives me a higher sampling
rate.
> >> I could set up and itimer for a recurring 10ms timeout and see how much
> >> extra I waited, but then I can only get 100 samples/sec. With
> >> /dev/rtc (on intel) you can get 20x more samples in the same amount
> >> of time.
> 
> On Fri, May 09, 2003 at 05:39:03PM -0700, Perez-Gonzalez, Inaky wrote:
> > Okay, crazy idea here ...
> > You are talking about a bladed system, right? So probably you
> > have two network interfaces in there [it should work only with
> > one too].
> > What if you rip off the driver for the network interface and
> > create a new breed. Set an special link with a null Ethernet
> > cable and have one machine sending really short Ethernet frames
> 
> This is ridiculous. Just make sure you're not sharing interrupts and
> count cycles starting at the ISR instead of wakeup and tag events
> properly if you truly believe that to be your metric. You, as the
> kernel, are notified whenever the interrupts occur and can just look
> at the time of day and cycle counts.

Well, I am only suggesting a way to _FORCE_ interrupts to happen
at a certain rate controllable by _SOMEBODY_, not as the system
gets them. Chris was concerned about not having a way to 
_GENERATE_ interrupts at a certain rate.

What you are suggesting is the other part of the picture, how to
measure the latency and AFAICS, it is not part of the problem of
generating the interrupts.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
