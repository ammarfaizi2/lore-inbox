Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262445AbVBBV3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbVBBV3k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 16:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbVBBV3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 16:29:39 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:62139 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S262445AbVBBV0D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 16:26:03 -0500
Date: Wed, 2 Feb 2005 16:25:57 -0500
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: Ram <linuxram@us.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] shared subtrees
Message-ID: <20050202212557.GC3879@fieldses.org>
References: <20050116180656.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050116184209.GD13624@fieldses.org> <20050117061150.GS26051@parcelfarce.linux.theplanet.co.uk> <20050117173213.GC24830@fieldses.org> <1106687232.3298.37.camel@localhost> <20050201232106.GA22118@fieldses.org> <1107369381.5992.73.camel@localhost> <42012DE7.4080003@sun.com> <1107376434.5992.113.camel@localhost> <42014150.9090500@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42014150.9090500@sun.com>
User-Agent: Mutt/1.5.6+20040907i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 04:08:32PM -0500, Mike Waychison wrote:
> Well, fwiw, I have the same kind of race in autofsng.  I counter it by
> building up the vfsmount tree elsewhere and mount --move'ing it.
> 
> Unfortunately, the RFC states that moving a shared vfsmount is
> prohibited (for which the reasoning slips my mind).

See http://marc.theaimsgroup.com/?l=linux-fsdevel&m=110594248826226&w=2

As I understand it, the problem isn't sharing of the vfsmount being
moved, but sharing of the vfsmount on which that vfsmount is
mounted.--b.
