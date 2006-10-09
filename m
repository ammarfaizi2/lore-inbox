Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751753AbWJIKFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbWJIKFO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 06:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbWJIKFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 06:05:14 -0400
Received: from mailer.campus.mipt.ru ([194.85.82.4]:42941 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S1751753AbWJIKFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 06:05:12 -0400
Date: Mon, 9 Oct 2006 14:06:33 +0400
Message-Id: <200610091006.k99A6X7I032599@vass.7ka.mipt.ru>
From: "Vasily Tarasov" <vtaras@openvz.org>
To: "Jens Axboe" <axboe@suse.de>
CC: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: [PATCH] block layer: useless elevator_type field in elevator_type structure
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 09 Oct 2006 14:05:14 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

elevator_type field in elevator_type structure is useless:
it isn't used anywhere in kernel sources.

Signed-off-by: Vasily Tarasov <vtaras@openvz.org>
--

--- linux-2.6.18/include/linux/elevator.h.orig	2006-10-09 12:31:58.000000000 +0400
+++ linux-2.6.18/include/linux/elevator.h	2006-10-09 12:32:46.000000000 +0400
@@ -66,7 +66,6 @@ struct elevator_type
 {
 	struct list_head list;
 	struct elevator_ops ops;
-	struct elevator_type *elevator_type;
 	struct elv_fs_entry *elevator_attrs;
 	char elevator_name[ELV_NAME_MAX];
 	struct module *elevator_owner;
