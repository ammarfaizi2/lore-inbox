Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272637AbTHKNlR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 09:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272584AbTHKNjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:39:20 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:30425
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S272583AbTHKNjL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:39:11 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns?=
	=?iso-8859-1?q?=20Rullg=E5rd?=),
       linux-kernel@vger.kernel.org
Subject: Re: [Swsusp-devel] Re: [PATCH] Allow initrd_load() before software_resume() (version 2)
Date: Sun, 10 Aug 2003 22:08:10 -0400
User-Agent: KMail/1.5
References: <20030801002742.1033FE8003AE@mwinf0502.wanadoo.fr> <20030806125749.GA6875@openzaurus.ucw.cz> <yw1xsmofvsd8.fsf@users.sourceforge.net>
In-Reply-To: <yw1xsmofvsd8.fsf@users.sourceforge.net>
Cc: Pavel Machek <pavel@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308102208.10588.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 August 2003 09:16, Måns Rullgård wrote:
> Pavel Machek <pavel@ucw.cz> writes:
> >> > > Okay. I hadn't tried it yet. I'll happily take up the barrow for you
> >> > > and push it to Pavel and Linus with the rest, if you like.
> >> >
> >> > Don't even think about that.
> >> >
> >> > It is not safe to run userspace *before* doing resume. You don't want
> >> > to see problems this would bring in. Forget it.
> >>
> >> so how do you resume from a partition on a device mapper volume?
> >>
> >> (and yes I basically agree with your sentiment though)
> >
> > I know very little about DM, its very well possible that resume from
> > it is not supported.
>
> Since DM requires some userspace program to set up the mappings, it
> seems to me that it wouldn't work to resume from a DM volume.  I'd
> much appreciate if it would work, somehow.

Er, query:

At some point in the vague nebulous future, after initrd has become initramfs, 
the partition detection code is scheduled to be ripped out, correct?  And 
replaced with a userspace thing run out of initrd ala hotplug and udev and 
all that?

So at that point, it's not just device mapper that's going to need something 
else to run in userspace to attach block devices to partitions.  Everything 
will.

So are you saying that swsusp is a short-term thing that will be dropped in 
2.8 because it can't be made to work?  Or that we WILL have to deal with this 
at some point, just not yet?

Rob


