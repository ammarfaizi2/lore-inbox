Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263865AbUGRMZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263865AbUGRMZx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 08:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUGRMZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 08:25:52 -0400
Received: from delta.ds3.agh.edu.pl ([149.156.124.3]:14602 "EHLO
	pluto.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S263865AbUGRMZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 08:25:49 -0400
From: =?iso-8859-2?q?Pawe=B3_Sikora?= <pluto@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] security/selinux/hooks.c:1898: error: `PER_CLEAR_ON_SETID' undeclared
Date: Sun, 18 Jul 2004 14:25:43 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Hxm+AXxNBxz5byy"
Message-Id: <200407181425.43629.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_Hxm+AXxNBxz5byy
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

  CC      security/selinux/hooks.o
security/selinux/hooks.c: In function `selinux_bprm_apply_creds':
security/selinux/hooks.c:1898: error: `PER_CLEAR_ON_SETID' undeclared
                                      (first use in this function)
security/selinux/hooks.c:1898: error: (Each undeclared identifier
                                      is reported only once
security/selinux/hooks.c:1898: error: for each function it appears in.)

-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)

--Boundary-00=_Hxm+AXxNBxz5byy
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="hook.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hook.patch"

--- linux-2.6.8-rc2/security/selinux/hooks.c.orig	2004-07-18 11:56:07.000000000 +0200
+++ linux-2.6.8-rc2/security/selinux/hooks.c	2004-07-18 14:21:27.429622416 +0200
@@ -63,6 +63,7 @@
 #include <net/ipv6.h>
 #include <linux/hugetlb.h>
 #include <linux/major.h>
+#include <linux/personality.h>
 
 #include "avc.h"
 #include "objsec.h"

--Boundary-00=_Hxm+AXxNBxz5byy--
