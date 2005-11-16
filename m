Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030428AbVKPShz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030428AbVKPShz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 13:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030431AbVKPShz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 13:37:55 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:22664 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1030428AbVKPShy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 13:37:54 -0500
Message-ID: <437B7C7B.5090604@ru.mvista.com>
Date: Wed, 16 Nov 2005 21:37:47 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Kumar Gala <galak@kernel.crashing.org>,
       Pantelis Antoniou <panto@intracom.gr>
Subject: [PATCH] ppc32: Added missing define for fs_enet Ethernet driver
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the FCC_PSMR_RMII defenition, which is used in fs_enet to enable
RMII mode.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>


---

  include/asm-ppc/cpm2.h |    2 ++
  1 files changed, 2 insertions(+), 0 deletions(-)

applies-to: a4efeaa72988e2e2e2604535283e7f274bc0bc53
339019bec61c89ca21c48df47519c27a44eab7f5
diff --git a/include/asm-ppc/cpm2.h b/include/asm-ppc/cpm2.h
index 43d2ebb..e952d55 100644
--- a/include/asm-ppc/cpm2.h
+++ b/include/asm-ppc/cpm2.h
@@ -1091,5 +1091,7 @@ typedef struct im_idma {
  #define CPM_IMMR_OFFSET	0x101a8
  #endif

+#define FCC_PSMR_RMII   ((uint)0x00020000)      /* Use RMII interface */
+
  #endif /* __CPM2__ */
  #endif /* __KERNEL__ */
---
Sincerely,
Vitaly


