Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268693AbUHYUtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268693AbUHYUtO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 16:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268689AbUHYUst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 16:48:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59780 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268602AbUHYUmm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 16:42:42 -0400
Date: Wed, 25 Aug 2004 21:42:40 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 01:22:55PM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 25 Aug 2004, Christoph Hellwig wrote:
> > 
> > For one thing _I_ didn't decide about xattrs anyway.  And I still
> > haven't seen a design from you on -fsdevel how you try to solve the
> > problems with files as directories.
> 
> Hey, files-as-directories are one of my pet things, so I have to side with 
> Hans on this one. I think it just makes sense. A hell of a lot more sense 
> than xattrs, anyway, since it allows scripts etc standard tools to touch 
> the attributes.
> 
> It's the UNIX way.

Not if you allow link(2) on them.  And not if you design and market your
stuff as a general-purpose backdoor into kernel.  Note how *EVERY* *DAMN*
*OPERATION* is made possible to override by "plugins".  Which is the reason
for deadlocks in question, BTW.

Don't fool yourself - that's what Hans is selling.  Target market: ISV.
Marketed product: a set of hooks, the wider the better, no matter how
little sense it makes.  The reason for doing that outside of core kernel:
bypassing any review and being able to control the product being sold (see
above).

Shame that it got an actual filesystem mixed in with the marketing plans
and general insanity...
