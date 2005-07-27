Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbVG0SON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbVG0SON (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 14:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbVG0SON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 14:14:13 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:48191 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262112AbVG0SOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 14:14:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=ZFfMw1m1l/upvlJkyX8YrKi/nfrCMt8P7/4MD1MjPx8ZQ0i9FFre7CjEs8YGQjfygodk5f0+8HbZp6eUTQjU1xm6305gus0QjaPLgjNAlYt79jHoIbPcRZn/9oxY44ng5dqW2x64d8g3JPvFERZ32Ub1T7Aql0nU3j0LHvtTVwY=
Message-ID: <42E7CEE8.4090103@gmail.com>
Date: Wed, 27 Jul 2005 14:14:00 -0400
From: Keenan Pepper <keenanpepper@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] [TRIVIAL] signed/unsigned char fix for make menuconfig
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quiet some silly warnings.


--- linux-2.6.13-rc3-mm2/scripts/lxdialog/dialog.orig.h 2005-07-27 
13:59:02.389806392 -0400
+++ linux-2.6.13-rc3-mm2/scripts/lxdialog/dialog.h      2005-07-27 
13:59:13.437126944 -0400
@@ -163,7 +163,7 @@
  int dialog_checklist (const char *title, const char *prompt, int height,
		int width, int list_height, int item_no,
		const char * const * items, int flag);
-extern unsigned char dialog_input_result[];
+extern char dialog_input_result[];
  int dialog_inputbox (const char *title, const char *prompt, int height,
		int width, const char *init);

--- linux-2.6.13-rc3-mm2/scripts/lxdialog/inputbox.orig.c       2005-07-27 
13:57:57.647648696 -0400
+++ linux-2.6.13-rc3-mm2/scripts/lxdialog/inputbox.c    2005-07-27 
13:58:37.336615056 -0400
@@ -21,7 +21,7 @@

  #include "dialog.h"

-unsigned char dialog_input_result[MAX_LEN + 1];
+char dialog_input_result[MAX_LEN + 1];

  /*
   *  Print the termination buttons
@@ -48,7 +48,7 @@
  {
      int i, x, y, box_y, box_x, box_width;
      int input_x = 0, scroll = 0, key = 0, button = -1;
-    unsigned char *instr = dialog_input_result;
+    char *instr = dialog_input_result;
      WINDOW *dialog;

      /* center dialog box on screen */
