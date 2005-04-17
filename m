Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbVDQVc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVDQVc6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 17:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVDQVc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 17:32:58 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:46340 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261488AbVDQVc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 17:32:56 -0400
Date: Sun, 17 Apr 2005 23:32:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, gregkh@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fix "make mandocs"
Message-ID: <20050417213255.GT3625@stusta.de>
References: <20050411012532.58593bc1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050411012532.58593bc1.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 01:25:32AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.12-rc2-mm2:
>...
>  gregkh-driver.patch
>...

Due to the removal of class_simple.c, "make mandocs" no longer works.

This patch fixes this issue.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc2-mm3-full/Documentation/DocBook/kernel-api.tmpl.old	2005-04-17 23:26:10.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/Documentation/DocBook/kernel-api.tmpl	2005-04-17 23:26:17.000000000 +0200
@@ -338,7 +338,6 @@
 X!Iinclude/linux/device.h
 -->
 !Edrivers/base/driver.c
-!Edrivers/base/class_simple.c
 !Edrivers/base/core.c
 !Edrivers/base/firmware_class.c
 !Edrivers/base/transport_class.c

