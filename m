Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVAHUdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVAHUdx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 15:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbVAHUdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 15:33:53 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:8965 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261451AbVAHUdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 15:33:49 -0500
To: akpm@osdl.org
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
References: <52k6qn229h.fsf@topspin.com>
	<20050108193101.GD26051@parcelfarce.linux.theplanet.co.uk>
From: Roland Dreier <roland@topspin.com>
Date: Sat, 08 Jan 2005 12:33:46 -0800
In-Reply-To: <20050108193101.GD26051@parcelfarce.linux.theplanet.co.uk> (Al
 Viro's message of "Sat, 8 Jan 2005 19:31:01 +0000")
Message-ID: <52brbz1x05.fsf_-_@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH] Export get_sb_pseudo()
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 08 Jan 2005 20:33:48.0298 (UTC) FILETIME=[5B5496A0:01C4F5C1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Al> So feel free to go ahead and export it; as the matter of fact,
    Al> if you don't do it, I will.

Thanks, here's the trivial patch.


Export get_sb_pseudo() so that modules can create unmountable
pseudo-filesystems cleanly.

Signed-off-by: Roland Dreier <roland@topspin.com>

Index: linux-bk/fs/libfs.c
===================================================================
--- linux-bk.orig/fs/libfs.c	2004-12-29 22:05:29.000000000 -0800
+++ linux-bk/fs/libfs.c	2005-01-06 13:13:26.254907840 -0800
@@ -522,6 +522,7 @@
 EXPORT_SYMBOL(dcache_dir_open);
 EXPORT_SYMBOL(dcache_readdir);
 EXPORT_SYMBOL(generic_read_dir);
+EXPORT_SYMBOL(get_sb_pseudo);
 EXPORT_SYMBOL(simple_commit_write);
 EXPORT_SYMBOL(simple_dir_inode_operations);
 EXPORT_SYMBOL(simple_dir_operations);
