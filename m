Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbTFOREE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 13:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbTFOREE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 13:04:04 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:17578 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262413AbTFORD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 13:03:28 -0400
Date: Sun, 15 Jun 2003 19:17:20 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make cramfs look less hostile
Message-ID: <20030615171719.GE1063@wohnheim.fh-wedel.de>
References: <20030615160524.GD1063@wohnheim.fh-wedel.de> <Pine.LNX.4.44.0306151245070.29663-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0306151245070.29663-100000@coffee.psychology.mcmaster.ca>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 June 2003 12:46:26 -0400, Mark Hahn wrote:
> 
> > This thing has been biting me now and again.  "cramfs: wrong magic\n"
> > looks like an error condition to most people and thus creates bug
> > reports.  But there is no bug per se in having cramfs support in the
> > kernel and booting from a jffs2 rootfs.  So instead of teaching the
> > users over and over, how about this little one-liner?
> 
> good argument.  but I was expecting you to remove the message entirely,
> or else make it *really* explanatory like "OK, not cramfs then"

Well, some embedded people trying to get this shiny new hardware with
bad debugging interfaces up and running might still like that printk.
But it would make sense to wrap it behind CONFIG_CRAMFS_DEBUG or
#define DEBUG 1 inside inode.c

Comments?

Jörn

-- 
Optimizations always bust things, because all optimizations are, in
the long haul, a form of cheating, and cheaters eventually get caught.
-- Larry Wall 
