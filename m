Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbUKCIEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbUKCIEf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 03:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbUKCIEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 03:04:33 -0500
Received: from mail6.speakeasy.net ([216.254.0.206]:20933 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP id S261447AbUKCIEa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 03:04:30 -0500
Date: Wed, 3 Nov 2004 00:04:27 -0800 (PST)
From: vlobanov <vlobanov@speakeasy.net>
To: linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH] /init/version.c
Message-ID: <Pine.LNX.4.58.0411022359001.17128@shell2.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a trivial patch to save a word-length worth of space. Just
something that seemed easy to do while I was reading over the source
code.

Diffed against 2.6.9:
=================================================
--- version.c.orig      2004-11-02 23:54:03.000000000 -0800
+++ version.c   2004-11-02 23:54:36.000000000 -0800
@@ -28,6 +28,6 @@

 EXPORT_SYMBOL(system_utsname);

-const char *linux_banner =
+const char linux_banner[] =
        "Linux version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
        LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION "\n";
=================================================

After looking over the MAINTAINERS file, I have no idea who the right
point of contact / maintainer is for this code. (Or, I simply missed the
right entry while reading, which has been known to happen.) Please advise.

Signed-off-by: Vadim Lobanov
