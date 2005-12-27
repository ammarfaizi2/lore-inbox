Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbVL0X3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbVL0X3H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 18:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbVL0X3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 18:29:06 -0500
Received: from quark.didntduck.org ([69.55.226.66]:19143 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S932388AbVL0X3F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 18:29:05 -0500
Message-ID: <43B1CE5E.7020801@didntduck.org>
Date: Tue, 27 Dec 2005 18:29:34 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mail/News 1.5 (X11/20051129)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Remove unused apic_write_atomic
Content-Type: multipart/mixed;
 boundary="------------030903070304090705040400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030903070304090705040400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This function is never used for x86_64.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

--------------030903070304090705040400
Content-Type: text/plain;
 name="apic_write_atomic"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="apic_write_atomic"

[PATCH] Remove unused apic_write_atomic

This function is never used for x86_64.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

---
commit 9a4863865f6c539b799adf0f41de862a7163d819
tree 9bf9251b3a95c76c9086366c459cd067b3669e91
parent 79cac2a221ce18642550a13bed0f0203514923ea
author Brian Gerst <bgerst@didntduck.org> Tue, 27 Dec 2005 18:19:09 -0500
committer Brian Gerst <bgerst@didntduck.org> Tue, 27 Dec 2005 18:19:09 -0500

 include/asm-x86_64/apic.h |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/include/asm-x86_64/apic.h b/include/asm-x86_64/apic.h
index 5647b7d..50cccf5 100644
--- a/include/asm-x86_64/apic.h
+++ b/include/asm-x86_64/apic.h
@@ -42,11 +42,6 @@ static __inline void apic_write(unsigned
 	*((volatile unsigned int *)(APIC_BASE+reg)) = v;
 }
 
-static __inline void apic_write_atomic(unsigned long reg, unsigned int v)
-{
-	xchg((volatile unsigned int *)(APIC_BASE+reg), v);
-}
-
 static __inline unsigned int apic_read(unsigned long reg)
 {
 	return *((volatile unsigned int *)(APIC_BASE+reg));

--------------030903070304090705040400--
