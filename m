Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbUACLgI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 06:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbUACLgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 06:36:08 -0500
Received: from cpc1-cosh4-5-0-cust84.cos2.cable.ntl.com ([81.96.30.84]:46978
	"EHLO slut.local.munted.org.uk") by vger.kernel.org with ESMTP
	id S262796AbUACLgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 06:36:06 -0500
Date: Sat, 3 Jan 2004 11:35:36 +0000 (GMT)
From: Alex Buell <alex.buell@munted.org.uk>
X-X-Sender: alex@slut.local.munted.org.uk
To: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: inode_cache / dentry_cache not being reclaimed aggressively enough
 on low-memory PCs
Message-ID: <Pine.LNX.4.58.0401031128100.2605@slut.local.munted.org.uk>
X-no-archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just run across a problem with 2.4.x (and probably 2.6.x as well, if
reports I've see are correct). When updatedb is run overnight, it builds
up large amounts of inode_cache and dentry_cache. This is a big problem on
low memory boxes as those caches are not being reclaimed aggressively
enough, which means the box will be constantly swapping if it runs out of
free memory. I've looked at archives and I find that there's similar
reports going back to 2.4.16, and doesn't seem to have been solved as this
problem is apparently in 2.6.0 as well!
 
The only solution I've found so far is to run L*rry McV*y's lmdd to force
reclaimation of those caches but this isn't ideal. What patches are out
there that solves this problem?

Thanks,
Alex.
-- 
http://www.munted.org.uk

Your mother cooks socks in hell
