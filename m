Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030513AbWJJVtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030513AbWJJVtb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030529AbWJJVtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:49:21 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36027 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030518AbWJJVtS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:49:18 -0400
To: torvalds@osdl.org
Subject: [PATCH] strndup() would better take size_t, not int
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPTR-0007Rw-Ga@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:49:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/irda/irias_object.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/irda/irias_object.c b/net/irda/irias_object.c
index a154b1d..56292ab 100644
--- a/net/irda/irias_object.c
+++ b/net/irda/irias_object.c
@@ -43,7 +43,7 @@ struct ias_value irias_missing = { IAS_M
  *
  * Faster, check boundary... Jean II
  */
-static char *strndup(char *str, int max)
+static char *strndup(char *str, size_t max)
 {
 	char *new_str;
 	int len;
-- 
1.4.2.GIT


