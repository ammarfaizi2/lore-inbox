Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032146AbWLGMqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032146AbWLGMqY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 07:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032147AbWLGMqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 07:46:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33844 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032146AbWLGMqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 07:46:23 -0500
From: David Howells <dhowells@redhat.com>
Subject: [PATCH] WorkStruct: Fix spi_bitbang.h
Date: Thu, 07 Dec 2006 12:44:19 +0000
To: ben@fluff.org, torvalds@osdl.org, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com
Message-Id: <20061207124419.17680.96380.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spi_bitbang.h.  It need to #include <linux/workqueue.h> before it can
compile.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/linux/spi/spi_bitbang.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/spi/spi_bitbang.h b/include/linux/spi/spi_bitbang.h
index 16ce178..33fa727 100644
--- a/include/linux/spi/spi_bitbang.h
+++ b/include/linux/spi/spi_bitbang.h
@@ -1,6 +1,8 @@
 #ifndef	__SPI_BITBANG_H
 #define	__SPI_BITBANG_H
 
+#include <linux/workqueue.h>
+
 /*
  * Mix this utility code with some glue code to get one of several types of
  * simple SPI master driver.  Two do polled word-at-a-time I/O:
