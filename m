Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbUBHBUC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 20:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbUBHBUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 20:20:02 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:62150 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261827AbUBHBTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 20:19:41 -0500
Date: Sun, 8 Feb 2004 02:19:39 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Ed Okerson <eokerson@quicknet.net>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] telephony/ixj.h: remove kernel 2.2 #ifdef's
Message-ID: <20040208011938.GJ7388@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes two #ifdef's for kernel 2.2 from
linux-2.6.2-mm1/drivers/telephony/ixj.h .

cu
Adrian

--- linux-2.6.2-mm1/drivers/telephony/ixj.h.old	2004-02-08 02:16:11.000000000 +0100
+++ linux-2.6.2-mm1/drivers/telephony/ixj.h	2004-02-08 02:16:57.000000000 +0100
@@ -1205,22 +1205,13 @@
 	int aec_level;
 	int cid_play_aec_level;
 	int readers, writers;
-#if LINUX_VERSION_CODE < 0x020400
-	struct wait_queue *poll_q;
-	struct wait_queue *read_q;
-#else
         wait_queue_head_t poll_q;
         wait_queue_head_t read_q;
-#endif
 	char *read_buffer, *read_buffer_end;
 	char *read_convert_buffer;
 	size_t read_buffer_size;
 	unsigned int read_buffer_ready;
-#if LINUX_VERSION_CODE < 0x020400
-	struct wait_queue *write_q;
-#else
         wait_queue_head_t write_q;
-#endif
 	char *write_buffer, *write_buffer_end;
 	char *write_convert_buffer;
 	size_t write_buffer_size;
