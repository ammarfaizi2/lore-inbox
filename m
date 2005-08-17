Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbVHQUp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbVHQUp1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 16:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbVHQUp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 16:45:27 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:12814 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751236AbVHQUpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 16:45:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=h4g0caQMqQriFxRTH/ikjrZnDhkD43FgNj/TUxJ5gfiMc+j1Xi7xK9S44iSOBcoa5cnfjGik00PvAovS703aDw2f6Pn0ffmrTPK/Ar/l70DAw+lACG/K6/Cc39GIWnWCrL+UqEpFeQenplXCMJPdUFfh8Zd2Q+X8NII9iE0qthc=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: xfs-masters@oss.sgi.com
Subject: [PATCH] pull XFS support out of Kconfig submenu
Date: Wed, 17 Aug 2005 22:44:09 +0200
User-Agent: KMail/1.8.2
Cc: nathans@sgi.com, linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508172244.09378.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems slightly odd to me that XFS support should be in a seperate submenu,
when all the other filesystems are not using submenus but are directly 
selectable from the Filesystems menu.
This patch makes XFS Kconfig entries behave like everything else.

Ignore if there's a good reason for the menu, please consider applying 
otherwise.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 fs/xfs/Kconfig |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)

--- linux-2.6.13-rc6-git9-orig/fs/xfs/Kconfig	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/xfs/Kconfig	2005-08-17 22:38:26.000000000 +0200
@@ -1,5 +1,3 @@
-menu "XFS support"
-
 config XFS_FS
 	tristate "XFS filesystem support"
 	select EXPORTFS if NFSD!=n
@@ -22,6 +20,7 @@
 
 config XFS_EXPORT
 	bool
+	depends on XFS_FS
 	default y if XFS_FS && EXPORTFS
 
 config XFS_RT
@@ -81,5 +80,3 @@
 	  Linux website <http://acl.bestbits.at/>.
 
 	  If you don't know what Access Control Lists are, say N.
-
-endmenu


