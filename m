Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWGDPkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWGDPkW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 11:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWGDPkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 11:40:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:13116 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751272AbWGDPkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 11:40:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=uEUF8iFdJdPcXM+P9v9dOPRi8IF6jGDNoLIeNeMQZMrL2i6em1tXRXso7gwHNs2dfXJYmDBGXfTIyJCekb1QIDy/g6hyPjziJgQZiv2BjnI5LuaqqXW1BGs3QAutOWZru8O1T9446IT9j5dOfSGCgu/pLb9CPVmGiGba9S7VF2o=
Message-ID: <44AA8D02.2090602@innova-card.com>
Date: Tue, 04 Jul 2006 17:45:06 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Franck <vagabon.xyz@gmail.com>
Subject: [PATCH 2/7] bootmem: mark link_bootmem() as part of the __init section
References: <44AA89D2.8010307@innova-card.com>
In-Reply-To: <44AA89D2.8010307@innova-card.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>

---
 mm/bootmem.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mm/bootmem.c b/mm/bootmem.c
index d213fed..d0a34fe 100644
--- a/mm/bootmem.c
+++ b/mm/bootmem.c
@@ -56,7 +56,7 @@ unsigned long __init bootmem_bootmap_pag
 /*
  * link bdata in order
  */
-static void link_bootmem(bootmem_data_t *bdata)
+static void __init link_bootmem(bootmem_data_t *bdata)
 {
 	bootmem_data_t *ent;
 	if (list_empty(&bdata_list)) {
-- 
1.4.1.g35c6

