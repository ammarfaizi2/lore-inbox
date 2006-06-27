Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWF0MtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWF0MtI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 08:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWF0MtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 08:49:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:20557 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932306AbWF0MtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 08:49:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=Dr6dXoOsd5VZfWFOJuOxXTMy7eEs4vNcT6vjQf44L2ggscLOjx0bi2RjxS4vgU8KQW3hePuBmBs179yRfhizh31Au8s49N2wSxT26sWHwNOzMkH+sb6lDkPOqT1gKxRtofMw21jNwptmUc5/5i3ZseYm5SWXCxvyKrjdyQ/m3E0=
Message-ID: <44A12A4F.8030204@innova-card.com>
Date: Tue, 27 Jun 2006 14:53:35 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Franck <vagabon.xyz@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Mel Gorman <mel@skynet.ie>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/7] bootmem: mark link_bootmem() as part of the __init section
References: <449FDD02.2090307@innova-card.com> <1151344691.10877.44.camel@localhost.localdomain>
In-Reply-To: <1151344691.10877.44.camel@localhost.localdomain>
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
1.4.0.g64e8


