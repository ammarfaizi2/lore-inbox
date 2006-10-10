Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030526AbWJJVtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030526AbWJJVtV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030532AbWJJVtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:49:19 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35259 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030529AbWJJVtJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:49:09 -0400
To: torvalds@osdl.org
Subject: [PATCH] ptrdiff_t is %t, not %z
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPTH-0007Ra-GA@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:49:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/ipv4/ipvs/ip_vs_ftp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/ipv4/ipvs/ip_vs_ftp.c b/net/ipv4/ipvs/ip_vs_ftp.c
index e433cb0..6d398f1 100644
--- a/net/ipv4/ipvs/ip_vs_ftp.c
+++ b/net/ipv4/ipvs/ip_vs_ftp.c
@@ -274,7 +274,7 @@ static int ip_vs_ftp_in(struct ip_vs_app
 	while (data <= data_limit - 6) {
 		if (strnicmp(data, "PASV\r\n", 6) == 0) {
 			/* Passive mode on */
-			IP_VS_DBG(7, "got PASV at %zd of %zd\n",
+			IP_VS_DBG(7, "got PASV at %td of %td\n",
 				  data - data_start,
 				  data_limit - data_start);
 			cp->app_data = &ip_vs_ftp_pasv;
-- 
1.4.2.GIT


