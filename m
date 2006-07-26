Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751740AbWGZSQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbWGZSQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 14:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751741AbWGZSQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 14:16:59 -0400
Received: from cattelan-host201.dsl.visi.com ([208.42.117.201]:23781 "EHLO
	slurp.thebarn.com") by vger.kernel.org with ESMTP id S1751739AbWGZSQ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 14:16:58 -0400
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
	regarding reiser4 inclusion
From: Russell Cattelan <cattelan@thebarn.com>
To: Hans Reiser <reiser@namesys.com>
Cc: David Masover <ninja@slaphack.com>, Jeff Garzik <jeff@garzik.org>,
       Theodore Tso <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <44C77B8A.7090303@namesys.com>
References: <44C12F0A.1010008@namesys.com> <20060722130219.GB7321@thunk.org>
	 <44C26F65.4000103@namesys.com> <44C28A8F.1050408@garzik.org>
	 <44C32348.8020704@namesys.com>
	 <1153854781.5893.5.camel@xenon.msp.redhat.com>
	 <44C6AE9E.6020300@slaphack.com>  <44C77B8A.7090303@namesys.com>
Content-Type: text/plain
Date: Wed, 26 Jul 2006 13:16:27 -0500
Message-Id: <1153937787.25828.51.camel@xenon.msp.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-26 at 08:26 -0600, Hans Reiser wrote:
> David Masover wrote:
> 
> >
> >
> >Although I should mention, Hans, that there is a really good reason to
> >prefer the 15 minute patches.  The patches that take a week are much
> >harder to read during that week than any number of 15 minute incremental
> >patches, because the incremental patches are already broken down into
> >nice, small, readable, ordered chunks.  And since development follows
> >some sort of logical, orderly pattern, it can be much easier to read it
> >that way than to try to consider the whole.
> >  
> >
> No, I disagree, if the code is well commented, it is easier to read the
> whole thing at the end when it has its greatest coherence and
> refinement.  A problem with Reiser4 is that its core algorithms are
> simply complex.  We pushed the envelope in multiple areas all at once.
> Benchmarks don't always suggest simple algorithms are the ones that will
> be highest performance.  Tree algorithms are notorious in the database
> industry for being simple on web pages but complex as code.
> 
> Some people program in small increments, some program things that
> require big increments of change, both kinds of people are needed.
> 
FWIW I think both points are valid.
 
Personally I find it difficult to completely stop what I'm doing 
and spend several days studying a large patch/complete new subsystem.

But on the other hand it's important that code that goes in the kernel 
gets a proper review, I think we all come to rely on the gatekeepers job
of making sure any given part of the kernel does not destabilize to the 
point were it interferes with our individual areas of development.

So exactly what level of granularity is appropriate  for changes? Well
that should probably be left of to the gatekeeper for each particular
area. In the case of filesystems generic vfs changes obviously need to 
be small and easy to digest, and more importantly easy to bisect
regressions. The core of the file system can be left to the person who
can best manage the code, but hopefully that person applies a reasonable
of granularity to the changes, thus allowing non familiar developers to
at least keep up and possibly make helpful suggestions.

If we look at the current "beliefs" surrounding XFS you can see the
affects of a code base that did not have an incremental development with
regards to linux anyways. Ok so ya XFS was a close sourced IRIX FS for
the first 8 years of it's life, and even once the Linux project started
there was another year or so encumbrance investigation and cleaning
before legal would sign off on its release.
So to this day the major hang up with XFS seems to be "it's to complex
because it has x thousands lines of code".  Hell by that argument Linux
has way more lines of code than IRIX could ever hope to have and is
therefore Linux is more complex than IRIX and to hard to understand. :-)
Fortunately many developers (especially ones that have worked on other
OS's) do not use "wc -l" as a tool to measure code
quality/readability/complexity. 
XFS unfortunately will probably always suffer from skepticism since
it did not grow up in in Linux.

Guess it's sort of like adopting a 8 year old child vs a new born, hard
to tell what happened in first 8 years.

-Russell Cattelan
cattelan@xfs.org

