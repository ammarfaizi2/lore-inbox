Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756059AbWKSEWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756059AbWKSEWQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 23:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756088AbWKSEWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 23:22:16 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:57069 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1756059AbWKSEWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 23:22:15 -0500
Date: Sat, 18 Nov 2006 20:22:06 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: reiserfs-dev@namesys.com, sam@ravnborg.org, ak@suse.de
Subject: reiserfs NET=n build error
Message-Id: <20061118202206.01bdc0e0.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_NET=n and REISERFS_FS=m (randconfig), kernel build ends with

Kernel: arch/x86_64/boot/bzImage is ready  (#15)
  Building modules, stage 2.
  MODPOST 137 modules
WARNING: "csum_partial" [fs/reiserfs/reiserfs.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

on both 2.6.19-rc6 and 2.6.19-rc6-git2.

Looks like arch/x86_64/lib/lib.a is not being linked into the
final kernel image for some reason.  lib.a does contain csum_partial.

---
~Randy
http://oss.oracle.com/~rdunlap/configs/config-rand-reiser-csum
