Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752643AbWAHPwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbWAHPwS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 10:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752644AbWAHPwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 10:52:18 -0500
Received: from quark.didntduck.org ([69.55.226.66]:50076 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1752643AbWAHPwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 10:52:17 -0500
Message-ID: <43C13593.6080509@didntduck.org>
Date: Sun, 08 Jan 2006 10:53:55 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mail/News 1.5 (X11/20060103)
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: rusty@rustcorp.com.au, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] modpost: Fix typo
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SND_MAX should be FF_MAX

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

---
commit 71bc7fe59ac4b225d6279af4f45affbc5f2eec1b
tree d1789dd69878466807dc3612dc8643c8102bbcda
parent 12a9d2c317f6447caa5c5ccd553780516369f701
author Brian Gerst <bgerst@didntduck.org> Sun, 08 Jan 2006 10:52:26 -0500
committer Brian Gerst <bgerst@didntduck.org> Sun, 08 Jan 2006 10:52:26 -0500

 scripts/mod/file2alias.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index e0eedff..be97caf 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -417,7 +417,7 @@ static int do_input_entry(const char *fi
 		do_input(alias, id->sndbit, 0, SND_MAX);
 	sprintf(alias + strlen(alias), "f*");
 	if (id->flags&INPUT_DEVICE_ID_MATCH_FFBIT)
-		do_input(alias, id->ffbit, 0, SND_MAX);
+		do_input(alias, id->ffbit, 0, FF_MAX);
 	sprintf(alias + strlen(alias), "w*");
 	if (id->flags&INPUT_DEVICE_ID_MATCH_SWBIT)
 		do_input(alias, id->swbit, 0, SW_MAX);


