Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262556AbVAPSHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbVAPSHB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 13:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbVAPSHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 13:07:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47306 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262555AbVAPSG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 13:06:58 -0500
Date: Sun, 16 Jan 2005 18:06:56 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] shared subtrees
Message-ID: <20050116180656.GQ26051@parcelfarce.linux.theplanet.co.uk>
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk> <20050116160213.GB13624@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050116160213.GB13624@fieldses.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2005 at 11:02:13AM -0500, J. Bruce Fields wrote:
> On Thu, Jan 13, 2005 at 10:18:51PM +0000, Al Viro wrote:
> > 	6. mount --move
> > prohibited if what we are moving is in some p-node, otherwise we move
> > as usual to intended mountpoint and create copies for everything that
> > gets propagation from there (as we would do for rbind).
> 
> Why this prohibition?

How do you propagate that?  We can weaken that to "in a p-node that
owns something or contains more than one vfsmount", but it's not
worth the trouble, AFAICS.
