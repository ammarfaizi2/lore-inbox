Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263221AbTJPXfl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 19:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263224AbTJPXfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 19:35:41 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:59654 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S263221AbTJPXfj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 19:35:39 -0400
Date: Thu, 16 Oct 2003 16:35:33 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] frandom - fast random generator module
Message-ID: <20031016233533.GD29279@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <3F8E552B.3010507@users.sf.net> <3F8E58A9.20005@cyberone.com.au> <3F8E70E0.7070000@users.sf.net> <3F8E8101.70009@pobox.com> <20031016173135.GL5725@waste.org> <3F8F23BE.7020703@users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8F23BE.7020703@users.sf.net>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This Outlook installation has been found to be susceptible to misuse.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 17, 2003 at 01:03:26AM +0200, Eli Billauer wrote:
> Matt Mackall wrote:
> 
> >On Thu, Oct 16, 2003 at 07:29:05AM -0400, Jeff Garzik wrote:
> > 
> >
> >>So, given that trend and also given the existing /dev/[u]random, I 
> >>disagree completely:  /dev/frandom is the perfect example of something 
> >>that should _not_ be in the kernel.  If you want /dev/urandom faster, 
> >>then solve _that_ problem.  Don't try to solve a /dev/urandom problem by 
> >>creating something totally new.
> >>   
> >>
> >
> >I have some performance fixes for /dev/urandom, but there's a fair
> >amount of other cleanup that has to go in first.
> >
> ... and this reminded me that I originally wanted to patch random.c, and 
> change the algorithm to the faster one. To my best understanding, there 
> would be no degradation in random quality, assuming I would do it 
> correctly (and not being hung for the nerve to do it). But that's the 
> problem: What if I got something wrong?
> 
> If a hardware device driver is buggy, you usually know about it sooner 
> or later. If an RNG has a rare bug, or an architecture-dependent flaw, 
> it's much harder to notice. If the RNG starts to repeat itself, you 
> won't know about it, unless you happened to test exactly that data. The 
> algorithm may be perfect, but a silly bug can blow it all.
> 
> So personally, I wouldn't touch the urandom code, not even the smallest 
> fix. Instead, I decided to write another RNG, which doesn't interfere 
> with the existing one. The only way to be confident about it, is to give 
> it mileage. And that means making it available for broad use.
> 
> Which is why I originally offered frandom as a supplement, not an 
> alternative.

Sounds like a case for having a config choice for which
urandom code to build in.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
