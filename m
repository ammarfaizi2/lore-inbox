Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131006AbRBNJDk>; Wed, 14 Feb 2001 04:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131761AbRBNJDa>; Wed, 14 Feb 2001 04:03:30 -0500
Received: from host217-32-162-13.hg.mdip.bt.net ([217.32.162.13]:19204 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S131006AbRBNJDR>;
	Wed, 14 Feb 2001 04:03:17 -0500
Date: Wed, 14 Feb 2001 09:05:05 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: John Levon <moz@compsoc.man.ac.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch-2.4.1-ac10] unsetting TASK_RUNNING
In-Reply-To: <Pine.LNX.4.21.0102131701010.9400-100000@mrworry.compsoc.man.ac.uk>
Message-ID: <Pine.LNX.4.21.0102140900130.1203-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2001, John Levon wrote:
> I had a similar set of patches a while ago. I had several more unnecessary settings.
> 
> At least Matthew Dharm as usb-storage maintainer wanted to keep his in. Of more
> concern IMHO were the drivers busy waiting by failing to reset current->state
> on each iteration - e.g. maestro2, maestro3.
> 
> The patches I sent (out dated, and some of it buggy) are at :
> 
> http://www.movement.uklinux.net/patches/kernel/schedule1.diff
> http://www.movement.uklinux.net/patches/kernel/schedule2.diff
> http://www.movement.uklinux.net/patches/kernel/schedule3.diff
> http://www.movement.uklinux.net/patches/kernel/schedule4.diff
> 
> for your reference. The last is similar to your patch.
> 

Ok, good -- so why aren't your patches already in the kernel?

Also, I think the concept of "maintainer of some part of Linux" means (or
should mean) a person who has the intimate knowledge of a particular
subject and is responsible for fixing bugs in that particular piece of
software. This should add the burden but should _not_ give the person
right to decide that the bugs should be left there. In other words, no
maintainer should be allowed to say "I want to keep this line of code
there" if such line serves no purpose and only adds confusion to people
reading the code.

At least that is how I treat myself wrt maintaining microcode driver and
BFS -- everyone in the world is welcome to find bugs in them and _mandate_
that I accept the fixes (if they are correct) -- I have no right to
neglect them.

Regards,
Tigran


