Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbTI2I7f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 04:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbTI2I7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 04:59:34 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:28032
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262913AbTI2I7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 04:59:32 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Larry McVoy <lm@bitmover.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: log-buf-len dynamic
Date: Mon, 29 Sep 2003 03:56:27 -0500
User-Agent: KMail/1.5
References: <m1n0csiybu.fsf@ebiederm.dsl.xmission.com> <20030925122838.A16288@discworld.dyndns.org> <20030925182921.GA18749@work.bitmover.com>
In-Reply-To: <20030925182921.GA18749@work.bitmover.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309290356.27600.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 September 2003 13:29, Larry McVoy wrote:
> On Thu, Sep 25, 2003 at 12:28:38PM -0600, Charles Cazabon wrote:
> > Perhaps BitMover could release a client that can't do anything but keep a
> > local (unmodified) tree in sync with a public repository tree, so that
> > the "politically objectionable" (to some) parts of the BK license don't
> > matter.
> >
> > In an idea world, this read-only client could be released in source form,
> > but I'm under no illusions there :).
>
> People ask us for this all the time and it just highlights the point that
> people don't understand how BK works.  It isn't client server, it's peer
> to peer, every so-called client has to have all the smarts built in that
> the so-called server has.
>
> There isn't any way to release a stripped down version that makes sense.
> If there was, we would.

I'm under the impression that the real smarts of bitkeeper is keeping a huge 
database of independent changes and only making a tree out of them when you 
ask to see the thing.  I.E. bitkeeper is a huge pile of merge logic that can 
take into account not just what the tree looks like now, but everything the 
tree has _ever_ looked like.

So a read-only client still needs all this merge logic.  Export is the easy 
part.  VIEW is the hard part.  The protocols to marshall the patches from 
point A to point B are almost irrelevant, it's sorting and integrating them 
into something useful that requires work.

And the reason Andrea hasn't found bitkeeper to be nicer than CVS is he isn't 
trying to integrate the work of 300 other developers into his personal tree 
simultaneously.  BK is really just a merging tool that fixes rejects 
automatically, everything else is details...

Am I wrong?

Rob
