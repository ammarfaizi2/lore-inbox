Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWAIVix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWAIVix (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 16:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWAIVim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 16:38:42 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:42767 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750724AbWAIVif convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 16:38:35 -0500
Subject: [PATCH 04/11] kbuild: In setlocalversion change -git_dirty to just -dirty
In-Reply-To: <20060109211157.GA14477@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Mon, 9 Jan 2006 22:38:19 +0100
Message-Id: <11368426991067@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Anderson <ryan@michonline.com>
Date: 1136712936 -0500

When building Debian packages directly from the git tree, the appended
"git_dirty" is a problem due to the underscore.  In order to cause the
least problems, change that just to "dirty".

Signed-off-by: Ryan Anderson <ryan@michonline.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/setlocalversion |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

24d49756aa67322c2def5dc97344615572ac454e
diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index f54dac8..9a23825 100644
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -17,6 +17,6 @@ if head=`git rev-parse --verify HEAD 2>/
 
 	# Are there uncommitted changes?
 	if git diff-files | read dummy; then
-		printf '%s' -git_dirty
+		printf '%s' -dirty
 	fi
 fi
-- 
1.0.GIT

