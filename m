Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVEIUiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVEIUiY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 16:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbVEIUiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 16:38:24 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:16301 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261513AbVEIUiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 16:38:16 -0400
Date: Mon, 9 May 2005 22:38:08 +0200
From: Martin Waitz <tali@admingilde.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] DocBook: only use tabular style for long synopsis
Message-ID: <20050509203808.GT3562@admingilde.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hoi :)

there was a complaint that function declarations are shown tabular
in the documentation since switching to xmlto.
This patch disables tabular mode when the function fits in one line.

---
 Documentation/DocBook/stylesheet.xsl |    1 +
 1 files changed, 1 insertion(+)

Index: linux-docbook/Documentation/DocBook/stylesheet.xsl
===================================================================
--- linux-docbook.orig/Documentation/DocBook/stylesheet.xsl	2005-05-02 09:16:19.000000000 +0200
+++ linux-docbook/Documentation/DocBook/stylesheet.xsl	2005-05-09 22:28:46.328079051 +0200
@@ -2,4 +2,5 @@
 <stylesheet xmlns="http://www.w3.org/1999/XSL/Transform" version="1.0">
 <param name="chunk.quietly">1</param>
 <param name="funcsynopsis.style">ansi</param>
+<param name="funcsynopsis.tabular.threshold">80</param>
 </stylesheet>

-- 
Martin Waitz
