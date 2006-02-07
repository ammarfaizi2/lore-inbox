Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965249AbWBGPPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965249AbWBGPPT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 10:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965151AbWBGPPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 10:15:18 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:5556 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965155AbWBGPPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 10:15:17 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.
Date: Tue, 7 Feb 2006 16:16:56 +0100
User-Agent: KMail/1.9.1
Cc: suspend2-devel@lists.suspend2.net,
       "Jim Crilly" <jim@why.dont.jablowme.net>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060206210736.GB12270@voodoo> <200602071016.22240.nigel@suspend2.net>
In-Reply-To: <200602071016.22240.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071616.57759.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 07 February 2006 01:16, Nigel Cunningham wrote:
> On Tuesday 07 February 2006 07:07, Jim Crilly wrote:
> > On 02/06/06 12:56:43AM +0100, Rafael J. Wysocki wrote:
> > > > > > Oh. What's Pavel's solution? Fail freezing if uninterruptible
> > > > > > threads don't freeze?
> > > > >
> > > > > Yes.
> > > > >
> > > > > AFAICT it's to avoid situations in which we would freeze having a
> > > > > process in the D state that holds a semaphore or a mutex neded for
> > > > > suspending or resuming devices (or later on for saving the image
> > > > > etc.).
> > > > >
> > > > > [I didn't answer this question previously, sorry.]
> > > >
> > > > S'okay. This thread is an ocotpus :)
> > > >
> > > > Are there real life examples of this? I can't think of a single time
> > > > that I've heard of something like this happening. I do see rare
> > > > problems with storage drivers not having driver model support right,
> > > > and thereby causing hangs, but that's brokenness in a completely
> > > > different way.
> > > >
> > > > In short, I'm wondering if (apart from the forking issue), this is a
> > > > straw man.
> > >
> > > It doesn't seem to be very probable to me too, but I take this
> > > argument as valid.
> > >
> > > Greetings,
> > > Rafael
> >
> > CIFS was good for that, if you have a CIFS filesystem mounted and
> > take the network interface down (which I have my hibernate script do)
> > before the filesystem is umounted it'll become impossible to umount
> > the filesystem until the next reboot and I believe the cifsd kernel
> > thread will be unfreezable. It's been a while since I've done that
> > so it might be fixed now, but someone should verify it if it still
> > exists and potentially work with the CIFS people to get it fixed.
> 
> Thanks for the pointer. I'll take a look at this.

Yes, that's interesting.  If we have an actual test case, it'll help us a lot.

Greetings,
Rafael
