Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUCHJh1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 04:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbUCHJh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 04:37:27 -0500
Received: from 18-165-237-24-mvl.nwc.gci.net ([24.237.165.18]:16545 "EHLO
	nevaeh-linux.org") by vger.kernel.org with ESMTP id S262328AbUCHJhZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 04:37:25 -0500
Date: Mon, 8 Mar 2004 00:37:29 -0900 (AKST)
From: Arthur Corliss <corliss@digitalmages.com>
X-X-Sender: acorliss@bifrost.nevaeh-linux.org
To: Tim Schmielau <tim@physik3.uni-rostock.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.6.x BSD Process Accounting w/High UID
In-Reply-To: <Pine.LNX.4.53.0403080921420.6609@gockel.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.58.0403080016290.15716@bifrost.nevaeh-linux.org>
References: <Pine.LNX.4.44.0403041451360.20043-100000@chimarrao.boston.redhat.com>
 <Pine.LNX.4.58.0403041103500.24930@bifrost.nevaeh-linux.org>
 <Pine.LNX.4.53.0403042242190.29818@gockel.physik3.uni-rostock.de>
 <Pine.LNX.4.58.0403041324330.20616@bifrost.nevaeh-linux.org>
 <Pine.LNX.4.53.0403071820190.32060@gockel.physik3.uni-rostock.de>
 <Pine.LNX.4.58.0403071535290.1733@bifrost.nevaeh-linux.org>
 <Pine.LNX.4.53.0403080921420.6609@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Mar 2004, Tim Schmielau wrote:

> Seems like I didn't get your point. What is broken on x86 other than high
> UIDs?

I don't want to have us start talking in circles.  As someone else pointed out
there's the time issues along with the uid/gid.  Both are admittedly only
broken in corner cases not typically seen in the average server.

> In which way are the BSD accounting tools broken? I'm unfamiliar with
> them, but this might indeed allow us to estimate the user base.

The 'last' tool seems to have, at a minimum, some formatting issues.  I don't
think anyone would have noticed since most distros seem to use the one bundled
with sysvinit, instead.  The dump-utmp utility seems to share the problem in
that it doesn't print out completely useable/parseable output.

> The chunk with the 64-bit comment actually is independent of the high UID
> problem. It's there to prevent logging of wromng data on 64-bit arches,
> and is completely optimized away by the compiler on 32 bit ones.
> I could as well separate it into a different patch.
>
> I'll do a new version of the patch anyways, as I missed to change another
> comment.

Gotcha.  I'll shut up, now.  ;-)

> Yes, but how often do your users use more that 49 days of cputime?

I'm just being pendantic.  I completely agree that a field with no predefined
range has to be capped.  However, as a sys-admin I would say that I would
still find such long windows useful if someone was complaining about an
outtage for a service that basically only gets stopped/restarted during system
reboots.  You could easily see what the history of interruptions would be for
those services.

> I'll wait a bit to see whether my other posting generates any feedback.

I'll wait as well. I'm very eager to see (at least) the uid issue resolved so
I don't have to keep hacking up kernel/glibc headers on new deployments.

	--Arthur Corliss
	  Bolverk's Lair -- http://arthur.corlissfamily.org/
	  Digital Mages -- http://www.digitalmages.com/
	  "Live Free or Die, the Only Way to Live" -- NH State Motto
