Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965135AbWGKEZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965135AbWGKEZI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 00:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbWGKEZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 00:25:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:39735 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965135AbWGKEZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 00:25:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=avrGu3DqVhQs5wloVKdP7Ui/7WHBLjkDE3VVVLrYyEkEcznqbmEllQ4bfSr6nPwCgurPrnlyxItk7RsndyJrBxzw/1n7Oq7LkGpEcxsbRnm2CkHtYGqBSxTQOp9DxNbOrOwuPvW8d2lWxNMbkvcHXdCO0z287gSit7UfDpdGIg4=
Message-ID: <489ecd0c0607102125i14917a6bi73bbd299b87d7d5a@mail.gmail.com>
Date: Tue, 11 Jul 2006 12:25:05 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Export two symbols for drivers to use
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_16899_15763531.1152591905287"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_16899_15763531.1152591905287
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

   The nommu.c needs to export two more symbols for drivers to use:
remap_pfn_range and unmap_mapping_range.

Signed-off-by: Luke Yang <luke.adi@gmail.com>


 nommu.c |    2 ++
 1 files changed, 2 insertions(+)


-- diff --git a/mm/nommu.c b/mm/nommu.c
index 5151c44..c576df7 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1070,6 +1070,7 @@ int remap_pfn_range(struct vm_area_struc
        vma->vm_start = vma->vm_pgoff << PAGE_SHIFT;
        return 0;
 }
+EXPORT_SYMBOL(remap_pfn_range);

 void swap_unplug_io_fn(struct backing_dev_info *bdi, struct page *page)
 {
@@ -1090,6 +1091,7 @@ void unmap_mapping_range(struct address_
                         int even_cows)
 {
 }
+EXPORT_SYMBOL(unmap_mapping_range);

 /*
  * Check that a process has enough memory to allocate a new virtual

Best regards,
Luke Yang
luke.adi@gmail.com

------=_Part_16899_15763531.1152591905287
Content-Type: text/x-patch; name="nommu_export_symbols.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="nommu_export_symbols.patch"
X-Attachment-Id: f_ephrdw46

ZGlmZiAtLWdpdCBhL21tL25vbW11LmMgYi9tbS9ub21tdS5jCmluZGV4IDUxNTFjNDQuLmM1NzZk
ZjcgMTAwNjQ0Ci0tLSBhL21tL25vbW11LmMKKysrIGIvbW0vbm9tbXUuYwpAQCAtMTA3MCw2ICsx
MDcwLDcgQEAgaW50IHJlbWFwX3Bmbl9yYW5nZShzdHJ1Y3Qgdm1fYXJlYV9zdHJ1YwogCXZtYS0+
dm1fc3RhcnQgPSB2bWEtPnZtX3Bnb2ZmIDw8IFBBR0VfU0hJRlQ7CiAJcmV0dXJuIDA7CiB9CitF
WFBPUlRfU1lNQk9MKHJlbWFwX3Bmbl9yYW5nZSk7CiAKIHZvaWQgc3dhcF91bnBsdWdfaW9fZm4o
c3RydWN0IGJhY2tpbmdfZGV2X2luZm8gKmJkaSwgc3RydWN0IHBhZ2UgKnBhZ2UpCiB7CkBAIC0x
MDkwLDYgKzEwOTEsNyBAQCB2b2lkIHVubWFwX21hcHBpbmdfcmFuZ2Uoc3RydWN0IGFkZHJlc3Nf
CiAJCQkgaW50IGV2ZW5fY293cykKIHsKIH0KK0VYUE9SVF9TWU1CT0wodW5tYXBfbWFwcGluZ19y
YW5nZSk7CiAKIC8qCiAgKiBDaGVjayB0aGF0IGEgcHJvY2VzcyBoYXMgZW5vdWdoIG1lbW9yeSB0
byBhbGxvY2F0ZSBhIG5ldyB2aXJ0dWFsCg==
------=_Part_16899_15763531.1152591905287--
