Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbTEIAju (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 20:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbTEIAju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 20:39:50 -0400
Received: from chaos.analogic.com ([204.178.40.224]:42884 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262257AbTEIAjt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 20:39:49 -0400
Date: Thu, 8 May 2003 20:56:29 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Davide Libenzi <davidel@xmailserver.org>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: how to measure scheduler latency on powerpc?  realfeel doesn't
 work due to /dev/rtc issues
In-Reply-To: <20030509003825.GR8978@holomorphy.com>
Message-ID: <Pine.LNX.4.53.0305082052160.21290@chaos>
References: <3EBAD63C.4070808@nortelnetworks.com> <20030509001339.GQ8978@holomorphy.com>
 <Pine.LNX.4.50.0305081735040.2094-100000@blue1.dev.mcafeelabs.com>
 <20030509003825.GR8978@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 May 2003, William Lee Irwin III wrote:

> On Thu, May 08, 2003 at 06:12:12PM -0400, Chris Friesen wrote:
> >>> I'm trying to test the scheduler latency on a powerpc platform.  It appears
> >>> that a realfeel type of program won't work since you can't program /dev/rtc
> >>> to generated interrupts on powerpc.  Is there anything similar which could
> >>> be done?
>
> On Thu, 8 May 2003, William Lee Irwin III wrote:
> > > Why would you want to use an interrupt? Just count jiffies in sched.c
>
> On Thu, May 08, 2003 at 05:38:23PM -0700, Davide Libenzi wrote:
> > I don't know what he does mean for scheduler latency, but if it is the ctx
> > switch one something like get_cycles() will be better instead of jiffies.
>
> True, if you're looking for performance tweaks and not pathologies (which
> I was) you'll need something that accurate.
>
>
> -- wli
Does it have a printer port like the Intel machines?
If so, set it up to generate interrupts on the 'event' pin
(paper-out, etc.) and have the ISR parrot the status bits
out the printer-port bits.

Start it  up and put function generator on the event bit.
measure the delay beteen that bin and the data data bit(s)
with a 'scope. This tells you the whole story, the total
time necessary for an ISR to actually do something.



Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

