Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262991AbTJJP75 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 11:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262989AbTJJP74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 11:59:56 -0400
Received: from ns.suse.de ([195.135.220.2]:52609 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262991AbTJJP7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 11:59:36 -0400
Date: Fri, 10 Oct 2003 17:59:30 +0200
From: Olaf Hering <olh@suse.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org,
       YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
       GOTO Masanori <gotom@debian.or.jp>
Subject: Re: Linux 2.4.23-pre7
Message-ID: <20031010155930.GA15496@suse.de>
References: <Pine.LNX.4.44.0310091939100.6403-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0310091939100.6403-100000@logos.cnet>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, Oct 09, Marcelo Tosatti wrote:

> 
> Hi,
> 
> Here goes -pre7... 

This patch is required to compile the NinjaSCSI-32Bi Cardbus driver:


diff -purNX /suse/olh/kernel/kernel_exclude.txt linux-2.4.22/drivers/scsi/nsp32.h linux-2.4.23-pre7/drivers/scsi/nsp32.h
--- linux-2.4.22/drivers/scsi/nsp32.h   2003-10-10 17:40:05.000000000 +0200
+++ linux-2.4.23-pre7/drivers/scsi/nsp32.h      2003-10-10 16:08:10.000000000 +0200
@@ -642,10 +642,12 @@ typedef struct _nsp32_hw_data {
 # define scsi_host_put(host)            scsi_unregister(host)
 # define pci_name(pci_dev)              ((pci_dev)->slot_name)

+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,4,23))
 typedef void irqreturn_t;
 # define IRQ_NONE      /* */
 # define IRQ_HANDLED   /* */
 # define IRQ_RETVAL(x) /* */
+#endif

 /* This is ad-hoc version of scsi_host_get_next() */
 static inline struct Scsi_Host *scsi_host_get_next(struct Scsi_Host *host)

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
