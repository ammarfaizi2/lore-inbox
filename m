Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUF0JOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUF0JOs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 05:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUF0JOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 05:14:48 -0400
Received: from mail008.syd.optusnet.com.au ([211.29.132.212]:44265 "EHLO
	mail008.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261426AbUF0JOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 05:14:46 -0400
Date: Sun, 27 Jun 2004 19:14:36 +1000 (EST)
From: Con Kolivas <kernel@kolivas.org>
To: Michael Buesch <mbuesch@freenet.de>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Willy Tarreau <willy@w.ods.org>
Subject: Re: [PATCH] Staircase scheduler v7.4
In-Reply-To: <200406261929.35950.mbuesch@freenet.de>
Message-ID: <Pine.LNX.4.58.0406271913280.29181@kolivas.org>
References: <200406251840.46577.mbuesch@freenet.de> <200406252148.37606.mbuesch@freenet.de>
 <1088212304.40dccd5035660@vds.kolivas.org> <200406261929.35950.mbuesch@freenet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jun 2004, Michael Buesch wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Saturday 26 June 2004 03:11, you wrote:
> > Quoting Michael Buesch <mbuesch@freenet.de>:
> > > But as the load grows, the system is usable as with load 0.0.
> > > And it really should be usable with 76.0% nice. ;) No problem here.
> > > This really high load is not correct.
> >
> > There was the one clear bug that Adrian Drzewiecki found (thanks!) that is easy
> > to fix. Can you see if this has any effect before I go searching elsewhere?
> >
> > Con
> >
> 
> The problem did not go away with this patch.
> I did some stress test:
> 
> I downloaded latest kdeextragear-3 package from CVS and
> ran ./configure script many times.
> Directly after booting the script runs fine.
> But as the uptime increases (I'm now at 15 minutes, when
> the script is stuck completely for the first time),
> my problem gets worse.
> At the very beginning, there was no problem running the script,
> but over time problems increased with uptime.
> on 5 till 10 minutes of uptime, the configure began to
> stuck for 3 or 4 seconds on several (reproducable!) places.#
> (you can see these places as nice "holes" in the CPU graph
> of gkrellm)
> Now (15 min) it's completely stuck and doesn't get a timeslice.
> 
> Now another "problem":
> Maybe it's because I'm tired, but it seems like
> your fix-patch made moving windows in X11 is less smooth.
> I wanted to mention it, just in case there's some other
> person, who sees this behaviour, too. In case I'm the
> only one seeing it, you may forget it. ;)

Almost certainly they are one and the same thing. I have been away and 
unable to attend to this just yet but it appears there's some sanity check 
missing from the "I've just forked" logic I introduced to 7.4. I'll look 
into it further asap.

Con
