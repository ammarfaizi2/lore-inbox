Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271515AbRIFR1H>; Thu, 6 Sep 2001 13:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271518AbRIFR0t>; Thu, 6 Sep 2001 13:26:49 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:6665 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271515AbRIFR0c>; Thu, 6 Sep 2001 13:26:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "M. Edward Borasky" <znmeb@aracnet.com>, <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() on 2.4.9/10 issue
Date: Thu, 6 Sep 2001 19:33:49 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBOEMFDKAA.znmeb@aracnet.com>
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBOEMFDKAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010906172646Z16127-26183+18@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 6, 2001 03:54 pm, M. Edward Borasky wrote:
> I'm relatively new to the Linux kernel world and even newer to the list, so
> forgive me if I'm asking a silly question or making a silly comment. It
> seems to me, from what I've seen of this discussion so far, that the only
> way one "tunes" Linux kernels at the moment is by changing code and
> rebuilding the kernel. That is, there are few "tunables" that one can set,
> based on one's circumstances, to optimize kernel performance for a specific
> application or environment.
> 
> Every other operating system that I've done performance tuning on, starting
> with Xerox CP-V in 1974, had such tunables and tools to set them. And quite
> often, some of the tuning parameters can be set "on the fly", simply by
> knowing the correct memory location to set and poking a new value into it.

We typically use proc for this, sometimes combined with an ioctl.  Some of 
these settings are standard in the kernel (bdflush, others) but more often 
you will have to apply a patch.

> No one "memory management scheme", for example, can be all things to all
> tasks, and it seems to me that giving users tools to measure and control the
> behavior of memory management, *preferably without having to recompile and
> reboot*, should be a major priority if Linux is to succeed in a wide variety
> of applications.

Linus doesn't seem to like like having tuning knobs appear where a better 
algorithm should be used instead.  Leaving the knobs out makes people work 
harder to come up with solutions that don't need them.

--
Daniel
