Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318838AbSHREJZ>; Sun, 18 Aug 2002 00:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318839AbSHREJZ>; Sun, 18 Aug 2002 00:09:25 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:19072 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S318838AbSHREJY>;
	Sun, 18 Aug 2002 00:09:24 -0400
Date: Sat, 17 Aug 2002 23:07:02 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Scott Bronson <bronson@rinspin.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE?  IDE-TNG driver
In-Reply-To: <1029642451.1599.2.camel@emma>
Message-ID: <Pine.LNX.4.44.0208172253070.1556-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Aug 2002, Scott Bronson wrote:

> > Everyone I've heard advocating a moduleless kernel uses an argument that
> > boils down to "it's slightly more secure."  Does anybody have a GOOD
> > reason for not using modules?  Obsolete or embedded hardware arguments
> > don't count.
> 
> Someone replied off-list saying that initrds are too hard to create.
> 
> That's true.  They are.  One day, hopefully that will change.
> 
> Any other reasons?

Wouldn't the logic be a lot simpler if kernel developers didn't have to 
worry about whether their module was built in or inserted at some point in 
the future?  All the bits could be assembled and symbols would be resolved 
at compile time.

ICBW but it appears the largest percentage of users have modules inserted 
at boot time, never to be ejected or disturbed.  The modules might as well 
be built in.

I've never really grokked the whole initrd anyway.  What is the point of 
building a kernel minus the bits it needs to actually boot the system?  
That just forces this ludicrous jerry-rigged mess to provide the 
capabilities that should have been built in at compile time.

Of course, we're never going to get away from modules now anyway, so the 
argument is probably moot.  With PCCARD, USB, Firewire, and Hotplug PCI 
there are too many ways to add components not present when the system is 
built on an adhoc basis.  The alternative would be a bloated monstrosity 
with dead code not needed by most people.  I remember my early days of 
Linux and seeing literally dozens of kernels compiled with different 
options, with no clue how to choose the right one for my system.

