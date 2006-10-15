Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422804AbWJOTVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422804AbWJOTVg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 15:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422811AbWJOTVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 15:21:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:837 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422804AbWJOTVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 15:21:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=pO01Rc0qyeIl+pYfq5xta0YH/D/Y4/SJKDBzXAOZFeBliOBm5eZu1ZJ6kCEQVRgVH9uR5pIGiE1+NKn9JZKduiixFVuUWZaEdlbHRJnLB7RHrfVvjtWfLpBLEklNM/sYqQ/OzV7Z4tPjbubfyP3cHe2o9rNTNbxqOkIHWegp5oE=
Message-ID: <86802c440610151221v2217cb67t354e1ccbcee54b6a@mail.gmail.com>
Date: Sun, 15 Oct 2006 12:21:33 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>, "Andi Kleen" <ak@muc.de>
Subject: re: [PATCH] x86_64: typo in __assign_irq_vector when update pos for vector and offset
Cc: "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       yhlu.kernel@gmail.com
In-Reply-To: <86802c440610150029k28957786v3b313e29f1f52c8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_69030_15662240.1160940093479"
References: <86802c440610150029k28957786v3b313e29f1f52c8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_69030_15662240.1160940093479
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Please use this one

typo with cpu instead of new_cpu

Signed-off-by: Yinghai Lu <yinghai.lu@amd.com>

diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index 44b55f8..756d097 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -651,12 +651,12 @@ next:
                if (vector == IA32_SYSCALL_VECTOR)
                        goto next;
                for_each_cpu_mask(new_cpu, domain)
-                       if (per_cpu(vector_irq, cpu)[vector] != -1)
+                       if (per_cpu(vector_irq, new_cpu)[vector] != -1)
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

------=_Part_69030_15662240.1160940093479
Content-Type: text/x-patch; name=io_apic_x.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_etbtnnos
Content-Disposition: attachment; filename="io_apic_x.diff"

ZGlmZiAtLWdpdCBhL2FyY2gveDg2XzY0L2tlcm5lbC9pb19hcGljLmMgYi9hcmNoL3g4Nl82NC9r
ZXJuZWwvaW9fYXBpYy5jCmluZGV4IDQ0YjU1ZjguLjc1NmQwOTcgMTAwNjQ0Ci0tLSBhL2FyY2gv
eDg2XzY0L2tlcm5lbC9pb19hcGljLmMKKysrIGIvYXJjaC94ODZfNjQva2VybmVsL2lvX2FwaWMu
YwpAQCAtNjUxLDEyICs2NTEsMTIgQEAgbmV4dDoKIAkJaWYgKHZlY3RvciA9PSBJQTMyX1NZU0NB
TExfVkVDVE9SKQogCQkJZ290byBuZXh0OwogCQlmb3JfZWFjaF9jcHVfbWFzayhuZXdfY3B1LCBk
b21haW4pCi0JCQlpZiAocGVyX2NwdSh2ZWN0b3JfaXJxLCBjcHUpW3ZlY3Rvcl0gIT0gLTEpCisJ
CQlpZiAocGVyX2NwdSh2ZWN0b3JfaXJxLCBuZXdfY3B1KVt2ZWN0b3JdICE9IC0xKQogCQkJCWdv
dG8gbmV4dDsKIAkJLyogRm91bmQgb25lISAqLwogCQlmb3JfZWFjaF9jcHVfbWFzayhuZXdfY3B1
LCBkb21haW4pIHsKLQkJCXBvc1tjcHVdLnZlY3RvciA9IHZlY3RvcjsKLQkJCXBvc1tjcHVdLm9m
ZnNldCA9IG9mZnNldDsKKwkJCXBvc1tuZXdfY3B1XS52ZWN0b3IgPSB2ZWN0b3I7CisJCQlwb3Nb
bmV3X2NwdV0ub2Zmc2V0ID0gb2Zmc2V0OwogCQl9CiAJCWlmIChvbGRfdmVjdG9yID49IDApIHsK
IAkJCWludCBvbGRfY3B1Owo=
------=_Part_69030_15662240.1160940093479--
