Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbVIQA2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbVIQA2Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 20:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbVIQA2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 20:28:25 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:33571 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1750784AbVIQA2Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 20:28:24 -0400
X-IronPort-AV: i="3.97,118,1125896400"; 
   d="scan'208"; a="295324466:sNHT32881708"
X-MIMEOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 2.6.14-rc1] Enhancements and fixes for dell_rbu driver
Date: Fri, 16 Sep 2005 19:28:16 -0500
Message-ID: <597A2BC19EDD3C458F841E8724E92D4B973DFD@ausx3mps301.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2.6.14-rc1] Enhancements and fixes for dell_rbu driver
Thread-index: AcW7FNMbel+q3EWuSqihsnoJvxQCMAACUOIg
From: <Abhay_Salunke@Dell.com>
To: <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 Sep 2005 00:28:17.0849 (UTC) FILETIME=[B31EF290:01C5BB1E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andrew, this patch also had the documentation changes I guess
dell_rbu~tidy is missing it.
I had used Lindent on this file, guess it should have taken care of the
formatting, spaces etc.
Thanks,
Abhay

-----Original Message-----
From: Andrew Morton [mailto:akpm@osdl.org] 
Sent: Friday, September 16, 2005 6:17 PM
To: Salunke, Abhay
Cc: linux-kernel@vger.kernel.org; Salunke, Abhay
Subject: Re: [patch 2.6.14-rc1] Enhancements and fixes for dell_rbu
driver

Abhay Salunke <Abhay_Salunke@dell.com> wrote:
>
> -static __exit void dcdrbu_exit(void)
>  +static __exit void
>  +dcdrbu_exit(void)

hm, all these extraneous whitespace changes actually take the driver
further away from preferred coding style.

How about we do this?


diff -puN drivers/firmware/dell_rbu.c~dell_rbu-tidy
drivers/firmware/dell_rbu.c
--- devel/drivers/firmware/dell_rbu.c~dell_rbu-tidy	2005-09-16
16:15:27.000000000 -0700
+++ devel-akpm/drivers/firmware/dell_rbu.c	2005-09-16
16:15:27.000000000 -0700
@@ -85,8 +85,7 @@ static struct platform_device *rbu_devic  static int
context;  static dma_addr_t dell_rbu_dmaaddr;
 
-static void
-init_packet_head(void)
+static void init_packet_head(void)
 {
 	INIT_LIST_HEAD(&packet_data_head.list);
 	rbu_data.packet_write_count = 0;
@@ -95,8 +94,7 @@ init_packet_head(void)
 	rbu_data.packetsize = 0;
 }
 
-static int
-fill_last_packet(void *data, size_t length)
+static int fill_last_packet(void *data, size_t length)
 {
 	struct list_head *ptemp_list;
 	struct packet_data *packet = NULL;
@@ -138,8 +136,7 @@ fill_last_packet(void *data, size_t leng
 	return 0;
 }
 
-static int
-create_packet(size_t length)
+static int create_packet(size_t length)
 {
 	struct packet_data *newpacket;
 	int ordernum = 0;
@@ -198,8 +195,7 @@ create_packet(size_t length)
 	return 0;
 }
 
-static int
-packetize_data(void *data, size_t length)
+static int packetize_data(void *data, size_t length)
 {
 	int rc = 0;
 
@@ -213,8 +209,7 @@ packetize_data(void *data, size_t length
 	return rc;
 }
 
-static int
-do_packet_read(char *data, struct list_head *ptemp_list,
+static int do_packet_read(char *data, struct list_head *ptemp_list,
 	int length, int bytes_read, int *list_read_count)  {
 	void *ptemp_buf;
@@ -248,8 +243,7 @@ do_packet_read(char *data, struct list_h
 	return bytes_copied;
 }
 
-static int
-packet_read_list(char *data, size_t * pread_length)
+static int packet_read_list(char *data, size_t *pread_length)
 {
 	struct list_head *ptemp_list;
 	int temp_count = 0;
@@ -287,8 +281,7 @@ packet_read_list(char *data, size_t * pr
 	return 0;
 }
 
-static void
-packet_empty_list(void)
+static void packet_empty_list(void)
 {
 	struct list_head *ptemp_list;
 	struct list_head *pnext_list;
@@ -320,8 +313,7 @@ packet_empty_list(void)
  * img_update_free: Frees the buffer allocated for storing BIOS image
  * Always called with lock held and returned with lock held
  */
-static void
-img_update_free(void)
+static void img_update_free(void)
 {
 	if (!rbu_data.image_update_buffer)
 		return;
@@ -358,8 +350,7 @@ img_update_free(void)
  * already allocated size, then that memory is reused. This function is
  * called with lock held and returns with lock held.
  */
-static int
-img_update_realloc(unsigned long size)
+static int img_update_realloc(unsigned long size)
 {
 	unsigned char *image_update_buffer = NULL;
 	unsigned long rc;
@@ -428,8 +419,7 @@ img_update_realloc(unsigned long size)
 	return rc;
 }
 
-static ssize_t
-read_packet_data(char *buffer, loff_t pos, size_t count)
+static ssize_t read_packet_data(char *buffer, loff_t pos, size_t count)
 {
 	int retval;
 	size_t bytes_left;
@@ -470,8 +460,7 @@ read_packet_data(char *buffer, loff_t po
 	return retval;
 }
 
-static ssize_t
-read_rbu_mono_data(char *buffer, loff_t pos, size_t count)
+static ssize_t read_rbu_mono_data(char *buffer, loff_t pos, size_t 
+count)
 {
 	unsigned char *ptemp = NULL;
 	size_t bytes_left = 0;
@@ -509,8 +498,8 @@ read_rbu_mono_data(char *buffer, loff_t 
 	return ret_count;
 }
 
-static ssize_t
-read_rbu_data(struct kobject *kobj, char *buffer, loff_t pos, size_t
count)
+static ssize_t read_rbu_data(struct kobject *kobj, char *buffer,
+			loff_t pos, size_t count)
 {
 	ssize_t ret_count = 0;
 
@@ -527,8 +516,7 @@ read_rbu_data(struct kobject *kobj, char
 	return ret_count;
 }
 
-static void
-callbackfn_rbu(const struct firmware *fw, void *context)
+static void callbackfn_rbu(const struct firmware *fw, void *context)
 {
 	int rc = 0;
 
@@ -564,9 +552,8 @@ callbackfn_rbu(const struct firmware *fw
 		rbu_data.entry_created = 1;
 }
 
-static ssize_t
-read_rbu_image_type(struct kobject *kobj, char *buffer, loff_t pos,
-	size_t count)
+static ssize_t read_rbu_image_type(struct kobject *kobj, char *buffer,
+			loff_t pos, size_t count)
 {
 	int size = 0;
 	if (!pos)
@@ -574,9 +561,8 @@ read_rbu_image_type(struct kobject *kobj
 	return size;
 }
 
-static ssize_t
-write_rbu_image_type(struct kobject *kobj, char *buffer, loff_t pos,
-	size_t count)
+static ssize_t write_rbu_image_type(struct kobject *kobj, char *buffer,
+			loff_t pos, size_t count)
 {
 	int rc = count;
 	int req_firm_rc = 0;
@@ -636,18 +622,25 @@ write_rbu_image_type(struct kobject *kob  }
 
 static struct bin_attribute rbu_data_attr = {
-	.attr = {.name = "data",.owner = THIS_MODULE,.mode = 0444},
+	.attr = {
+		.name = "data",
+		.owner = THIS_MODULE,
+		.mode = 0444,
+	},
 	.read = read_rbu_data,
 };
 
 static struct bin_attribute rbu_image_type_attr = {
-	.attr = {.name = "image_type",.owner = THIS_MODULE,.mode =
0644},
+	.attr = {
+		.name = "image_type",
+		.owner = THIS_MODULE,
+		.mode = 0644,
+	},
 	.read = read_rbu_image_type,
 	.write = write_rbu_image_type,
 };
 
-static int __init
-dcdrbu_init(void)
+static int __init dcdrbu_init(void)
 {
 	int rc = 0;
 	spin_lock_init(&rbu_data.lock);
@@ -677,8 +670,7 @@ dcdrbu_init(void)
 
 }
 
-static __exit void
-dcdrbu_exit(void)
+static __exit void dcdrbu_exit(void)
 {
 	spin_lock(&rbu_data.lock);
 	packet_empty_list();
_
