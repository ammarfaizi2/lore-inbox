Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751839AbWJADrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbWJADrp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 23:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbWJADrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 23:47:45 -0400
Received: from xenotime.net ([66.160.160.81]:28834 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751839AbWJADrn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 23:47:43 -0400
Date: Sat, 30 Sep 2006 20:48:30 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] kernel-doc for kernel/dma.c
Message-Id: <20060930204830.2fe2a4cc.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Add kernel-doc function headers in kernel/dma.c and use it in DocBook.

Clean up kernel-doc in mca_dma.h (the colon (':') represents a
section header).

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/DocBook/kernel-api.tmpl |    4 ++++
 include/asm-i386/mca_dma.h            |    3 +--
 kernel/dma.c                          |   10 +++++++++-
 3 files changed, 14 insertions(+), 3 deletions(-)

--- linux-2618-g12.orig/include/asm-i386/mca_dma.h
+++ linux-2618-g12/include/asm-i386/mca_dma.h
@@ -181,7 +181,7 @@ static __inline__ void mca_set_dma_io(un
  *	@mode: mode to set
  *
  *	The DMA controller supports several modes. The mode values you can
- *	set are :
+ *	set are-
  *
  *	%MCA_DMA_MODE_READ when reading from the DMA device.
  *
@@ -190,7 +190,6 @@ static __inline__ void mca_set_dma_io(un
  *	%MCA_DMA_MODE_IO to do DMA to or from an I/O port.
  *
  *	%MCA_DMA_MODE_16 to do 16bit transfers.
- *
  */
 
 static __inline__ void mca_set_dma_mode(unsigned int dmanr, unsigned int mode)
--- linux-2618-g12.orig/kernel/dma.c
+++ linux-2618-g12/kernel/dma.c
@@ -62,6 +62,11 @@ static struct dma_chan dma_chan_busy[MAX
 };
 
 
+/**
+ * request_dma - request and reserve a system DMA channel
+ * @dmanr: DMA channel number
+ * @device_id: reserving device ID string, used in /proc/dma
+ */
 int request_dma(unsigned int dmanr, const char * device_id)
 {
 	if (dmanr >= MAX_DMA_CHANNELS)
@@ -76,7 +81,10 @@ int request_dma(unsigned int dmanr, cons
 	return 0;
 } /* request_dma */
 
-
+/**
+ * free_dma - free a reserved system DMA channel
+ * @dmanr: DMA channel number
+ */
 void free_dma(unsigned int dmanr)
 {
 	if (dmanr >= MAX_DMA_CHANNELS) {
--- linux-2618-g12.orig/Documentation/DocBook/kernel-api.tmpl
+++ linux-2618-g12/Documentation/DocBook/kernel-api.tmpl
@@ -325,6 +325,10 @@ X!Ekernel/module.c
 !Ekernel/irq/manage.c
      </sect1>
 
+     <sect1><title>DMA Channels</title>
+!Ekernel/dma.c
+     </sect1>
+
      <sect1><title>Resources Management</title>
 !Ikernel/resource.c
      </sect1>


---
