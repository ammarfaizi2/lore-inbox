Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbTFORZt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 13:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbTFORZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 13:25:49 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:64684 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262424AbTFORZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 13:25:48 -0400
Date: Sun, 15 Jun 2003 19:39:26 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make cramfs look less hostile
Message-ID: <20030615173926.GH1063@wohnheim.fh-wedel.de>
References: <20030615160524.GD1063@wohnheim.fh-wedel.de> <20030615182642.A19479@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030615182642.A19479@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 June 2003 18:26:42 +0100, Christoph Hellwig wrote:
> On Sun, Jun 15, 2003 at 06:05:24PM +0200, Jörn Engel wrote:
> > 
> > This thing has been biting me now and again.  "cramfs: wrong magic\n"
> > looks like an error condition to most people and thus creates bug
> > reports.  But there is no bug per se in having cramfs support in the
> > kernel and booting from a jffs2 rootfs.  So instead of teaching the
> > users over and over, how about this little one-liner?
> 
> Umm, cramfs_fill_super has a silent parameter that's true for
> probing the root filesystem.  I'd suggest disabling the printk
> completly if it's set.

Good idea, but only at first glance.  cramfs_fill_super() always gets
called with silent=1.  So if "(!silent) printk(...);" is functionally
equivalent to ";".

Jörn

-- 
The competent programmer is fully aware of the strictly limited size of
his own skull; therefore he approaches the programming task in full
humility, and among other things he avoids clever tricks like the plague. 
-- Edsger W. Dijkstra
