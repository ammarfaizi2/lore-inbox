Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWBZMnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWBZMnz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 07:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWBZMnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 07:43:55 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:33751 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751089AbWBZMny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 07:43:54 -0500
Date: Sun, 26 Feb 2006 13:43:51 +0100
From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
To: linux-kernel@vger.kernel.org
Cc: mec@shout.net
Subject: [PATCH] Corrected faulty syntax in drivers/input/Config.in
Message-ID: <20060226124351.GA7239@scotty.home>
Mail-Followup-To: linux-kernel@vger.kernel.org, mec@shout.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: -no organization-
X-Mailer: Mutt 1.5.6 http://www.mutt.org/
X-Editor: GNU Emacs 21.4.1 http://www.gnu.org/
X-Accept-Language: de en
X-Location: Europe, Germany, Wolfenbuettel
X-GPG-Public-Key: http://www.s-hahn.de/gpg-public-stefan.asc
X-GPG-key-ID/Fingerprint: 0xE4FCD563 / EF09 97BB 3731 7DC7 25BA 5C39 185C F986 E4FC D563
User-Agent: Mutt/1.5.9i
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:77aa76da759ebc9bab1cc524fc813130
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Corrected faulty syntax in drivers/input/Config.in

If statement in drivers/input/Config.in for "make xconfig" corrected.

Signed-off-by: Stefan-W. Hahn <stefan.hahn@s-hahn.de>

---

Surely this is just for Linux 2.4.33-pre2!

 drivers/input/Config.in |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

81f9e154659df0504179612968d61912da9c135c
diff --git a/drivers/input/Config.in b/drivers/input/Config.in
index 56fd537..d24d0fb 100644
--- a/drivers/input/Config.in
+++ b/drivers/input/Config.in
@@ -8,7 +8,7 @@ comment 'Input core support'
 tristate 'Input core support' CONFIG_INPUT
 dep_tristate '  Keyboard support' CONFIG_INPUT_KEYBDEV $CONFIG_INPUT
 
-if [ "$CONFIG_INPUT_KEYBDEV" == "n" ]; then
+if [ "$CONFIG_INPUT_KEYBDEV" = "n" ]; then
 	bool '  Use dummy keyboard driver' CONFIG_DUMMY_KEYB $CONFIG_INPUT
 fi
 
-- 
1.2.3.g8fcf1


-- 
Stefan-W. Hahn                          It is easy to make things.
/ mailto:stefan.hahn@s-hahn.de /        It is hard to make things simple.			

