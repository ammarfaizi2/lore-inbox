Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263565AbUDVGnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263565AbUDVGnZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 02:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263606AbUDVGnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 02:43:25 -0400
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:53100 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263565AbUDVGnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 02:43:21 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 16/15] New set of input patches: serio whitespace
Date: Thu, 22 Apr 2004 01:43:17 -0500
User-Agent: KMail/1.6.1
Cc: Vojtech Pavlik <vojtech@suse.cz>
References: <200404210049.17139.dtor_core@ameritech.net>
In-Reply-To: <200404210049.17139.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404220143.19135.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 April 2004 12:49 am, Dmitry Torokhov wrote:
> Hi,
> 
> Here is a new set of my input patches, would love to hear comments and/or
> suggestions. The patches can also be found at:
> 
I have 2 more:

01-serio-whitespace.patch
02-setop-openclose-optional.patch
	- make open and close methods optional so drivers are not forced to supply
	  stubs.

-- 
Dmitry


===================================================================


ChangeSet@1.1897.1.20, 2004-04-21 18:28:43-05:00, dtor_core@ameritech.net
  Input: serio trailing whitespace fixes


 serio.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)


===================================================================



diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	Thu Apr 22 01:17:33 2004
+++ b/drivers/input/serio/serio.c	Thu Apr 22 01:17:33 2004
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
