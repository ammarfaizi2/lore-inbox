Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVCBXC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVCBXC7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 18:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVCBXAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 18:00:50 -0500
Received: from gate.in-addr.de ([212.8.193.158]:54686 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261161AbVCBW6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 17:58:39 -0500
Date: Wed, 2 Mar 2005 23:58:46 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050302225846.GK17584@marowsky-bree.de>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-03-02T14:21:38, Linus Torvalds <torvalds@osdl.org> wrote:

> We'd still do the -rcX candidates as we go along in either case, so as a 
> user you wouldn't even _need_ to know, but the numbering would be a rough 
> guide to intentions. Ie I'd expect that distributions would always try to 
> base their stuff off a 2.6.<even> release.

If the users wouldn't even have to know, why do it? Who will benefit
from this, then?

I think a better approach, and one which is already working out well in
practice, is to put "more intrusive" features into -mm first, and only
migrate them into 2.6.x when they have 'stabilized'.

This could be improved: _All_ new features have to go through -mm first
for a period (of whatever length) / one cycle. 2.6.x only directly picks
up "obvious" bugfixes, and a select set of features which have ripened
in -mm. 2.6.x-pre releases would then basically "only" clean up
integration bugs.

-mm would be the 'feature tree'. Of course, features which have matured
in other eligible trees might also work; the key point is the two-stage
approach and it doesn't matter whether the chaos stage has one or three
trees, as long as it's not more than that.

I think that would be natural extension of how things already work and
just tightens the process some.


(From a vendor perspective, this would mean we'd be safe picking up any
2.6.x tree + select choices from x+1-pre plus whatever we are force fed
by those who pay.)

If one wanted to get fancy, which I'm throwing in just to make everybody
lose the core point of the argument: One could associate "points" with
each feature / patch in -mm, based on an estimation of how
intrusive/well-tested/dangerous/heavenly that patch is, and mandate that
only 42 points per 2.6.x release are allowed.

Of course, one could also apply common sense. But, that's not as silly.
Or way more so, but less amusing than voting wars.

> Comments?

The numbering scheme is more confusing and unclear, and complexity is
the enemy of reliability.



Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

