Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbTKYQcW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 11:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbTKYQcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 11:32:22 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:5900 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S262110AbTKYQcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 11:32:19 -0500
Date: Tue, 25 Nov 2003 16:33:13 +0000
From: Joe Thornber <thornber@sistina.com>
To: Joe Thornber <thornber@sistina.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@osdl.org>
Subject: [Patch 3/5] dm: make v4 of the ioctl interface the default
Message-ID: <20031125163313.GD524@reti>
References: <20031125162451.GA524@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031125162451.GA524@reti>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the version-4 ioctl interface the default kernel configuration option.
If you have out of date tools you will need to use the v1 interface.

--- diff/drivers/md/Kconfig	2003-10-09 09:47:34.000000000 +0100
+++ source/drivers/md/Kconfig	2003-11-25 15:47:48.000000000 +0000
@@ -138,6 +138,7 @@
 config DM_IOCTL_V4
 	bool "ioctl interface version 4"
 	depends on BLK_DEV_DM
+	default y
 	---help---
 	  Recent tools use a new version of the ioctl interface, only
           select this option if you intend using such tools.
