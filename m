Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265821AbUBBTuv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 14:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265980AbUBBTt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 14:49:29 -0500
Received: from mailr-2.tiscali.it ([212.123.84.82]:53619 "EHLO
	mailr-2.tiscali.it") by vger.kernel.org with ESMTP id S265973AbUBBTsF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 14:48:05 -0500
Date: Mon, 2 Feb 2004 20:48:05 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 19/42]
Message-ID: <20040202194805.GS6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hid-core.c:879: warning: implicit declaration of function `hiddev_report_event'

Add missing prototype in include/linux/hiddev.h

diff -Nru -X dontdiff linux-2.4-vanilla/include/linux/hiddev.h linux-2.4/include/linux/hiddev.h
--- linux-2.4-vanilla/include/linux/hiddev.h	Tue Nov 11 17:51:16 2003
+++ linux-2.4/include/linux/hiddev.h	Sat Jan 31 17:54:44 2004
@@ -204,6 +204,7 @@
 void hiddev_disconnect(struct hid_device *);
 void hiddev_hid_event(struct hid_device *hid, struct hid_field *field,
 		      struct hid_usage *usage, __s32 value);
+void hiddev_report_event(struct hid_device *hid, struct hid_report *report);
 int __init hiddev_init(void);
 void __exit hiddev_exit(void);
 #else

-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Let me make your mind, leave yourself behind
Be not afraid
