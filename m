Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbVKUAKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbVKUAKd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 19:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbVKUAKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 19:10:32 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:63240 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S1750799AbVKUAKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 19:10:32 -0500
From: James Cloos <cloos@jhcloos.com>
To: Kasper Sandberg <lkml@metanurb.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make kernelrelease ignoring LOCALVERSION_AUTO
In-Reply-To: <1132525898.15938.1.camel@localhost> (Kasper Sandberg's message
	of "Sun, 20 Nov 2005 23:31:38 +0100")
References: <m3acfz88qj.fsf@lugabout.cloos.reno.nv.us>
	<1132525898.15938.1.camel@localhost>
Copyright: Copyright 2005 James Cloos
X-Hashcash: 1:23:051121:lkml@metanurb.dk::rvFfEhlvtiS8QpA4:1KOjn
X-Hashcash: 1:23:051121:linux-kernel@vger.kernel.org::+TqsOjs+J+eviWXF:000000000000000000000000000000000qQWT
Date: Sun, 20 Nov 2005 19:10:07 -0500
Message-ID: <m3sltq7teo.fsf@lugabout.cloos.reno.nv.us>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/23.0.0 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Kasper" == Kasper Sandberg <lkml@metanurb.dk> writes:

Kasper> (its what i do in my kernel install script)
Kasper> evan $(head -n 4 Makefile | sed -e 's/ //g')

Kasper> then in bash you can do this:
Kasper> FULLVER=${VERSION}.${PATCHLEVEL}.${SUBLEVEL}${EXTRAVERSION}

That is like what I used to do.  I switched to $(make kernelrelease)
to deal with LOCALVERSION (which I use via a file) and now the auto
localversion (which adds a ref to the most recent git commit in the
compiling tree).

I did do the bisect (I cannot exaggerate how much faster is was after
a $(git-repack -a -d && git-prune-packed).  Bigger than W.E.Coyote w/
a broken leg vs R.R in overdrive. :)

I'm posting the details separately.

-JimC
-- 
James H. Cloos, Jr. <cloos@jhcloos.com>
