Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030343AbWJYVNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbWJYVNq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 17:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030345AbWJYVNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 17:13:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:62054 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030343AbWJYVNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 17:13:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=qGt5akgtDiM5BuZ+Fq8QExeE08fp2vg5racST3qDy6dX1dAEIaha8WEnz55kkSV5Y9Z/x1BN7lWrHm5GUQkvbmSCtG0u9CL2vqZGSv7FH5inP52ys8w0pFKUfMP1psaxVhMQTCBVhBqUXZA4rLNdndgfQ6cQuLfmElev8+HyA00=
Message-ID: <453FD381.70309@gmail.com>
Date: Wed, 25 Oct 2006 14:13:37 -0700
From: nkalmala <nkalmala@gmail.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.13) Gecko/20060414
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: trivial@kernel.org
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH]trivial: booke reg MCSR msg misquoted
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PPC/booke reg MCSR value misquoted

Signed-off-by: nkalmala <nkalmala@gmail.com>
---

diff --git a/arch/ppc/kernel/traps.c b/arch/ppc/kernel/traps.c
index aafc8e8..e35c248 100644
--- a/arch/ppc/kernel/traps.c
+++ b/arch/ppc/kernel/traps.c
@@ -316,7 +316,7 @@ #elif defined (CONFIG_E500)
 	if (reason & MCSR_BUS_RBERR)
 		printk("Bus - Read Data Bus Error\n");
 	if (reason & MCSR_BUS_WBERR)
-		printk("Bus - Read Data Bus Error\n");
+		printk("Bus - Write Data Bus Error\n");
 	if (reason & MCSR_BUS_IPERR)
 		printk("Bus - Instruction Parity Error\n");
 	if (reason & MCSR_BUS_RPERR)


