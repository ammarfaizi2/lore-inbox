Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbTLPLFa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 06:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbTLPLFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 06:05:30 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:2252 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S261464AbTLPLFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 06:05:23 -0500
Date: Tue, 16 Dec 2003 12:05:21 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Message-ID: <20031216110521.GA7306@wohnheim.fh-wedel.de>
References: <20031211125806.B2422@hexapodia.org> <200312121537.42303.rob@landley.net> <20031215124752.GA27005@wohnheim.fh-wedel.de> <200312152343.11321.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200312152343.11321.rob@landley.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 December 2003 23:43:10 -0600, Rob Landley wrote:
> On Monday 15 December 2003 06:47, Jörn Engel wrote:
> 
> > Anyway, what updatedb, userspace defragmenters etc. need is a
> > notification, what has changed.
> 
> Most of this infrastructure is there already.  Documentation/dnotify.txt.

Right, although that specific implementation only cares about things
like konqueror not constantly polling one specific directory.

> > - updatedb is even worse
> > because it doesn't even notice that *anything* has changed, much less
> > what change happened.
> 
> You don't WANT it to.  You want to batch up the work so that if a file changes
> every thirty seconds you're not constantly being woken up to deal with it 
> again!

Well, *I* sure want it to.  Batching things up is fine, just the
current implementation isn't.

Yeah, it is good enough most of the time, so noone cares enough.

> > For updatedb there is.
> 
> I'm not talking about updatedb.

Then talk about checking for zero runs.  Same thing.  Either you have
to read *everything* from disk, so you don't want to do this too
often, or you need a way to figure out, what has changes since the
last run.

Or talk about updates, same thing as well.

What we do right now is basically polling, a very expensive and
therefore infrequent polling.  Sure, it works, but it's far from
perfect.


Anyway, subject has drifted away allready and we sure won't reach
agreement.  Doesn't matter anyway as long as noone provides the
patches, so let's just drop the thread, ok?

Jörn

-- 
/* Keep these two variables together */
int bar;
