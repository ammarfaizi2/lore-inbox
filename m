Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261745AbRESKWN>; Sat, 19 May 2001 06:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261746AbRESKWE>; Sat, 19 May 2001 06:22:04 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21264 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261745AbRESKVt>; Sat, 19 May 2001 06:21:49 -0400
Date: Sat, 19 May 2001 12:21:47 +0200
From: Pavel Machek <pavel@suse.cz>
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010519122147.B31814@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010515145830.Y5599@sventech.com> <Pine.LNX.4.21.0105151208540.2339-100000@penguin.transmeta.com> <20010515154325.Z5599@sventech.com> <20010517102029.A44@toy.ucw.cz> <20010518133250.O32405@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010518133250.O32405@sventech.com>; from johannes@erdfelt.com on Fri, May 18, 2001 at 01:32:51PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > But no, I don't actually like sockets all that much myself. They are hard
> > > > to use from scripts, and many more people are familiar with open/close and
> > > > read/write.
> > > 
> > > Agreed.
> > > 
> > > It would be nice to use open/close/read/write for control and bulk and
> > > sockets for interrupt and isochronous.
> > 
> > What makes interrupt so different? Last time I checked int pipes were very
> > similar to bulk pipes... Do you care about "packet boundaries"? You can
> > somehow emulate with read, too...
> 
> We probably could. It would have interesting semantics however. We would
> have to have an ioctl or something else to specify period, and if it's
> one shot, etc.

ioctl for specifying period seems okay to me, and I believe UDP
sockets already have very similar semantics for read/write.

> We could probably shoehorn isochronous semantics onto read/write as
> well, but I don't want to begin to think how ugly that'll be.

What's the problem?

> A completely ioctl solution would work better in that case since it's
> cleaner. The only problem would be the fact it's called ioctl.

I do not think it is cleaner. Could AF_USB be used to get "clean"
solution?
								Pavel
-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
