Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbUKNBbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbUKNBbY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 20:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbUKNBbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 20:31:24 -0500
Received: from hera.cwi.nl ([192.16.191.8]:7137 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261229AbUKNBae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 20:30:34 -0500
Date: Sun, 14 Nov 2004 02:30:29 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] __init in reboot.c
Message-ID: <20041114013028.GA3945@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -uprN -X /linux/dontdiff a/arch/i386/kernel/reboot.c b/arch/i386/kernel/reboot.c
--- a/arch/i386/kernel/reboot.c	2004-08-26 22:05:07.000000000 +0200
+++ b/arch/i386/kernel/reboot.c	2004-11-13 22:40:51.000000000 +0100
@@ -137,7 +137,7 @@ static struct dmi_system_id __initdata r
 	{ }
 };
 
-static int reboot_init(void)
+static int __init reboot_init(void)
 {
 	dmi_check_system(reboot_dmi_table);
 	return 0;
