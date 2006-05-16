Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWEPVmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWEPVmT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 17:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWEPVlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 17:41:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:34222 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932187AbWEPVkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 17:40:45 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 03/10] SPI: spi whitespace fixes
Reply-To: Greg KH <greg@kroah.com>
Date: Tue, 16 May 2006 14:38:31 -0700
Message-Id: <11478155181381-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.3.2
In-Reply-To: <11478155183773-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brownell <david-b@pacbell.net>

This removes superfluous whitespace in the <linux/spi/spi.h> header.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 include/linux/spi/spi.h |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

747d844ee9a183ff3067bb1181f2a25c50649538
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index caa4665..0820067 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -36,15 +36,15 @@ extern struct bus_type spi_bus_type;
  * @mode: The spi mode defines how data is clocked out and in.
  *	This may be changed by the device's driver.
  * @bits_per_word: Data transfers involve one or more words; word sizes
- * 	like eight or 12 bits are common.  In-memory wordsizes are
+ *	like eight or 12 bits are common.  In-memory wordsizes are
  *	powers of two bytes (e.g. 20 bit samples use 32 bits).
  *	This may be changed by the device's driver.
  *	The spi_transfer.bits_per_word can override this for each transfer.
  * @irq: Negative, or the number passed to request_irq() to receive
- * 	interrupts from this device.
+ *	interrupts from this device.
  * @controller_state: Controller's runtime state
  * @controller_data: Board-specific definitions for controller, such as
- * 	FIFO initialization parameters; from board_info.controller_data
+ *	FIFO initialization parameters; from board_info.controller_data
  *
  * An spi_device is used to interchange data between an SPI slave
  * (usually a discrete chip) and CPU memory.
@@ -145,13 +145,13 @@ static inline void spi_unregister_driver
  * struct spi_master - interface to SPI master controller
  * @cdev: class interface to this driver
  * @bus_num: board-specific (and often SOC-specific) identifier for a
- * 	given SPI controller.
+ *	given SPI controller.
  * @num_chipselect: chipselects are used to distinguish individual
- * 	SPI slaves, and are numbered from zero to num_chipselects.
- * 	each slave has a chipselect signal, but it's common that not
- * 	every chipselect is connected to a slave.
+ *	SPI slaves, and are numbered from zero to num_chipselects.
+ *	each slave has a chipselect signal, but it's common that not
+ *	every chipselect is connected to a slave.
  * @setup: updates the device mode and clocking records used by a
- * 	device's SPI controller; protocol code may call this.
+ *	device's SPI controller; protocol code may call this.
  * @transfer: adds a message to the controller's transfer queue.
  * @cleanup: frees controller-specific state
  *
@@ -276,8 +276,8 @@ extern struct spi_master *spi_busnum_to_
  *      for this transfer. If 0 the default (from spi_device) is used.
  * @cs_change: affects chipselect after this transfer completes
  * @delay_usecs: microseconds to delay after this transfer before
- * 	(optionally) changing the chipselect status, then starting
- * 	the next transfer or completing this spi_message.
+ *	(optionally) changing the chipselect status, then starting
+ *	the next transfer or completing this spi_message.
  * @transfer_list: transfers are sequenced through spi_message.transfers
  *
  * SPI transfers always write the same number of bytes as they read.
@@ -364,7 +364,7 @@ struct spi_transfer {
  * and its transfers, ignore them until its completion callback.
  */
 struct spi_message {
-	struct list_head 	transfers;
+	struct list_head	transfers;
 
 	struct spi_device	*spi;
 
@@ -382,7 +382,7 @@ struct spi_message {
 	 */
 
 	/* completion is reported through a callback */
-	void 			(*complete)(void *context);
+	void			(*complete)(void *context);
 	void			*context;
 	unsigned		actual_length;
 	int			status;
-- 
1.3.2

