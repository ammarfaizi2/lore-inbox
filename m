Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262377AbVAPAvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbVAPAvf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 19:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbVAPAvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 19:51:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18114 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262377AbVAPAv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 19:51:27 -0500
Date: Sun, 16 Jan 2005 00:51:26 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] shared subtrees
Message-ID: <20050116005126.GP26051@parcelfarce.linux.theplanet.co.uk>
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk> <20050116004659.GA6556@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050116004659.GA6556@fieldses.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2005 at 07:46:59PM -0500, J. Bruce Fields wrote:
> On Thu, Jan 13, 2005 at 10:18:51PM +0000, Al Viro wrote:
> > 	2. mount
> > 
> > We have a new vfsmount A and want to attach it to mountpoint somewhere in
> > vfsmount B.  If B does not belong to any p-node, everything is as usual; A
> > doesn't become a member or slave of any p-node and is simply attached to B.
> > 
> > If B belongs to a p-node p, consider all vfsmounts B1,...,Bn that get events
> > propagated from B and all p-nodes p1,...,pk that contain them.
> > 	* A gets cloned into n copies and these copies (A1,...,An) are attached
> > to corresponding points in B1,...,Bn.
> > 	* k new p-nodes (q1,...,qk) are created
> > 	* Ai is contained in qj <=> Bi is contained in qj
> 
> Minor typo: looks like that second qj should be pj.

ACK
