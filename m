Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbTEEUzk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 16:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbTEEUzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 16:55:40 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:26575 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261319AbTEEUzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 16:55:39 -0400
Date: Mon, 5 May 2003 23:08:11 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Only use MSDOS-Partitions by default on X86
Message-ID: <20030505210811.GC7049@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch makes a lot of sense in my eyes, but maybe someone
disagrees. Applies cleanly to current 2.4.

Comments?

Jörn

-- 
Everything should be made as simple as possible, but not simpler.
-- Albert Einstein

--- linux-2.4.20/fs/partitions/Config.in~msdospartitions	2002-11-29 00:53:15.000000000 +0100
+++ linux-2.4.20/fs/partitions/Config.in	2003-04-10 20:12:41.000000000 +0200
@@ -37,9 +37,7 @@
    if [ "$CONFIG_ALPHA" = "y" ]; then
       define_bool CONFIG_OSF_PARTITION y
    fi
-   if [ "$CONFIG_AMIGA" != "y" -a "$CONFIG_ATARI" != "y" -a \
-        "$CONFIG_MAC" != "y" -a "$CONFIG_SGI_IP22" != "y" -a \
-	"$CONFIG_SGI_IP27" != "y" ]; then
+   if [ "$CONFIG_PARTITION_ADVANCED" != "y" -a "$CONFIG_X86" = "y" ]; then
       define_bool CONFIG_MSDOS_PARTITION y
    fi
    if [ "$CONFIG_AMIGA" = "y" -o "$CONFIG_AFFS_FS" = "y" ]; then
