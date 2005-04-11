Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbVDKUDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbVDKUDG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 16:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVDKUDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 16:03:06 -0400
Received: from mail.dif.dk ([193.138.115.101]:41668 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261908AbVDKUCt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 16:02:49 -0400
Date: Mon, 11 Apr 2005 22:05:28 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steven French <sfrench@us.ibm.com>
Cc: Steve French <smfrench@austin.rr.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cifs: md4 cleanup - function definitions
Message-ID: <Pine.LNX.4.62.0504112202360.2480@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Function names on same line as return type.

Patch is also available here: 
	http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_md4-funct.patch


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


--- linux-2.6.12-rc2-mm2-orig/fs/cifs/md4.c	2005-04-05 21:21:42.000000000 +0200
+++ linux-2.6.12-rc2-mm2/fs/cifs/md4.c	2005-04-09 10:04:58.000000000 +0200
@@ -25,26 +25,22 @@
 
 /* NOTE: This code makes no attempt to be fast! */
 
-static __u32
-F(__u32 X, __u32 Y, __u32 Z)
+static __u32 F(__u32 X, __u32 Y, __u32 Z)
 {
 	return (X & Y) | ((~X) & Z);
 }
 
-static __u32
-G(__u32 X, __u32 Y, __u32 Z)
+static __u32 G(__u32 X, __u32 Y, __u32 Z)
 {
 	return (X & Y) | (X & Z) | (Y & Z);
 }
 
-static __u32
-H(__u32 X, __u32 Y, __u32 Z)
+static __u32 H(__u32 X, __u32 Y, __u32 Z)
 {
 	return X ^ Y ^ Z;
 }
 
-static __u32
-lshift(__u32 x, int s)
+static __u32 lshift(__u32 x, int s)
 {
 	x &= 0xFFFFFFFF;
 	return ((x << s) & 0xFFFFFFFF) | (x >> (32 - s));
@@ -55,8 +51,7 @@ lshift(__u32 x, int s)
 #define ROUND3(a,b,c,d,k,s) (*a) = lshift((*a) + H(*b,*c,*d) + X[k] + (__u32)0x6ED9EBA1,s)
 
 /* this applies md4 to 64 byte chunks */
-static void
-mdfour64(__u32 * M, __u32 * A, __u32 *B, __u32 * C, __u32 *D)
+static void mdfour64(__u32 *M, __u32 *A, __u32 *B, __u32 *C, __u32 *D)
 {
 	int j;
 	__u32 AA, BB, CC, DD;
@@ -136,8 +131,7 @@ mdfour64(__u32 * M, __u32 * A, __u32 *B,
 		X[j] = 0;
 }
 
-static void
-copy64(__u32 * M, unsigned char *in)
+static void copy64(__u32 *M, unsigned char *in)
 {
 	int i;
 
@@ -146,8 +140,7 @@ copy64(__u32 * M, unsigned char *in)
 		    (in[i * 4 + 1] << 8) | (in[i * 4 + 0] << 0);
 }
 
-static void
-copy4(unsigned char *out, __u32 x)
+static void copy4(unsigned char *out, __u32 x)
 {
 	out[0] = x & 0xFF;
 	out[1] = (x >> 8) & 0xFF;
@@ -156,8 +149,7 @@ copy4(unsigned char *out, __u32 x)
 }
 
 /* produce a md4 message digest from data of length n bytes */
-void
-mdfour(unsigned char *out, unsigned char *in, int n)
+void mdfour(unsigned char *out, unsigned char *in, int n)
 {
 	unsigned char buf[128];
 	__u32 M[16];


