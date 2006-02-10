Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbWBJApj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWBJApj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 19:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWBJApj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 19:45:39 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56837 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750896AbWBJApi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 19:45:38 -0500
Date: Fri, 10 Feb 2006 01:45:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, andrew.vasquez@qlogic.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/qla2xxx/: make some functions static
Message-ID: <20060210004537.GK3524@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/scsi/qla2xxx/qla_os.c  |   12 ++++++------
 drivers/scsi/qla2xxx/qla_sup.c |    8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

--- 25/drivers/scsi/qla2xxx/qla_os.c~drivers-scsi-qla2xxx-possible-cleanups	Fri Jan 13 17:55:05 2006
+++ 25-akpm/drivers/scsi/qla2xxx/qla_os.c	Fri Jan 13 17:55:05 2006
@@ -268,7 +268,7 @@ qla24xx_pci_info_str(struct scsi_qla_hos
 	return str;
 }
 
-char *
+static char *
 qla2x00_fw_version_str(struct scsi_qla_host *ha, char *str)
 {
 	char un_str[10];
@@ -306,7 +306,7 @@ qla2x00_fw_version_str(struct scsi_qla_h
 	return (str);
 }
 
-char *
+static char *
 qla24xx_fw_version_str(struct scsi_qla_host *ha, char *str)
 {
 	sprintf(str, "%d.%02d.%02d ", ha->fw_major_version,
@@ -582,7 +582,7 @@ qla2x00_wait_for_loop_ready(scsi_qla_hos
 *
 * Note:
 **************************************************************************/
-int
+static int
 qla2xxx_eh_abort(struct scsi_cmnd *cmd)
 {
 	scsi_qla_host_t *ha = to_qla_host(cmd->device->host);
@@ -716,7 +716,7 @@ qla2x00_eh_wait_for_pending_target_comma
 *    SUCCESS/FAILURE (defined as macro in scsi.h).
 *
 **************************************************************************/
-int
+static int
 qla2xxx_eh_device_reset(struct scsi_cmnd *cmd)
 {
 	scsi_qla_host_t *ha = to_qla_host(cmd->device->host);
@@ -847,7 +847,7 @@ qla2x00_eh_wait_for_pending_commands(scs
 *    SUCCESS/FAILURE (defined as macro in scsi.h).
 *
 **************************************************************************/
-int
+static int
 qla2xxx_eh_bus_reset(struct scsi_cmnd *cmd)
 {
 	scsi_qla_host_t *ha = to_qla_host(cmd->device->host);
@@ -908,7 +908,7 @@ eh_bus_reset_done:
 *
 * Note:
 **************************************************************************/
-int
+static int
 qla2xxx_eh_host_reset(struct scsi_cmnd *cmd)
 {
 	scsi_qla_host_t *ha = to_qla_host(cmd->device->host);

--- linux-2.6.16-rc2-mm1-full/drivers/scsi/qla2xxx/qla_sup.c.old	2006-02-10 01:10:06.000000000 +0100
+++ linux-2.6.16-rc2-mm1-full/drivers/scsi/qla2xxx/qla_sup.c	2006-02-10 01:10:20.000000000 +0100
@@ -428,7 +428,7 @@
 	return FARX_ACCESS_NVRAM_DATA | naddr;
 }
 
-uint32_t
+static uint32_t
 qla24xx_read_flash_dword(scsi_qla_host_t *ha, uint32_t addr)
 {
 	int rval;
@@ -469,7 +469,7 @@
 	return dwptr;
 }
 
-int
+static int
 qla24xx_write_flash_dword(scsi_qla_host_t *ha, uint32_t addr, uint32_t data)
 {
 	int rval;
@@ -491,7 +491,7 @@
 	return rval;
 }
 
-void
+static void
 qla24xx_get_flash_manufacturer(scsi_qla_host_t *ha, uint8_t *man_id,
     uint8_t *flash_id)
 {
@@ -502,7 +502,7 @@
 	*flash_id = MSB(ids);
 }
 
-int
+static int
 qla24xx_write_flash_data(scsi_qla_host_t *ha, uint32_t *dwptr, uint32_t faddr,
     uint32_t dwords)
 {

