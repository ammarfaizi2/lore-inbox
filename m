Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262565AbVAPSmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262565AbVAPSmP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 13:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbVAPSmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 13:42:14 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:37255 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S262562AbVAPSmK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 13:42:10 -0500
Date: Sun, 16 Jan 2005 13:42:09 -0500
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] shared subtrees
Message-ID: <20050116184209.GD13624@fieldses.org>
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk> <20050116160213.GB13624@fieldses.org> <20050116180656.GQ26051@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050116180656.GQ26051@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6+20040907i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2005 at 06:06:56PM +0000, Al Viro wrote:
> On Sun, Jan 16, 2005 at 11:02:13AM -0500, J. Bruce Fields wrote:
> > On Thu, Jan 13, 2005 at 10:18:51PM +0000, Al Viro wrote:
> > > 	6. mount --move
> > > prohibited if what we are moving is in some p-node, otherwise we move
> > > as usual to intended mountpoint and create copies for everything that
> > > gets propagation from there (as we would do for rbind).
> > 
> > Why this prohibition?
> 
> How do you propagate that?  We can weaken that to "in a p-node that
> owns something or contains more than one vfsmount", but it's not
> worth the trouble, AFAICS.

I guess I'm not seeing what there is to propagate.  If the vfsmount we
are moving is mounted under a vfsmount that's in a p-node, then there'd
be something to propagate, but since the --move doesn't change the
structure of mounts underneath the moved mountpoint, I wouldn't expect
any changes to be propagated from it to other mountpoints.

I must be missing something fundamental....

--Bruce Fields
