Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbVANBpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbVANBpQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 20:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVANBmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 20:42:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48518 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261861AbVANBiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 20:38:54 -0500
Date: Fri, 14 Jan 2005 01:38:50 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Erez Zadok <ezk@cs.sunysb.edu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] shared subtrees
Message-ID: <20050114013850.GN26051@parcelfarce.linux.theplanet.co.uk>
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk> <200501140111.j0E1Bx0N023763@agora.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501140111.j0E1Bx0N023763@agora.fsl.cs.sunysb.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 08:11:59PM -0500, Erez Zadok wrote:
> Al, how do shared subtrees related to stacking?  From your description, it
> looks like event propagation is similar to what stacking does (pass an op
> from one layer to another), only that subtree sharing is for "mount points"
> and not for every VFS object.  Am I right?

Umm...  Not really - that's propagation of operations on VFS-*only* data
structures from one part of tree to another; I don't see how that's
related to layering.
 
> If shared subtrees have nothing to do with stacking, do you foresee them as
> perhaps a first step toward full stacking support in the VFS?  (I mean, if
> we're going to have to hack the VFS heavily already...)

I don't see how they are related, so anything towards stacking would be
a separate story, IMO...  I'm not sure whether it makes sense to put that
into the same cycle - depends on how much will be affected by each set
of patches and how well it will split into trivial widespread modifications
vs. heavy localized work...

IOW, no idea right now.

>  Your "p-node"
> sounds awfully similar to Rosenthal's and Skinner's "pvnode"s. :-)

Heh.  "p-node" is a result of giving up on finding a better term than
"node in propagation graph" - no more, no less.  I doubt that it'll
survive to final edition - both as term and as something that would
have a corresponding in-core object...
