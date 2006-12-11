Return-Path: <linux-kernel-owner+w=401wt.eu-S1762894AbWLKNFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762894AbWLKNFi (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 08:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762895AbWLKNFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 08:05:38 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51753 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762894AbWLKNFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 08:05:37 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] vt: Fix comments to not refer to kill_proc
CC: Linux Containers <containers@lists.osdl.org>,
       <linux-kernel@vger.kernel.org>
Date: Mon, 11 Dec 2006 06:05:18 -0700
Message-ID: <m1psaqwpkh.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The code has been fixed to use kill_pid instead of kill_proc
fix the comments as well.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 drivers/char/vt_ioctl.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/vt_ioctl.c b/drivers/char/vt_ioctl.c
index ac5d60e..311493e 100644
--- a/drivers/char/vt_ioctl.c
+++ b/drivers/char/vt_ioctl.c
@@ -1087,7 +1087,7 @@ static void complete_change_console(struct vc_data *vc)
 	switch_screen(vc);
 
 	/*
-	 * This can't appear below a successful kill_proc().  If it did,
+	 * This can't appear below a successful kill_pid().  If it did,
 	 * then the *blank_screen operation could occur while X, having
 	 * received acqsig, is waking up on another processor.  This
 	 * condition can lead to overlapping accesses to the VGA range
@@ -1110,7 +1110,7 @@ static void complete_change_console(struct vc_data *vc)
 	 */
 	if (vc->vt_mode.mode == VT_PROCESS) {
 		/*
-		 * Send the signal as privileged - kill_proc() will
+		 * Send the signal as privileged - kill_pid() will
 		 * tell us if the process has gone or something else
 		 * is awry
 		 */
@@ -1170,7 +1170,7 @@ void change_console(struct vc_data *new_vc)
 	vc = vc_cons[fg_console].d;
 	if (vc->vt_mode.mode == VT_PROCESS) {
 		/*
-		 * Send the signal as privileged - kill_proc() will
+		 * Send the signal as privileged - kill_pid() will
 		 * tell us if the process has gone or something else
 		 * is awry
 		 */
-- 
1.4.4.1.g278f

