Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752613AbWAHJgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbWAHJgd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 04:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752614AbWAHJgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 04:36:33 -0500
Received: from mail.autoweb.net ([198.172.237.26]:26075 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1752613AbWAHJgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 04:36:33 -0500
Date: Sun, 8 Jan 2006 04:35:36 -0500
From: Ryan Anderson <ryan@michonline.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] setlocalversion: Change -git_dirty to just -dirty
Message-ID: <20060108093535.GA22585@mythryan2.michonline.com>
References: <20060104194203.GA2359@lsrfire.ath.cx> <20060106194735.GA15694@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106194735.GA15694@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When building Debian packages directly from the git tree, the appended
"git_dirty" is a problem due to the underscore.  In order to cause the
least problems, change that just to "dirty".

Signed-off-by: Ryan Anderson <ryan@michonline.com>

--- linux-git.orig/scripts/setlocalversion	2006-01-07 01:48:21.000000000 -0500
+++ linux-git/scripts/setlocalversion	2006-01-08 04:32:49.000000000 -0500
@@ -17,6 +17,6 @@ if head=`git rev-parse --verify HEAD 2>/
 
 	# Are there uncommitted changes?
 	if git diff-files | read dummy; then
-		printf '%s' -git_dirty
+		printf '%s' -dirty
 	fi
 fi


-- 

Ryan Anderson
  sometimes Pug Majere
