Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264538AbUFGMbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbUFGMbL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 08:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264723AbUFGM3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 08:29:04 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:4737 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264538AbUFGLzt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:55:49 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <10866093532571@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <10866093533797@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:53 +0200
Subject: [PATCH 17/39] input: Serio trailing whitespace fixes
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1371.753.24, 2004-04-23 02:48:40-05:00, dtor_core@ameritech.net
  Input: serio trailing whitespace fixes


 serio.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	2004-06-07 13:12:19 +02:00
+++ b/drivers/input/serio/serio.c	2004-06-07 13:12:19 +02:00
@@ -11,18 +11,18 @@
 /*
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or 
+ * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- * 
+ *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- * 
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- * 
+ *
  * Should you need to contact me, the author, you can do so either by
  * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
  * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
@@ -108,7 +108,7 @@
 	struct serio_event *event;
 
 	list_for_each_safe(node, next, &serio_event_list) {
-		event = container_of(node, struct serio_event, node);	
+		event = container_of(node, struct serio_event, node);
 
 		down(&serio_sem);
 		if (event->serio == NULL)
@@ -152,7 +152,7 @@
 
 	do {
 		serio_handle_events();
-		wait_event_interruptible(serio_wait, !list_empty(&serio_event_list)); 
+		wait_event_interruptible(serio_wait, !list_empty(&serio_event_list));
 		if (current->flags & PF_FREEZE)
 			refrigerator(PF_FREEZE);
 	} while (!signal_pending(current));

