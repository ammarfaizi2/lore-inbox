Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbUJaQ1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbUJaQ1U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 11:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbUJaQ1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 11:27:20 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:55504 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261305AbUJaQ1O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 11:27:14 -0500
Date: Sun, 31 Oct 2004 17:27:10 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-kernel@vger.kernel.org
Subject: Disambiguation for panic_timeout's sysctl
Message-ID: <Pine.LNX.4.53.0410311721470.20529@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The /proc/sys/kernel/panic file looked to me like it was something like
/proc/sysrq-trigger -- until I looked into the kernel sources which reveal that
it sets the variable "panic_timeout" in kernel/sched.c.
I'm up for disambiguating this, patch appended.


Signed-off by: Jan Engelhardt <jengelh@linux01.gwdg.de>

# File:  fixpanicname.diff
# Class: Disambiguation
#
--- linux-2.6.9-rc2/kernel/sysctl.c	2004-10-31 17:10:00.976522528 +0100
+++ modified/kernel/sysctl.c	2004-10-31 17:09:50.970043000 +0100
@@ -276,7 +276,7 @@ static ctl_table kern_table[] = {
 	},
 	{
 		.ctl_name	= KERN_PANIC,
-		.procname	= "panic",
+		.procname	= "panic_timeout",
 		.data		= &panic_timeout,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
## eof


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
