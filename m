Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVFFUiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVFFUiJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 16:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbVFFUhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 16:37:54 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:18327 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261651AbVFFUgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 16:36:55 -0400
Date: Mon, 6 Jun 2005 15:36:39 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Andrew Morton <akpm@osdl.org>, Christoph Rohland <cr@sap.com>,
       Robin Holt <holt@sgi.com>, "Adam J. Richter" <adam@yggdrasil.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shmem: restore superblock info
In-Reply-To: <Pine.LNX.4.61.0506062122500.5122@goblin.wat.veritas.com>
Message-ID: <20050606153515.H19925@chenjesu.americas.sgi.com>
References: <Pine.LNX.4.61.0506062043470.5000@goblin.wat.veritas.com>    
 <20050606150742.F19925@chenjesu.americas.sgi.com>
 <Pine.LNX.4.61.0506062122500.5122@goblin.wat.veritas.com>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jun 2005, Hugh Dickins wrote:

> On Mon, 6 Jun 2005, Brent Casavant wrote:
> > On Mon, 6 Jun 2005, Hugh Dickins wrote:
> > 
> > > @@ -1607,15 +1582,17 @@ static int shmem_statfs(struct super_blo
> > > -	if (sbinfo) {
> > > -		spin_lock(&sbinfo->stat_lock);
> > > +	spin_lock(&sbinfo->stat_lock);
> ...
> > 
> > This is the only change I'm at all concerned about.
> 
> Thanks for noticing, I hadn't really considered that.
> 
> > I'm not sure how frequent statfs operations occur in practice (I suspect
> > infrequently),
> 
> Infrequently, yes.  I think infrequently to the point of never in
> the case that concerns you: correct if I'm wrong, someone, but I think
> there's actually no handle by which user can statfs shm's internal mount.

Ah, that's an even better point, which I had failed to consider.  Consider
my concerns duly nullified. :)

Thanks for CC'ing me on the change.

Brent

-- 
Brent Casavant                          If you had nothing to fear,
bcasavan@sgi.com                        how then could you be brave?
Silicon Graphics, Inc.                    -- Queen Dama, Source Wars
