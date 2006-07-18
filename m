Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWGRVah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWGRVah (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 17:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWGRVah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 17:30:37 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:29071 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932099AbWGRVag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 17:30:36 -0400
Message-ID: <44BD5373.20104@oracle.com>
Date: Tue, 18 Jul 2006 14:32:35 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: akpm <akpm@osdl.org>, tali@admingilde.org
Subject: [PATCH 1/3] kernel-doc: ignore __devinit
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Ignore __devinit in function definitions so that kernel-doc won't
fail on them.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 scripts/kernel-doc |    1 +
 1 file changed, 1 insertion(+)

--- linux-2618-rc2.orig/scripts/kernel-doc
+++ linux-2618-rc2/scripts/kernel-doc
@@ -1518,6 +1518,7 @@ sub dump_function($$) {
     $prototype =~ s/^asmlinkage +//;
     $prototype =~ s/^inline +//;
     $prototype =~ s/^__inline__ +//;
+    $prototype =~ s/__devinit +//;
     $prototype =~ s/^#define +//; #ak added
     $prototype =~ s/__attribute__ \(\([a-z,]*\)\)//;
 

