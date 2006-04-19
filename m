Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWDSTR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWDSTR7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 15:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWDSTR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 15:17:59 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:53442 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751187AbWDSTRi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 15:17:38 -0400
Subject: [PATCH] tpm: fix missing string
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 14:13:41 -0500
Message-Id: <1145474021.4894.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A string corresponding to the tcpa_pc_event_id POST_CONTENTS was missing
causing an overflow bug when access was attempted in the get_event_name
function.

This bug was found by Coverity.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
 drivers/char/tpm/tpm_bios.c |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.17-rc1/drivers/char/tpm/tpm_bios.c	2006-04-18 15:14:45.626390250 -0500
+++ linux-2.6.17-rc1-tpm/drivers/char/tpm/tpm_bios.c	2006-04-19 13:53:55.746954250 -0500
@@ -134,6 +134,7 @@ static const char* tcpa_pc_event_id_stri
 	"S-CRTM Version",
 	"S-CRTM Contents",
 	"S-CRTM POST Contents",
+	"POST Contents",
 };
 
 /* returns pointer to start of pos. entry of tcg log */


