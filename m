Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318493AbSGSJyW>; Fri, 19 Jul 2002 05:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318494AbSGSJyW>; Fri, 19 Jul 2002 05:54:22 -0400
Received: from loke.as.arizona.edu ([128.196.209.61]:37508 "EHLO
	loke.as.arizona.edu") by vger.kernel.org with ESMTP
	id <S318493AbSGSJyV>; Fri, 19 Jul 2002 05:54:21 -0400
Date: Fri, 19 Jul 2002 02:55:13 -0700 (MST)
From: Craig Kulesa <ckulesa@as.arizona.edu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] export serio_interrupt for modules
Message-ID: <Pine.LNX.4.44.0207190247480.4771-100000@loke.as.arizona.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In order to use serio drivers as modules, like i8042, serio_interrupt 
needs to be exported.  Unresolved symbols result otherwise.  Patch follows.

Craig Kulesa
Steward Observatory

diff -uNr linux-2.5.26-rmap13b/drivers/input/serio/serio.c linux-2.5.26-rmap13b-slablru/drivers/input/serio/serio.c
--- linux-2.5.26-rmap13b/drivers/input/serio/serio.c	Thu Jul 18 03:03:28 2002
+++ linux-2.5.26-rmap13b-slablru/drivers/input/serio/serio.c	Thu Jul 18 10:07:39 2002
@@ -49,6 +49,7 @@
 EXPORT_SYMBOL(serio_open);
 EXPORT_SYMBOL(serio_close);
 EXPORT_SYMBOL(serio_rescan);
+EXPORT_SYMBOL(serio_interrupt);
 
 static struct serio *serio_list;
 static struct serio_dev *serio_dev;

