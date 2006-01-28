Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422804AbWA1CZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422804AbWA1CZE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 21:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422805AbWA1CWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 21:22:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:39866 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422800AbWA1CWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 21:22:34 -0500
Date: Fri, 27 Jan 2006 18:21:26 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       reiser@namesys.com, vitaly@namesys.com
Subject: [patch 10/12] Someone broke reiserfs v3 mount options and this fixes it
Message-ID: <20060128022126.GK17001@kroah.com>
References: <20060128020629.908825000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="someone-broke-reiserfs-v3-mount-options-and-this-fixes-it.patch"
In-Reply-To: <20060128022023.GA17001@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.15.2 -stable review patch.  If anyone has any objections, please let 
us know.

------------------

From: Vitaly Fertman <vitaly@namesys.com>

Signed-off-by: Hans Reiser <reiser@namesys.com>
Signed-off-by: Vitaly Fertman <vitaly@namesys.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 fs/reiserfs/super.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.15.1.orig/fs/reiserfs/super.c
+++ linux-2.6.15.1/fs/reiserfs/super.c
@@ -1131,7 +1131,7 @@ static void handle_attrs(struct super_bl
 			REISERFS_SB(s)->s_mount_opt &= ~(1 << REISERFS_ATTRS);
 		}
 	} else if (le32_to_cpu(rs->s_flags) & reiserfs_attrs_cleared) {
-		REISERFS_SB(s)->s_mount_opt |= REISERFS_ATTRS;
+		REISERFS_SB(s)->s_mount_opt |= (1 << REISERFS_ATTRS);
 	}
 }
 

--
