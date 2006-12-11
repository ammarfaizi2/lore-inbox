Return-Path: <linux-kernel-owner+w=401wt.eu-S1762877AbWLKMfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762877AbWLKMfw (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 07:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762878AbWLKMfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 07:35:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43527 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762877AbWLKMfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 07:35:52 -0500
From: David Howells <dhowells@redhat.com>
To: Akinobu Mita <akinobu.mita@gmail.com>, torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: Mark bitrevX() functions as const
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 11 Dec 2006 12:35:36 +0000
Message-ID: <29447.1165840536@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mark the bit reversal functions as being const as they always return the same
output for any given input.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/linux/bitrev.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bitrev.h b/include/linux/bitrev.h
index 05e540d..032056b 100644
--- a/include/linux/bitrev.h
+++ b/include/linux/bitrev.h
@@ -5,11 +5,11 @@ #include <linux/types.h>
 
 extern u8 const byte_rev_table[256];
 
-static inline u8 bitrev8(u8 byte)
+static inline __attribute__((const)) u8 bitrev8(u8 byte)
 {
 	return byte_rev_table[byte];
 }
 
-extern u32 bitrev32(u32 in);
+extern __attribute__((const)) u32 bitrev32(u32 in);
 
 #endif /* _LINUX_BITREV_H */
