Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264111AbTDXUMo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 16:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264142AbTDXUMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 16:12:44 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:35079 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264111AbTDXUMm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 16:12:42 -0400
Date: Thu, 24 Apr 2003 16:19:42 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "Kevin P. Fleming" <kpfleming@cox.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
cc: LKML <linux-kernel@vger.kernel.org>,
       =?iso-8859-2?Q?Pawe=B3_Go=B3aszewski?= <blues@ds.pg.gda.pl>,
       Dave Mehler <dmehler26@woh.rr.com>
Subject: Re: 2.5.68 kernel no initrd
In-Reply-To: <1051134842.652.6.camel@teapot.felipe-alfaro.com>
Message-ID: <Pine.LNX.3.96.1030424161618.11351B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Apr 2003, Kevin P. Fleming wrote:

> Valdis.Kletnieks@vt.edu wrote:
> 
> > On Wed, 23 Apr 2003 15:49:54 +0200, =?ISO-8859-2?Q?Pawe=B3_Go=B3aszewski?= said:
> > 
> >>initrd gives much more flexibility.
> >>I can make one kernel and use it on _all_ of my mashines, just change 
> >>initrd. quick, nice and flexible with proper initrd tools set.
> > 
> > 
> > Amen.  initrd isn't just for modules - I'd not need an initrd at all if I could
> > figure out how to start up an LVM volume group from kernelspace - I suspect
> > people with / on a RAID disk have similar issues...
> > 
> 
> Well, even though I'm working on a solution to that, it still involves 
> early userspace, just not the heavyweight "fake root" userspace that an 
> initrd represents. This is what the initramfs technology in 2.5.X is 
> for, so eventually (soon, hopefully) you'll be able to start md devices, 
> LVM volume groups, etc. from early userspace and not have to have any 
> autostart logic in the kernel nor will you have build and maintain an 
> initrd separate from the kernel.

It isn't too important where the setup resides in terms of flexibility,
the benefit comes from avoiding building one kernel for each
configuration.

On 23 Apr 2003, Felipe Alfaro Solana wrote:

> On Wed, 2003-04-23 at 15:49, Pawe³ Go³aszewski wrote:
> > initrd gives much more flexibility.
> > I can make one kernel and use it on _all_ of my mashines, just change 
> > initrd. quick, nice and flexible with proper initrd tools set.
> 
> I don't have any doubts that initrd is a very flexible solution and
> provides for a generic kernel. However, in the end (I'm talking about my
> experiences), initrd has caused me more troubles than problems it
> solved. I always keep all "config" file for every kernel I use on my
> machines.

Other than needing to build and maintain all those kernels, what does it
gain you over installing the  modules you need and having a single kernel?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

