Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262384AbVAPArG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbVAPArG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 19:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbVAPArF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 19:47:05 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:35970 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S262384AbVAPArA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 19:47:00 -0500
Date: Sat, 15 Jan 2005 19:46:59 -0500
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] shared subtrees
Message-ID: <20050116004659.GA6556@fieldses.org>
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6+20040907i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 10:18:51PM +0000, Al Viro wrote:
> 	2. mount
> 
> We have a new vfsmount A and want to attach it to mountpoint somewhere in
> vfsmount B.  If B does not belong to any p-node, everything is as usual; A
> doesn't become a member or slave of any p-node and is simply attached to B.
> 
> If B belongs to a p-node p, consider all vfsmounts B1,...,Bn that get events
> propagated from B and all p-nodes p1,...,pk that contain them.
> 	* A gets cloned into n copies and these copies (A1,...,An) are attached
> to corresponding points in B1,...,Bn.
> 	* k new p-nodes (q1,...,qk) are created
> 	* Ai is contained in qj <=> Bi is contained in qj

Minor typo: looks like that second qj should be pj.

--b.
