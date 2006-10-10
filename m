Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965037AbWJJGtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbWJJGtM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 02:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbWJJGtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 02:49:12 -0400
Received: from NS6.Sony.CO.JP ([137.153.0.32]:30900 "EHLO ns6.sony.co.jp")
	by vger.kernel.org with ESMTP id S965037AbWJJGtL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 02:49:11 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Cbe-oss-dev] [PATCH 09/14] spufs: add support for read/write oncntl
Date: Tue, 10 Oct 2006 15:49:08 +0900
Message-ID: <C3DCD550FB9ACD4D911D1271DD8CFDD20113D3E7@jptkyxms38.jp.sony.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Cbe-oss-dev] [PATCH 09/14] spufs: add support for read/write oncntl
Thread-Index: Acbn017kJVRp07XQSdCva5gHDa6iKQEVg9JgAAL9auA=
From: "Noguchi, Masato" <Masato.Noguchi@jp.sony.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Paul Mackerras" <paulus@samba.org>,
       "Arnd Bergmann" <arnd.bergmann@de.ibm.com>, <linuxppc-dev@ozlabs.org>,
       <cbe-oss-dev@ozlabs.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Oct 2006 06:49:08.0801 (UTC) FILETIME=[2FA08310:01C6EC38]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops,
I'm so sorry. I mistake to send wrong patch.
Correct version is below:

Signed-off-by: Masato Noguchi <Masato.Noguchi@jp.sony.com>

---

Index:
linux-2.6.18-arnd-20061004/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
---
linux-2.6.18-arnd-20061004.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linux-2.6.18-arnd-20061004/arch/powerpc/platforms/cell/spufs/file.c
@@ -246,6 +246,7 @@ static int spufs_cntl_open(struct inode

 static struct file_operations spufs_cntl_fops = {
 	.open = spufs_cntl_open,
+	.release = simple_attr_close,
 	.read = simple_attr_read,
 	.write = simple_attr_write,
 	.mmap = spufs_cntl_mmap,


> -----Original Message-----
> From: Noguchi, Masato
> Sent: Tuesday, October 10, 2006 3:00 PM
> To: 'Arnd Bergmann'
> Cc: Paul Mackerras; Arnd Bergmann; linuxppc-dev@ozlabs.org;
> cbe-oss-dev@ozlabs.org; linux-kernel@vger.kernel.org
> Subject: RE: [Cbe-oss-dev] [PATCH 09/14] spufs: add support for
read/write
> oncntl
> 
> After applying these patches, it seems the kernel leaks memory.
> No doubt you forget to call simple_attr_close on "[PATCH 09/14]
> spufs: add support for read/write oncntl".
> 
> Signed-off-by: Masato Noguchi <Masato.Noguchi@jp.sony.com>
> 
> ---
> 
> Index:
linux-2.6.18-arnd-20061004/arch/powerpc/platforms/cell/spufs/file.c
> ===================================================================
> ---
>
linux-2.6.18-arnd-20061004.orig/arch/powerpc/platforms/cell/spufs/file.c
> +++
linux-2.6.18-arnd-20061004/arch/powerpc/platforms/cell/spufs/file.c
> @@ -246,6 +246,7 @@ static int spufs_cntl_open(struct inode
> 
>  static struct file_operations spufs_cntl_fops = {
>  	.open = spufs_cntl_open,
> +	.close = simple_attr_close,
>  	.read = simple_attr_read,
>  	.write = simple_attr_write,
>  	.mmap = spufs_cntl_mmap,
> 


