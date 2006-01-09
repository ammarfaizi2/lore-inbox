Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWAIVil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWAIVil (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 16:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWAIVik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 16:38:40 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:38415 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750725AbWAIVia convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 16:38:30 -0500
Subject: [PATCH 03/11] modpost/file2alias: Fix typo
In-Reply-To: <20060109211157.GA14477@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Mon, 9 Jan 2006 22:38:14 +0100
Message-Id: <11368426944187@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Gerst <bgerst@didntduck.org>
Date: 1136735635 -0500

SND_MAX should be FF_MAX

Signed-off-by: Brian Gerst <bgerst@didntduck.org>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/mod/file2alias.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

cc6fa432f5eec26c43fd06c0314cb1c2cae6d9a1
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
-- 
1.0.GIT

