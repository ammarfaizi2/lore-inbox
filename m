Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261644AbSJMVgk>; Sun, 13 Oct 2002 17:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261665AbSJMVgk>; Sun, 13 Oct 2002 17:36:40 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:12472 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261644AbSJMVgj>; Sun, 13 Oct 2002 17:36:39 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.42: accessfs 2/3: change LSM config default
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Sun, 13 Oct 2002 23:42:17 +0200
Message-ID: <87elau9ft2.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Per default, security/capability.c registers unconditionally as LSM
module. This prevents other modules to register.

This patch allows to register other modules beside "capability".

Regards, Olaf.

--- a/security/Config.in	Sat Oct  5 18:44:05 2002
+++ b/security/Config.in	Sun Oct 13 01:24:50 2002
@@ -3,5 +3,5 @@
 #
 mainmenu_option next_comment
 comment 'Security options'
-define_bool CONFIG_SECURITY_CAPABILITIES y
+define_bool CONFIG_SECURITY_CAPABILITIES m
 endmenu
