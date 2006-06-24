Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWFXEdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWFXEdO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 00:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWFXEdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 00:33:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31634 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932160AbWFXEdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 00:33:13 -0400
Date: Sat, 24 Jun 2006 00:33:08 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: fix typo in acpi video brightness changes.
Message-ID: <20060624043308.GA21753@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent possible null dereference due to misplaced ;

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/drivers/acpi/video.c~	2006-06-24 00:30:39.000000000 -0400
+++ linux-2.6/drivers/acpi/video.c	2006-06-24 00:31:04.000000000 -0400
@@ -1645,7 +1645,7 @@ static int acpi_video_bus_put_devices(st
 			printk(KERN_WARNING PREFIX
 			       "hhuuhhuu bug in acpi video driver.\n");
 
-		if (data->brightness);
+		if (data->brightness)
 			kfree(data->brightness->levels);
 		kfree(data->brightness);
 		kfree(data);

-- 
http://www.codemonkey.org.uk
