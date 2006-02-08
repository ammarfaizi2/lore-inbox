Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030492AbWBHDT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030492AbWBHDT0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030484AbWBHDTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:19:16 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:62080 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030479AbWBHDSw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:18:52 -0500
To: torvalds@osdl.org
Subject: [PATCH 12/29] ipv4 NULL noise removal
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net
Message-Id: <E1F6fr2-0006Cf-21@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:18:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1138791275 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 net/ipv4/igmp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

76edc6051e02186fe664ab880447e2d1f96fd884
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 0b4e95f..64ce52b 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -1578,7 +1578,7 @@ static int sf_setstate(struct ip_mc_list
 			new_in = psf->sf_count[MCAST_INCLUDE] != 0;
 		if (new_in) {
 			if (!psf->sf_oldin) {
-				struct ip_sf_list *prev = 0;
+				struct ip_sf_list *prev = NULL;
 
 				for (dpsf=pmc->tomb; dpsf; dpsf=dpsf->sf_next) {
 					if (dpsf->sf_inaddr == psf->sf_inaddr)
-- 
0.99.9.GIT

