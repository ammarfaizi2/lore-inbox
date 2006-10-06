Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWJFXyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWJFXyO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 19:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWJFXyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 19:54:14 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:3794 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1751258AbWJFXyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 19:54:08 -0400
Message-id: <54435213243213@wsc.cz>
Subject: [PATCH 2/2] Char: nozomi, bad comment sings
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <p.hardwick@option.com>
Date: Sat,  7 Oct 2006 01:54:07 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nozomi, bad comment sings

Don't use // for comments in C.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 3cbc3a3dd48ae68c4a936d161e5f256094fc2bef
tree 529c5a4b7efcda99629b09c744bc63852762cd6e
parent e7e58c9f0d3ce7bed7f8c4b1921da37d65e3ee8f
author Jiri Slaby <jirislaby@gmail.com> Sat, 07 Oct 2006 01:49:54 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Sat, 07 Oct 2006 01:49:54 +0200

 drivers/char/nozomi.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/char/nozomi.c b/drivers/char/nozomi.c
index 354a8a6..70ac4ac 100644
--- a/drivers/char/nozomi.c
+++ b/drivers/char/nozomi.c
@@ -413,11 +413,11 @@ struct port {
 	ctrl_ul_t ctrl_ul;
 	ctrl_dl_t ctrl_dl;
 	struct kfifo *fifo_ul;
-//	u32 dl_addr[2];
+/*	u32 dl_addr[2]; */
 	void __iomem *dl_addr[2];
 	u32 dl_size[2];
 	u8 toggle_dl;
-//	u32 ul_addr[2];
+/*	u32 ul_addr[2]; */
 	void __iomem *ul_addr[2];
 	u32 ul_size[2];
 	u8 toggle_ul;
@@ -435,7 +435,7 @@ struct port {
 
 /* Private data one for each card in the system */
 typedef struct {
-//	u32 base_addr;
+/*	u32 base_addr; */
 	void __iomem *base_addr;
 	u8 closing;
 
@@ -519,7 +519,7 @@ static inline dc_t *get_dc_by_tty(struct
 /* TODO: */
 /* -Optimize */
 /* -Rewrite cleaner */
-//static void read_mem32(u32 *buf, u32 mem_addr_start, u32 size_bytes) {
+/*static void read_mem32(u32 *buf, u32 mem_addr_start, u32 size_bytes) { */
 static void read_mem32(u32 * buf, void __iomem * mem_addr_start, u32 size_bytes)
 {
 	u32 i = 0;
@@ -552,7 +552,7 @@ static void read_mem32(u32 * buf, void _
 /* TODO: */
 /* - Rewrite cleaner */
 /* - merge with read_mem32() */
-//static void read_mem32_buf(u32 *buf, u32 mem_addr_start, u32 size_bytes) {
+/*static void read_mem32_buf(u32 *buf, u32 mem_addr_start, u32 size_bytes) { */
 static void read_mem32_buf(u32 * buf, void __iomem * mem_addr_start,
 			   u32 size_bytes)
 {
@@ -590,7 +590,7 @@ #endif
 /* TODO: */
 /* -Optimize */
 /* -Rewrite cleaner */
-//static u32 write_mem32(u32 mem_addr_start, u32 *buf, u32 size_bytes) {
+/*static u32 write_mem32(u32 mem_addr_start, u32 *buf, u32 size_bytes) {*/
 static u32 write_mem32(void __iomem * mem_addr_start, u32 * buf, u32 size_bytes)
 {
 	u32 i = 0;
@@ -623,7 +623,7 @@ static u32 write_mem32(void __iomem * me
 
 /* Todo: */
 /* - Merge with write_mem32() */
-//static u32 write_mem32_buf(u32 mem_addr_start, u32 *buf, u32 size_bytes) {
+/*static u32 write_mem32_buf(u32 mem_addr_start, u32 *buf, u32 size_bytes) {*/
 static u32 write_mem32_buf(void __iomem * mem_addr_start, u32 * buf,
 			   u32 size_bytes)
 {
@@ -738,7 +738,7 @@ static void setup_memory(dc_t * dc)
 					     dc->config_table.ul_app2_len);
 	dc->port[PORT_CTRL].ul_size[CH_A] =
 	    dc->config_table.ul_ctrl_len - buff_offset;
-//    offset = dc->config_table.ul_start;
+/*    offset = dc->config_table.ul_start;*/
 }
 
 /* Dump config table under initalization phase */
@@ -1852,7 +1852,7 @@ static int ntty_write(struct tty_struct 
 	}
 
 	spin_lock_irqsave(&dc->spin_mutex, flags);
-	// CTS is only valid on the modem channel
+	/* CTS is only valid on the modem channel */
 	if (port == &(dc->port[PORT_MDM])) {
 		if (port->ctrl_dl.CTS) {
 			D4("Enable interrupt");
@@ -1878,8 +1878,8 @@ static int ntty_write_room(struct tty_st
 {
 	struct port *port = (struct port *)tty->driver_data;
 	int room = 0;
-//      u32      flags = 0;
-//      dc_t *dc = get_dc_by_tty(tty);
+/*	u32 flags = 0;
+	dc_t *dc = get_dc_by_tty(tty); */
 
 	if (!port) {
 		return 0;
@@ -1887,9 +1887,9 @@ static int ntty_write_room(struct tty_st
 	if (down_trylock(&port->tty_sem)) {
 		return 0;
 	}
-// if(down_interruptible(&port->tty_sem)){
-//      return 0;
-// }
+/*	if(down_interruptible(&port->tty_sem)) {
+		return 0;
+	}*/
 
 	if (!port->tty_open_count) {
 		goto exit;
