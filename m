Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269312AbTCDHhB>; Tue, 4 Mar 2003 02:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269313AbTCDHhB>; Tue, 4 Mar 2003 02:37:01 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:45771 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S269312AbTCDHhA>; Tue, 4 Mar 2003 02:37:00 -0500
Date: Tue, 4 Mar 2003 08:44:39 +0100
From: Dominik Brodowski <linux@brodo.de>
To: mochel@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sysfs: compile fix for fs/sysfs/mount.c
Message-ID: <20030304074439.GB5545@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sysfs_init is __init, but without a declaration of that gcc 3.2. tends to
start screaming.

	Dominik

diff -ruN linux-original/fs/sysfs/mount.c linux/fs/sysfs/mount.c
--- linux-original/fs/sysfs/mount.c	2003-03-04 08:27:10.000000000 +0100
+++ linux/fs/sysfs/mount.c	2003-03-04 08:32:13.000000000 +0100
@@ -7,6 +7,7 @@
 #include <linux/fs.h>
 #include <linux/mount.h>
 #include <linux/pagemap.h>
+#include <linux/init.h>
 
 #include "sysfs.h"
 
