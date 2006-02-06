Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbWBFVI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWBFVI5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 16:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWBFVI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 16:08:56 -0500
Received: from atpro.com ([12.161.0.3]:24326 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S964830AbWBFVIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 16:08:54 -0500
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Mon, 6 Feb 2006 16:07:36 -0500
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@suspend2.net>, suspend2-devel@lists.suspend2.net,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060206210736.GB12270@voodoo>
Mail-Followup-To: "Rafael J. Wysocki" <rjw@sisk.pl>,
	Nigel Cunningham <nigel@suspend2.net>,
	suspend2-devel@lists.suspend2.net, Pavel Machek <pavel@ucw.cz>,
	linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602041818.57278.rjw@sisk.pl> <200602060943.19774.nigel@suspend2.net> <200602060056.43672.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602060056.43672.rjw@sisk.pl>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/06 12:56:43AM +0100, Rafael J. Wysocki wrote:
> > > > Oh. What's Pavel's solution? Fail freezing if uninterruptible threads
> > > > don't freeze?
> > >
> > > Yes.
> > >
> > > AFAICT it's to avoid situations in which we would freeze having a
> > > process in the D state that holds a semaphore or a mutex neded for
> > > suspending or resuming devices (or later on for saving the image etc.).
> > >
> > > [I didn't answer this question previously, sorry.]
> > 
> > S'okay. This thread is an ocotpus :)
> > 
> > Are there real life examples of this? I can't think of a single time that 
> > I've heard of something like this happening. I do see rare problems with 
> > storage drivers not having driver model support right, and thereby causing 
> > hangs, but that's brokenness in a completely different way.
> > 
> > In short, I'm wondering if (apart from the forking issue), this is a straw 
> > man.
> 
> It doesn't seem to be very probable to me too, but I take this argument
> as valid.
> 
> Greetings,
> Rafael

CIFS was good for that, if you have a CIFS filesystem mounted and
take the network interface down (which I have my hibernate script do)
before the filesystem is umounted it'll become impossible to umount
the filesystem until the next reboot and I believe the cifsd kernel
thread will be unfreezable. It's been a while since I've done that
so it might be fixed now, but someone should verify it if it still
exists and potentially work with the CIFS people to get it fixed.

Jim.
