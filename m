Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVBVXE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVBVXE1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 18:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVBVXE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 18:04:27 -0500
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:29057 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261327AbVBVXEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 18:04:22 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] ALPS: do not activate on unsupported models
Date: Tue, 22 Feb 2005 18:04:18 -0500
User-Agent: KMail/1.7.2
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Osterlund <petero2@telia.com>,
       Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502221804.19149.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It feels like 2.6.11 is right around the corner. I would like to disable
ALPS suport for some devices we don't know how to handle properly yet
to cut down on number of complaints that we broke mouse support.

Please consider applying the patch below.

-- 
Dmitry

===================================================================

Input: ALPS - do not activate native mode for devices whose data
       we can not handle yet.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 alps.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: dtor/drivers/input/mouse/alps.c
===================================================================
--- dtor.orig/drivers/input/mouse/alps.c
+++ dtor/drivers/input/mouse/alps.c
@@ -34,7 +34,7 @@ static struct alps_model_info {
 	unsigned char signature[3];
 	unsigned char model;
 } alps_model_data[] = {
-	{ { 0x33, 0x02, 0x0a },	ALPS_MODEL_GLIDEPOINT },
+/*	{ { 0x33, 0x02, 0x0a },	ALPS_MODEL_GLIDEPOINT },	*/
 	{ { 0x53, 0x02, 0x0a },	ALPS_MODEL_GLIDEPOINT },
 	{ { 0x53, 0x02, 0x14 },	ALPS_MODEL_GLIDEPOINT },
 	{ { 0x63, 0x02, 0x0a },	ALPS_MODEL_GLIDEPOINT },
@@ -42,8 +42,8 @@ static struct alps_model_info {
 	{ { 0x73, 0x02, 0x0a },	ALPS_MODEL_GLIDEPOINT },
 	{ { 0x73, 0x02, 0x14 },	ALPS_MODEL_GLIDEPOINT },
 	{ { 0x63, 0x02, 0x28 },	ALPS_MODEL_GLIDEPOINT },
-	{ { 0x63, 0x02, 0x3c },	ALPS_MODEL_GLIDEPOINT },
-	{ { 0x63, 0x02, 0x50 },	ALPS_MODEL_GLIDEPOINT },
+/*	{ { 0x63, 0x02, 0x3c },	ALPS_MODEL_GLIDEPOINT },	*/
+/*	{ { 0x63, 0x02, 0x50 },	ALPS_MODEL_GLIDEPOINT },	*/
 	{ { 0x63, 0x02, 0x64 },	ALPS_MODEL_GLIDEPOINT },
 	{ { 0x20, 0x02, 0x0e },	ALPS_MODEL_DUALPOINT },
 	{ { 0x22, 0x02, 0x0a },	ALPS_MODEL_DUALPOINT },
