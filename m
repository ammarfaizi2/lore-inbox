Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWJOH35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWJOH35 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 03:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWJOH35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 03:29:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:6818 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964818AbWJOH3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 03:29:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uDFhBxb6tuE+bKIIbRroAynZ2tb4mYXawEJKOsGqTDx4NL+VqTjoSzMxA3w5OLHYa4ZKXwGhEHMZW70IZtCZJaPJCmFXCN69bO0aXZ+qsUIvhRNijOGJd9rU9i/F2XwsMalDP3bWOUCfbUQOFjorzXgCzjODohuwqgNRDxxfQr0=
Message-ID: <86802c440610150029k28957786v3b313e29f1f52c8@mail.gmail.com>
Date: Sun, 15 Oct 2006 00:29:16 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>, "Andi Kleen" <ak@muc.de>
Subject: [PATCH] x86_64: typo in __assign_irq_vector when update pos for vector and offset
Cc: "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       yhlu.kernel@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

typo with cpu instead of new_cpu when update the pos struct.

Signed-off-by: Yinghai Lu <yinghai.lu@amd.com>

diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index 44b55f8..3857440 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -655,8 +655,8 @@ next:
                                goto next;
                /* Found one! */
                for_each_cpu_mask(new_cpu, domain) {
-                       pos[cpu].vector = vector;
-                       pos[cpu].offset = offset;
+                       pos[new_cpu].vector = vector;
+                       pos[new_cpu].offset = offset;
                }
                if (old_vector >= 0) {
                        int old_cpu;
