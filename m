Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbVJ2PfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbVJ2PfL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 11:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbVJ2PfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 11:35:11 -0400
Received: from alephnull.demon.nl ([83.160.184.112]:5819 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S1751194AbVJ2PfK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 11:35:10 -0400
Date: Sat, 29 Oct 2005 17:35:08 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH,trivial] hfs needs nls
Message-ID: <20051029153508.GA32296@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reported by Eddy Petrisor (eddy dot petrisor at gmail dot com).

fs/built-in.o(.text+0x35fdc): In function `hfs_mdb_put':
: undefined reference to `unload_nls'
fs/built-in.o(.text+0x35ff1): In function `hfs_mdb_put':
: undefined reference to `unload_nls'
fs/built-in.o(.text+0x367a5): In function `parse_options':
super.c: undefined reference to `load_nls'
fs/built-in.o(.text+0x367db):super.c: undefined reference to `load_nls'
fs/built-in.o(.text+0x36938):super.c: undefined reference to `load_nls_default'

Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>

--- linux-2.6.14/fs/Kconfig.orig	2005-10-29 17:32:35.000000000 +0200
+++ linux-2.6.14/fs/Kconfig	2005-10-29 17:32:52.000000000 +0200
@@ -898,6 +898,7 @@
 config HFS_FS
 	tristate "Apple Macintosh file system support (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
+	select NLS
 	help
 	  If you say Y here, you will be able to mount Macintosh-formatted
 	  floppy disks and hard drive partitions with full read-write access.
