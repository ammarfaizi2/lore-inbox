Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264414AbUFGNIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264414AbUFGNIM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 09:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264635AbUFGMUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 08:20:36 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:50816 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264505AbUFGLzh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:55:37 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <10866093522124@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <10866093523469@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:52 +0200
Subject: [PATCH 3/39] input: Fix emulation of mouse reset (0xff) command.
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1371.691.1, 2004-04-05 17:39:48+02:00, vojtech@suse.cz
  input: Fix emulation of mouse reset (0xff) command.


 mousedev.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

===================================================================

diff -Nru a/drivers/input/mousedev.c b/drivers/input/mousedev.c
--- a/drivers/input/mousedev.c	2004-06-07 13:13:38 +02:00
+++ b/drivers/input/mousedev.c	2004-06-07 13:13:38 +02:00
@@ -391,9 +391,9 @@
 				list->impsseq = 0;
 				list->imexseq = 0;
 				list->mode = 0;
-				list->ps2[0] = 0xaa;
-				list->ps2[1] = 0x00;
-				list->bufsiz = 2;
+				list->ps2[1] = 0xaa;
+				list->ps2[2] = 0x00;
+				list->bufsiz = 3;
 				break;
 		}
 

