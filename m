Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268300AbUIGPNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268300AbUIGPNT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 11:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268359AbUIGPKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 11:10:22 -0400
Received: from verein.lst.de ([213.95.11.210]:34458 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268339AbUIGPHg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 11:07:36 -0400
Date: Tue, 7 Sep 2004 17:07:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christoph Hellwig <hch@verein.lst.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mark md_interrupt_thread static
Message-ID: <20040907150729.GA9376@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040907144647.GA8844@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907144647.GA8844@lst.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

requires this additional header fixup:

--- 1.31/include/linux/raid/md.h	2004-08-24 11:08:45 +02:00
+++ edited/include/linux/raid/md.h	2004-09-07 15:14:25 +02:00
@@ -69,7 +69,6 @@
 extern void md_unregister_thread (mdk_thread_t *thread);
 extern void md_wakeup_thread(mdk_thread_t *thread);
 extern void md_check_recovery(mddev_t *mddev);
-extern void md_interrupt_thread (mdk_thread_t *thread);
 extern void md_write_start(mddev_t *mddev);
 extern void md_write_end(mddev_t *mddev);
 extern void md_handle_safemode(mddev_t *mddev);
