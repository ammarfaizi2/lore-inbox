Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262169AbVAYV6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbVAYV6E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 16:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbVAYV5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 16:57:46 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:58813 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S262185AbVAYVzT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 16:55:19 -0500
Date: Tue, 25 Jan 2005 16:55:11 -0500
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: Ram <linuxram@us.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] shared subtrees
Message-ID: <20050125215511.GD21764@fieldses.org>
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk> <20050116160213.GB13624@fieldses.org> <20050116180656.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050116184209.GD13624@fieldses.org> <20050117061150.GS26051@parcelfarce.linux.theplanet.co.uk> <20050117173213.GC24830@fieldses.org> <1106687232.3298.37.camel@localhost> <41F6BE58.50208@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F6BE58.50208@sun.com>
User-Agent: Mutt/1.5.6+20040907i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 04:47:04PM -0500, Mike Waychison wrote:
> Although Al hasn't explicitly defined the semantics for mount
> - --make-shared, I think the idea is that 'only' that mountpoint becomes
> tagged as shared (becomes a member of a p-node of size 1).

On Thu, Jan 13, 2005 at 10:18:51PM +0000, Al Viro wrote:
>	* we can mark a subtree sharable.  Every vfsmount in the subtree
> that is not already in some p-node gets a single-element p-node of its
> own.

Also, note that mount automatically sets up propagation that mirrors
that of the mounted on vfsmount, so by default new mounts anywhere in
the subtree will also be tagged as shared.

--b.
