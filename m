Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbUK3Ax3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbUK3Ax3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 19:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbUK3Ax3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 19:53:29 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:59083 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261915AbUK3AxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 19:53:17 -0500
Subject: Re: Suspend 2 merge: 49/51: Checksumming
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Rob Landley <rob@landley.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200411291830.33885.rob@landley.net>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <200411290455.10318.rob@landley.net>
	 <1101767472.4343.439.camel@desktop.cunninghams>
	 <200411291830.33885.rob@landley.net>
Content-Type: text/plain
Message-Id: <1101775792.4329.23.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 30 Nov 2004 11:49:52 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2004-11-30 at 10:30, Rob Landley wrote:
> On Monday 29 November 2004 07:24 pm, Nigel Cunningham wrote:
> > Hi.
> >
> > On Mon, 2004-11-29 at 20:55, Rob Landley wrote:
> > > On Wednesday 24 November 2004 08:02 am, Nigel Cunningham wrote:
> > > > A plugin for verifying the consistency of an image. Working with kdb,
> > > > it can look up the locations of variations. There will always be some
> > > > variations shown, simply because we're touching memory before we get
> > > > here and as we check the image.
> > >
> > > A while back I suggested checking the last mount time of the mounted
> > > local filesystems as a quick and dirty sanity check between loading the
> > > image and unfreezing all the processes.  (Since a read-only mount
> > > shouldn't touch this, triggering swsusp resume from userspace after
> > > prodding various hardware shouldn't cause a major problem either...) 
> > > Does that sound like a good idea?
> >
> > If I recall correctly, someone replied that even a read only mount under
> > one filesystem (XFS? Not sure), would replay the journal, so it wasn't a
> > goer.
> 
> You could always special case the broken one until they fix it... :)

Mmm. I wonder how much code that would require us to add. I do like the
idea of not interacting where the answer is obvious :>. I still think,
however, that interacting when the answer isn't obvious is the right
thing to do. Take for example the case where we find an image, but the
device numbers look like they belong to 2.4 and we're a 2.6 kernel. We
can't read the header (we can't be sure that this is the cause). The
user - or their cat - might have selected the wrong boot image
unintentionally. Why shouldn't we give them the opportunity to reboot
and get the right one?

> > > Haven't had time to look into it myself, though.  (Just recently got time
> > > enough to bang on busybox again.  Somewhere around 2.6.7, software
> > > suspend stopped working for me and I haven't even had a chance to track
> > > _that_ down yet.  Hopefully fixed in 2.6.9 or 2.6.10, I haven't played
> > > with it recently...)
> >
> > If you mean suspend2, I might be able to help if given more info.
> 
> Nah, the one that's built in.  I'll try it again when I upgrade to 2.6.10 in a 
> few days.

Okay.

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

