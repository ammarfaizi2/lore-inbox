Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbTFUNql (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 09:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbTFUNiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 09:38:25 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:22690 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263631AbTFUNiB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 09:38:01 -0400
Subject: [PATCH 8/11] input: Change order of search for beeper devices in keyboard.c
In-Reply-To: <10562035172084@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sat, 21 Jun 2003 15:51:57 +0200
Message-Id: <10562035172152@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1366, 2003-06-21 04:44:26-07:00, neilb@cse.unsw.edu.au
  input: Change order of search for beeper devices in keyboard.c,
         so that it is easier to replace a beeper with a different
         driver


 keyboard.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/char/keyboard.c b/drivers/char/keyboard.c
--- a/drivers/char/keyboard.c	Sat Jun 21 15:25:44 2003
+++ b/drivers/char/keyboard.c	Sat Jun 21 15:25:44 2003
@@ -242,7 +242,7 @@
 	del_timer(&kd_mksound_timer);
 
 	if (hz) {
-		list_for_each(node,&kbd_handler.h_list) {
+		list_for_each_prev(node,&kbd_handler.h_list) {
 			struct input_handle *handle = to_handle_h(node);
 			if (test_bit(EV_SND, handle->dev->evbit)) {
 				if (test_bit(SND_TONE, handle->dev->sndbit)) {

