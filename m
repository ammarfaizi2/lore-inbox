Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262332AbTJGOrk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 10:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbTJGOrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 10:47:40 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:18927 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S262332AbTJGOri
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 10:47:38 -0400
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: Pavel Machek <pavel@ucw.cz>, "Giacomo A. Catenazzi" <cate@pixelized.ch>
Subject: Re: Can't X be elemenated?
Date: Tue, 7 Oct 2003 09:47:02 -0500
X-Mailer: KMail [version 1.2]
Cc: David Lang <david.lang@digitalinsight.com>,
       Krishna Akella <akellak@onid.orst.edu>, Paul Jakma <paul@clubi.ie>,
       kartikey bhatt <kartik_me@hotmail.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0309301209590.19804-100000@shell> <3F82780C.8080408@pixelized.ch> <20031007121825.GA323@elf.ucw.cz>
In-Reply-To: <20031007121825.GA323@elf.ucw.cz>
MIME-Version: 1.0
Message-Id: <03100709470200.30416@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 October 2003 07:18, Pavel Machek wrote:
[snip]
> > Do you want only one distribution for user, one for small companies, one
> > for schools,...? Do you want only one web server implementation? Only one
> > filesystem per task (only one journaling FS)?
> > Are they all "historical accident"?
>
> Well, I'm pretty glad there's only one glibc, and only one http
> protocol, and only one X protocol. And it would be way better if there
> was just one toolkit commonly used on Linux.
> 								Pavel
Ah... Only one sized screwdriver....

Actually, I prefer multiple -- each competing to try and gain dominance.

Motif does it all... Unfortunately, it tends to be very SLOW... and HUGE
about 3MB memory footprint (before it starts running...) the last time I
looked.

QT/GTK... originally designed for different purposes. QT had "propriataryness"
taint at the time, and GTK came from the GIMP style (and without the taint).
I believe these were aimed at supporting C++ coding, and less about 
portability to other Unixes.. (QT/GTK wouldn't even compile on SGI/Solaris at
the time - they should by now)

Both are nearly equal now (due to common goals), though cut/paste could be
improved (same is true with Motif - and I know focus control is terrible in
Motif; they even document that it is unreliable).

And yet.. there are times when I need something VERY light weight, and
globally portable. So I started my own for a specific application where
cut/past don't apply (xdm/screen locking). For the reasons of avoiding
NFS/shared library access problems, I staticly link xdm. That was where
I first saw the bloat with Motif. (I HAD to use the shared libraries).
Static linking with my application specific toolkit gave the binary
the same size (within 10k) of the Motif equivalent... but not when the
shared libaries were included.

A focused. application specific toolkit can be very small. Mine is only 6,141
lines long. Quite fast, and does everything needed for a Kerberos 5 aware
xdm, with hardware preauthentication. Even provides an updated issue file
(required by the lawyers).

Do I intend this to be general purpose? Hell no. But the others just didn't
meet the requirements. I like xaw (and the 3d extensions were nice). Too bad
it isn't being supported anymore.
