Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266406AbSKLIiP>; Tue, 12 Nov 2002 03:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266399AbSKLIiO>; Tue, 12 Nov 2002 03:38:14 -0500
Received: from pieck.student.uva.nl ([146.50.96.22]:5799 "EHLO
	pieck.student.uva.nl") by vger.kernel.org with ESMTP
	id <S266406AbSKLIiL>; Tue, 12 Nov 2002 03:38:11 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Reply-To: rudmer@legolas.dynup.net
To: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [RFC] devfs API
Date: Tue, 12 Nov 2002 09:44:52 +0100
X-Mailer: KMail [version 1.3.2]
References: <20021112013244.GF1729@mythical.michonline.com> <Pine.GSO.4.21.0211112039430.29617-100000@steklov.math.psu.edu> <20021112080417.GA11660@think.thunk.org>
In-Reply-To: <20021112080417.GA11660@think.thunk.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021112083811Z266406-32598+5165@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 November 2002 09:04, Theodore Ts'o wrote:
> On Mon, Nov 11, 2002 at 08:49:22PM -0500, Alexander Viro wrote:
> > The only way I'll use devfs is
> > 	* on a separate testbox devoid of network interfaces
> > 	* with no users
> > 	* with no data - disk periodically populated from image on CD.
> > 
> > And that's regardless of that cleanup - fixing the interface doesn't solve
> > the internal races, so...
> 
> Hi Al,
> 
> It's good that you're trying to clean up the devfs code, but...
> 
> How many people are actually using devfs these days?  I don't like it
> myself, and I've had to add a fair amount of hair to fsck's
> mount-by-label/uuid code to deal with interesting cases such as
> kernels where devfs is configured, but not actually mounted (it
> changes what /proc/partitions exports).  So I'm one of those who have
> never looked all that kindly on devfs, which shouldn't come as a
> surprise to most folks.

well I like devfs, in the sense that it is really easy to see what you can 
use in /dev. Before i used devfs it could be quite difficult since there were 
so much nodes and symlinks in /dev and many have cryptic names... and 
sometimes the entries i needed simply were not there so i had to find the 
right major/minor numbers to create them...

from a user point of view it is better to keep it because it could really 
simplify a users life except ide should be just in discs as hdX and not as 
/dev/ide/hostN/busX/targetY/lunZ/disc ...

> 
> In any case, if there aren't all that many people using devfs, I can
> think of a really easy way in which we could simplify and clean up its
> API by slimming it down by 100%......

if the code is really that horrible, then maybe that is the best solution but 
again i like the concept.

	Rudmer
