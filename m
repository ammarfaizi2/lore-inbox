Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWBXXmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWBXXmm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 18:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWBXXmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 18:42:42 -0500
Received: from fmr19.intel.com ([134.134.136.18]:34199 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S964799AbWBXXml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 18:42:41 -0500
Date: Fri, 24 Feb 2006 15:42:30 -0800 (PST)
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
X-X-Sender: jbrandeb@lindenhurst-2.jf.intel.com
To: marcelo.tosatti@cyclades.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4.32-pre2] build fix: auto_fs4 changes broke ppc64 build
Message-ID: <Pine.LNX.4.64.0602241536040.26029@lindenhurst-2.jf.intel.com>
ReplyTo: "Jesse Brandeburg" <jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a couple of #include statements verified to fix the compile
for ppc64 and probably will fix the compile on parisc.  I just noticed
parisc had the same problem.  ppc64 would not build without this fix.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

---

  arch/parisc/kernel/ioctl32.c |    1 +
  arch/ppc64/kernel/ioctl32.c  |    1 +
  2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/parisc/kernel/ioctl32.c b/arch/parisc/kernel/ioctl32.c
index 8e12397..7b52a77 100644
--- a/arch/parisc/kernel/ioctl32.c
+++ b/arch/parisc/kernel/ioctl32.c
@@ -35,6 +35,7 @@
  #include <linux/cdrom.h>
  #include <linux/loop.h>
  #include <linux/auto_fs.h>
+#include <linux/auto_fs4.h>
  #include <linux/devfs_fs.h>
  #include <linux/tty.h>
  #include <linux/vt_kern.h>
diff --git a/arch/ppc64/kernel/ioctl32.c b/arch/ppc64/kernel/ioctl32.c
index 1cc4c39..53546b9 100644
--- a/arch/ppc64/kernel/ioctl32.c
+++ b/arch/ppc64/kernel/ioctl32.c
@@ -49,6 +49,7 @@
  #include <linux/cdrom.h>
  #include <linux/loop.h>
  #include <linux/auto_fs.h>
+#include <linux/auto_fs4.h>
  #include <linux/devfs_fs.h>
  #include <linux/tty.h>
  #include <linux/vt_kern.h>
