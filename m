Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbVL1ABE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbVL1ABE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 19:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbVL1ABE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 19:01:04 -0500
Received: from quark.didntduck.org ([69.55.226.66]:18135 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S932406AbVL1ABD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 19:01:03 -0500
Message-ID: <43B1D5E0.90908@didntduck.org>
Date: Tue, 27 Dec 2005 19:01:36 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mail/News 1.5 (X11/20051129)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Remove unneeded packed attribute
Content-Type: multipart/mixed;
 boundary="------------060403050603080200060508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060403050603080200060508
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

GCC 4.1 gives the following warning:
include/asm/mpspec.h:79: warning: ‘packed’ attribute ignored for field 
of type ‘unsigned char[5u]’

The packed attribute isn't really necessary anyways so just remove it.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

--------------060403050603080200060508
Content-Type: text/plain;
 name="mpspec-packed"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="mpspec-packed"

[PATCH] Remove unneeded packed attribute

GCC 4.1 gives the following warning:
include/asm/mpspec.h:79: warning: â€˜packedâ€™ attribute ignored for field of type â€˜unsigned char[5u]â€™

The packed attribute isn't really necessary anyways so just remove it.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

---
commit 58c5813206aec0df47a061ad31c457cd6e176d12
tree 2b900ac50c67c30f87115b1a9f752f9f2e871556
parent 9a4863865f6c539b799adf0f41de862a7163d819
author Brian Gerst <bgerst@didntduck.org> Tue, 27 Dec 2005 18:48:21 -0500
committer Brian Gerst <bgerst@didntduck.org> Tue, 27 Dec 2005 18:48:21 -0500

 include/asm-i386/mpspec_def.h |    2 +-
 include/asm-x86_64/mpspec.h   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-i386/mpspec_def.h b/include/asm-i386/mpspec_def.h
index a961093..76feedf 100644
--- a/include/asm-i386/mpspec_def.h
+++ b/include/asm-i386/mpspec_def.h
@@ -75,7 +75,7 @@ struct mpc_config_bus
 {
 	unsigned char mpc_type;
 	unsigned char mpc_busid;
-	unsigned char mpc_bustype[6] __attribute((packed));
+	unsigned char mpc_bustype[6];
 };
 
 /* List of Bus Type string values, Intel MP Spec. */
diff --git a/include/asm-x86_64/mpspec.h b/include/asm-x86_64/mpspec.h
index 6f8a17d..10248a9 100644
--- a/include/asm-x86_64/mpspec.h
+++ b/include/asm-x86_64/mpspec.h
@@ -76,7 +76,7 @@ struct mpc_config_bus
 {
 	unsigned char mpc_type;
 	unsigned char mpc_busid;
-	unsigned char mpc_bustype[6] __attribute((packed));
+	unsigned char mpc_bustype[6];
 };
 
 /* List of Bus Type string values, Intel MP Spec. */

--------------060403050603080200060508--
