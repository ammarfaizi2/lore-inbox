Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVCCFfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVCCFfT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 00:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVCCFfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 00:35:16 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:54897 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261506AbVCCFbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 00:31:35 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][4/11] IB/mthca: add missing break
In-Reply-To: <2005322131.O2Ym8iporsXeypcV@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Wed, 2 Mar 2005 21:31:22 -0800
Message-Id: <2005322131.oecVhU1CS3swCooO@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 05:31:22.0663 (UTC) FILETIME=[3C52DB70:01C51FB2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing break statements in switch in mthca_profile.c (pointed out
by Michael Tsirkin).

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_profile.c	2005-03-02 20:26:03.023831785 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_profile.c	2005-03-02 20:26:11.904904003 -0800
@@ -241,10 +241,12 @@
 		case MTHCA_RES_UDAV:
 			dev->av_table.ddr_av_base = profile[i].start;
 			dev->av_table.num_ddr_avs = profile[i].num;
+			break;
 		case MTHCA_RES_UARC:
 			init_hca->uarc_base   = profile[i].start;
 			init_hca->log_uarc_sz = ffs(request->uarc_size) - 13;
 			init_hca->log_uar_sz  = ffs(request->num_uar) - 1;
+			break;
 		default:
 			break;
 		}

