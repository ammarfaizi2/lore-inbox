Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031638AbWLBO4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031638AbWLBO4a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 09:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031719AbWLBO43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 09:56:29 -0500
Received: from wavehammer.waldi.eu.org ([82.139.201.20]:42440 "EHLO
	wavehammer.waldi.eu.org") by vger.kernel.org with ESMTP
	id S1031638AbWLBO43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 09:56:29 -0500
Date: Sat, 2 Dec 2006 15:56:27 +0100
From: Bastian Blank <bastian@waldi.eu.org>
To: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH] s390 - fix posix types
Message-ID: <20061202145627.GA32490@wavehammer.waldi.eu.org>
Mail-Followup-To: Bastian Blank <bastian@waldi.eu.org>,
	linux-kernel@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi folks

The attached patch remove the usage of __ptr_t from
include/asm-s390/posix_types.h.

Bastian

-- 
Landru! Guide us!
		-- A Beta 3-oid, "The Return of the Archons", stardate 3157.4

--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="include-asm-posix_types.patch"

diff --git a/include/asm-s390/posix_types.h b/include/asm-s390/posix_types.h
index b94c988..878057b 100644
--- a/include/asm-s390/posix_types.h
+++ b/include/asm-s390/posix_types.h
@@ -104,7 +104,7 @@ static inline int __FD_ISSET(unsigned long fd, const __kernel_fd_set *fdsetp)
 
 #undef  __FD_ZERO
 #define __FD_ZERO(fdsetp) \
-	((void) memset ((__ptr_t) (fdsetp), 0, sizeof (__kernel_fd_set)))
+	((void) memset ((fdsetp), 0, sizeof (__kernel_fd_set)))
 
 #endif     /* __KERNEL__ */
 

--LQksG6bCIzRHxTLp--
