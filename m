Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbUK1TFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbUK1TFQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 14:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbUK1TFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 14:05:15 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:6157 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261570AbUK1TDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 14:03:44 -0500
Date: Sun, 28 Nov 2004 20:10:39 +0100
To: Tomas Carnecky <tom@dbservice.com>
Cc: Helge Hafting <helge.hafting@hist.no>, linux-kernel@vger.kernel.org,
       greg@kroah.com, dri-devel@lists.sourceforge.net
Subject: Re: Kernel thoughts of a Linux user
Message-ID: <20041128191039.GA5580@hh.idb.hist.no>
References: <200411181859.27722.gjwucherpfennig@gmx.net> <419CFF73.3010407@dbservice.com> <41A19E44.9080005@hist.no> <41A1CAD4.20101@dbservice.com> <41A46085.5050602@hist.no> <41A470F9.4000407@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A470F9.4000407@dbservice.com>
User-Agent: Mutt/1.5.6+20040722i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 12:31:05PM +0100, Tomas Carnecky wrote:
> Helge Hafting wrote:
> >>From the [ruby patch] documentation:
> >>The main problem up to this date (November 2004) is that linux kernel 
> >>has only one behaviour regarding multiple keyboards : any key pressed 
> >>catched on any keyboard is redirected to the one and only active 
> >>Virtual Terminal (VT).
> >>
> >>Will this be changed/improved when the console code is moved into 
> >>userspace, like some have proposed?
> >
> >
> >I don't know about any userspace console, but the ruby patch lets
> >you have several independent active VTs at the same time.  So
> >the above mentioned problem is solved - they keyboards does
> >not interfere with each other.
> >
> 
> I think the it would be much nicer to habe the console code in 
> userspace, ruby is only a patch, not in the mainline kernel, and AFAIK 
> not even in any experimental (-mm/-ac/-etc) tree.

So what? 
It may not be ready for inclusion yet, how does that matter?
It is being worked on.  I see problems with a userspace implememtation,
the console have to be available - but a userspace console
can be killed.  By the never perfect OOM-killer, for example.

> There are many aproaches how to solve the problem of having more than 
> one ative VT, and the userspace console seems to be the nicest one.
> 
Why nicest?
Of course ruby isn't there right now - but is there a working
userspace console anywhere?

> I know that Jon Smirl wrote an email some time ago, here it is: 
> http://lkml.org/lkml/2004/8/2/111, look at point 15. I like the idea and 
> I've written him several times, but he didn't answer :(

Interesting ideas and many good points there.  The console is 
only a small part of it though, it seems to be mostly 
2D/3D/framebuffer/drm problems.

A console is a small thing and separating it from the rest
is a good idea. I am not so sure putting it in userspace is
though.

Helge Hafting
