Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262708AbVAQGMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbVAQGMN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 01:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbVAQGMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 01:12:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9649 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262708AbVAQGLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 01:11:51 -0500
Date: Mon, 17 Jan 2005 06:11:50 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] shared subtrees
Message-ID: <20050117061150.GS26051@parcelfarce.linux.theplanet.co.uk>
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk> <20050116160213.GB13624@fieldses.org> <20050116180656.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050116184209.GD13624@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050116184209.GD13624@fieldses.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2005 at 01:42:09PM -0500, J. Bruce Fields wrote:
> On Sun, Jan 16, 2005 at 06:06:56PM +0000, Al Viro wrote:
> > On Sun, Jan 16, 2005 at 11:02:13AM -0500, J. Bruce Fields wrote:
> > > On Thu, Jan 13, 2005 at 10:18:51PM +0000, Al Viro wrote:
> > > > 	6. mount --move
> > > > prohibited if what we are moving is in some p-node, otherwise we move
> > > > as usual to intended mountpoint and create copies for everything that
> > > > gets propagation from there (as we would do for rbind).
> > > 
> > > Why this prohibition?
> > 
> > How do you propagate that?  We can weaken that to "in a p-node that
> > owns something or contains more than one vfsmount", but it's not
> > worth the trouble, AFAICS.
> 
> I guess I'm not seeing what there is to propagate.  If the vfsmount we
> are moving is mounted under a vfsmount that's in a p-node, then there'd
> be something to propagate, but since the --move doesn't change the
> structure of mounts underneath the moved mountpoint, I wouldn't expect
> any changes to be propagated from it to other mountpoints.
> 
> I must be missing something fundamental....

No - I have been missing a typo.  Make that "if mountpoint of what we
are moving...".
