Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264496AbTIDBHM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 21:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264497AbTIDBHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 21:07:12 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:52608 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264496AbTIDBHJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 21:07:09 -0400
Date: Wed, 3 Sep 2003 18:06:53 -0700
From: Larry McVoy <lm@bitmover.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Brown, Len" <len.brown@intel.com>,
       Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
Message-ID: <20030904010653.GD5227@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Brown, Len" <len.brown@intel.com>,
	Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030903180037.GP4306@holomorphy.com> <20030903180547.GD5769@work.bitmover.com> <20030903181550.GR4306@holomorphy.com> <1062613931.19982.26.camel@dhcp23.swansea.linux.org.uk> <20030903194658.GC1715@holomorphy.com> <105370000.1062622139@flay> <20030903212119.GX4306@holomorphy.com> <115070000.1062624541@flay> <20030903215135.GY4306@holomorphy.com> <116940000.1062625566@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <116940000.1062625566@flay>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a thought.  Maybe the next kernel summit needs to have a CC cluster
BOF or whatever.  I'd be happy to show up, describe what it is that I see
and have you all try and poke holes in it.  If the net result was that you
walked away with the same picture in your head that I have that would be
cool.  Heck, I'll sponser it and buy beer and food if you like.

On Wed, Sep 03, 2003 at 02:46:06PM -0700, Martin J. Bligh wrote:
> >> That's where I disagree - it's much easier for the USER because an SSI
> >> cluster works out all the load balancing shit for itself, instead of
> >> pushing the problem out to userspace. It's much harder for the KERNEL
> >> programmer, sure ... but we're smart ;-) And I'd rather solve it once,
> >> properly, in the right place where all the right data is about all
> >> the apps running on the system, and the data about the machine hardware.
> > 
> > This is only truly feasible when the nodes are homogeneous. They will
> > not be as there will be physical locality (esp. bits like device
> > proximity) concerns.
> 
> Same problem as a traditonal set up of a NUMA system - the scheduler
> needs to try to move the process closer to the resources it's using.
> 
> > It's vaguely possible some kind of punting out
> > of the kernel of the solutions to these concerns is possible, but upon
> > the assumption it will appear, we descend further toward science fiction.
> 
> Nah, punting to userspace is crap - they have no more ability to solve
> this than we do on any sort of dynamic worseload, and in most cases,
> much worse - they don't have the information that the kernel has available,
> at least not on a timely basis. The scheduler belongs in the kernel,
> where it can balance decisions across all of userspace, and we have
> all the info we need rapidly and efficiently available.
>  
> > Some of these proposals also beg the question of "who's going to write
> > the rest of the hypervisor supporting this stuff?", which is ominous.
> 
> Yeah, it needs lots of hard work by bright people. It's not easy.
> 
> M.

-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
