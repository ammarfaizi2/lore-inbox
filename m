Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUDOUlX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 16:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbUDOUjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 16:39:43 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:51078 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263088AbUDOUjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 16:39:20 -0400
Date: Thu, 15 Apr 2004 16:11:43 +0200
From: Pavel Machek <pavel@suse.cz>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: Chris Lalancette <chris.lalancette@gd-ais.com>, pmarques@grupopie.com,
       linux-kernel@vger.kernel.org
Subject: Re: Memory image save/restore
Message-ID: <20040415141143.GO468@openzaurus.ucw.cz>
References: <407C18D0.9010302@gd-ais.com> <407C1D4F.4060706@grupopie.com> <407C2FF7.4010500@gd-ais.com> <20040413154832.A20467@mail.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040413154832.A20467@mail.kroptech.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >     Thanks for responding.  You are right in that the state of memory 
> > isn't the state of the entire machine; however, for instance, the 
> > swsusp2 project can save the contents of memory out to disk, go to 
> > sleep, and then resume to it later.
> 
> You're forgetting an important step. swsusp does not just haul off and
> save the contents of memory. It has to quiesce the entire system first
> by getting all hardware devices into a known state. THAT is the tricky
> bit, with deadlock lurking around every corner.
> 
> > Basically, what I am trying to do 
> > is something like swsusp2, with less restrictions; I know I have another 
> > region the size of physical memory to work with, I know I am executing 
> > from an interrupt handler, and at the end I don't want to go to sleep, 
> > just continue on.
> 
> That's relatively easy.
> 
> > Then I might want to use that memory image later.
> 
> That's hard. REALLY, REALLY hard. Impossibly hard.

Its not impossible. You basically may not write to disk after you save
snapshot... Or you can keep the logs to be able to revert disk state.
Its possible but pretty hard.

Okay, make it impossible if that machine is connected to internet.

> RAM image) and how are you going to suck all those tx'ed network packets
> back off the wire, anyway?


Heh... It would actually make for good april-fools rfc :-).


You could make machine where any action can be undone within five seconds...
...but you'd need mdelay(5000) in send packet path, and that would kind-of suck.

				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

