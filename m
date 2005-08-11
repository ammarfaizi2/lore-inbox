Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbVHKVcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbVHKVcx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 17:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbVHKVcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 17:32:53 -0400
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:56076 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932203AbVHKVcw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 17:32:52 -0400
Date: Thu, 11 Aug 2005 23:33:24 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] (1/7) I2C: Kill i2c_algorithm.name
Message-Id: <20050811233324.79e79d36.khali@linux-fr.org>
In-Reply-To: <20050811231828.3e7f5837.khali@linux-fr.org>
References: <20050811231828.3e7f5837.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The name member of the i2c_algorithm is never used, although all
drivers conscientiously fill it. We can drop it completely, this
structure doesn't need to have a name.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/algos/i2c-algo-bit.c                  |    1 -
 drivers/i2c/algos/i2c-algo-ite.c                  |    1 -
 drivers/i2c/algos/i2c-algo-pca.c                  |    1 -
 drivers/i2c/algos/i2c-algo-pcf.c                  |    1 -
 drivers/i2c/algos/i2c-algo-sgi.c                  |    1 -
 drivers/i2c/algos/i2c-algo-sibyte.c               |    1 -
 drivers/i2c/busses/i2c-ali1535.c                  |    1 -
 drivers/i2c/busses/i2c-ali1563.c                  |    1 -
 drivers/i2c/busses/i2c-ali15x3.c                  |    1 -
 drivers/i2c/busses/i2c-amd756.c                   |    1 -
 drivers/i2c/busses/i2c-amd8111.c                  |    1 -
 drivers/i2c/busses/i2c-au1550.c                   |    1 -
 drivers/i2c/busses/i2c-i801.c                     |    1 -
 drivers/i2c/busses/i2c-ibm_iic.c                  |    1 -
 drivers/i2c/busses/i2c-iop3xx.c                   |    1 -
 drivers/i2c/busses/i2c-isa.c                      |    1 -
 drivers/i2c/busses/i2c-keywest.c                  |    1 -
 drivers/i2c/busses/i2c-mpc.c                      |    1 -
 drivers/i2c/busses/i2c-mv64xxx.c                  |    1 -
 drivers/i2c/busses/i2c-nforce2.c                  |    1 -
 drivers/i2c/busses/i2c-piix4.c                    |    1 -
 drivers/i2c/busses/i2c-s3c2410.c                  |    1 -
 drivers/i2c/busses/i2c-sis5595.c                  |    1 -
 drivers/i2c/busses/i2c-sis630.c                   |    1 -
 drivers/i2c/busses/i2c-sis96x.c                   |    1 -
 drivers/i2c/busses/i2c-stub.c                     |    1 -
 drivers/i2c/busses/i2c-viapro.c                   |    1 -
 drivers/i2c/busses/scx200_acb.c                   |    1 -
 drivers/media/common/saa7146_i2c.c                |    1 -
 drivers/media/dvb/b2c2/flexcop-i2c.c              |    1 -
 drivers/media/dvb/dvb-usb/cxusb.c                 |    1 -
 drivers/media/dvb/dvb-usb/dibusb-common.c         |    1 -
 drivers/media/dvb/dvb-usb/digitv.c                |    1 -
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    1 -
 drivers/media/video/bttv-i2c.c                    |    1 -
 drivers/media/video/saa7134/saa7134-i2c.c         |    1 -
 drivers/usb/media/w9968cf.c                       |    1 -
 include/linux/i2c.h                               |    1 -
 38 files changed, 38 deletions(-)

--- linux-2.6.13-rc5.orig/drivers/i2c/algos/i2c-algo-bit.c	2005-08-01 22:48:49.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/algos/i2c-algo-bit.c	2005-08-02 20:30:04.000000000 +0200
@@ -519,7 +519,6 @@
 /* -----exported algorithm data: -------------------------------------	*/
 
 static struct i2c_algorithm i2c_bit_algo = {
-	.name		= "Bit-shift algorithm",
 	.id		= I2C_ALGO_BIT,
 	.master_xfer	= bit_xfer,
 	.functionality	= bit_func,
--- linux-2.6.13-rc5.orig/drivers/i2c/algos/i2c-algo-ite.c	2005-08-02 18:31:04.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/algos/i2c-algo-ite.c	2005-08-02 20:30:04.000000000 +0200
@@ -713,7 +713,6 @@
 /* -----exported algorithm data: -------------------------------------	*/
 
 static struct i2c_algorithm iic_algo = {
-	.name		= "ITE IIC algorithm",
 	.id		= I2C_ALGO_IIC,
 	.master_xfer	= iic_xfer,
 	.algo_control	= algo_control, /* ioctl */
--- linux-2.6.13-rc5.orig/drivers/i2c/algos/i2c-algo-pca.c	2005-08-02 18:49:31.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/algos/i2c-algo-pca.c	2005-08-02 20:30:04.000000000 +0200
@@ -356,7 +356,6 @@
 }
 
 static struct i2c_algorithm pca_algo = {
-	.name		= "PCA9564 algorithm",
 	.id		= I2C_ALGO_PCA,
 	.master_xfer	= pca_xfer,
 	.functionality	= pca_func,
--- linux-2.6.13-rc5.orig/drivers/i2c/algos/i2c-algo-pcf.c	2005-08-01 22:48:49.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/algos/i2c-algo-pcf.c	2005-08-02 20:30:04.000000000 +0200
@@ -459,7 +459,6 @@
 /* -----exported algorithm data: -------------------------------------	*/
 
 static struct i2c_algorithm pcf_algo = {
-	.name		= "PCF8584 algorithm",
 	.id		= I2C_ALGO_PCF,
 	.master_xfer	= pcf_xfer,
 	.functionality	= pcf_func,
--- linux-2.6.13-rc5.orig/drivers/i2c/algos/i2c-algo-sgi.c	2005-08-01 22:48:49.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/algos/i2c-algo-sgi.c	2005-08-02 20:30:04.000000000 +0200
@@ -158,7 +158,6 @@
 }
 
 static struct i2c_algorithm sgi_algo = {
-	.name		= "SGI algorithm",
 	.id		= I2C_ALGO_SGI,
 	.master_xfer	= sgi_xfer,
 	.functionality	= sgi_func,
--- linux-2.6.13-rc5.orig/drivers/i2c/algos/i2c-algo-sibyte.c	2005-08-02 18:31:04.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/algos/i2c-algo-sibyte.c	2005-08-02 18:49:40.000000000 +0200
@@ -135,7 +135,6 @@
 /* -----exported algorithm data: -------------------------------------	*/
 
 static struct i2c_algorithm i2c_sibyte_algo = {
-	.name		= "SiByte algorithm",
 	.id		= I2C_ALGO_SIBYTE,
 	.smbus_xfer	= smbus_xfer,
 	.algo_control	= algo_control, /* ioctl */
--- linux-2.6.13-rc5.orig/drivers/i2c/busses/i2c-ali1535.c	2005-08-02 18:31:04.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/busses/i2c-ali1535.c	2005-08-02 18:49:40.000000000 +0200
@@ -472,7 +472,6 @@
 }
 
 static struct i2c_algorithm smbus_algorithm = {
-	.name		= "Non-i2c SMBus adapter",
 	.id		= I2C_ALGO_SMBUS,
 	.smbus_xfer	= ali1535_access,
 	.functionality	= ali1535_func,
--- linux-2.6.13-rc5.orig/drivers/i2c/busses/i2c-ali1563.c	2005-08-01 22:48:49.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/busses/i2c-ali1563.c	2005-08-02 18:49:40.000000000 +0200
@@ -366,7 +366,6 @@
 }
 
 static struct i2c_algorithm ali1563_algorithm = {
-	.name		= "Non-i2c SMBus adapter",
 	.id		= I2C_ALGO_SMBUS,
 	.smbus_xfer	= ali1563_access,
 	.functionality	= ali1563_func,
--- linux-2.6.13-rc5.orig/drivers/i2c/busses/i2c-ali15x3.c	2005-08-02 18:31:04.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/busses/i2c-ali15x3.c	2005-08-02 18:49:40.000000000 +0200
@@ -462,7 +462,6 @@
 }
 
 static struct i2c_algorithm smbus_algorithm = {
-	.name		= "Non-I2C SMBus adapter",
 	.id		= I2C_ALGO_SMBUS,
 	.smbus_xfer	= ali15x3_access,
 	.functionality	= ali15x3_func,
--- linux-2.6.13-rc5.orig/drivers/i2c/busses/i2c-amd756.c	2005-08-02 18:31:04.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/busses/i2c-amd756.c	2005-08-02 18:49:40.000000000 +0200
@@ -295,7 +295,6 @@
 }
 
 static struct i2c_algorithm smbus_algorithm = {
-	.name		= "Non-I2C SMBus adapter",
 	.id		= I2C_ALGO_SMBUS,
 	.smbus_xfer	= amd756_access,
 	.functionality	= amd756_func,
--- linux-2.6.13-rc5.orig/drivers/i2c/busses/i2c-amd8111.c	2005-08-02 18:31:04.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/busses/i2c-amd8111.c	2005-08-02 18:49:40.000000000 +0200
@@ -323,7 +323,6 @@
 }
 
 static struct i2c_algorithm smbus_algorithm = {
-	.name = "Non-I2C SMBus 2.0 adapter",
 	.id = I2C_ALGO_SMBUS,
 	.smbus_xfer = amd8111_access,
 	.functionality = amd8111_func,
--- linux-2.6.13-rc5.orig/drivers/i2c/busses/i2c-au1550.c	2005-08-02 18:31:04.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/busses/i2c-au1550.c	2005-08-02 18:49:40.000000000 +0200
@@ -283,7 +283,6 @@
 }
 
 static struct i2c_algorithm au1550_algo = {
-	.name		= "Au1550 algorithm",
 	.id		= I2C_ALGO_AU1550,
 	.master_xfer	= au1550_xfer,
 	.functionality	= au1550_func,
--- linux-2.6.13-rc5.orig/drivers/i2c/busses/i2c-i801.c	2005-08-02 18:31:04.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/busses/i2c-i801.c	2005-08-02 18:49:40.000000000 +0200
@@ -535,7 +535,6 @@
 }
 
 static struct i2c_algorithm smbus_algorithm = {
-	.name		= "Non-I2C SMBus adapter",
 	.id		= I2C_ALGO_SMBUS,
 	.smbus_xfer	= i801_access,
 	.functionality	= i801_func,
--- linux-2.6.13-rc5.orig/drivers/i2c/busses/i2c-ibm_iic.c	2005-08-02 18:31:04.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/busses/i2c-ibm_iic.c	2005-08-02 20:30:04.000000000 +0200
@@ -627,7 +627,6 @@
 }
 
 static struct i2c_algorithm iic_algo = {
-	.name 		= "IBM IIC algorithm",
 	.id   		= I2C_ALGO_OCP,
 	.master_xfer 	= iic_xfer,
 	.functionality	= iic_func
--- linux-2.6.13-rc5.orig/drivers/i2c/busses/i2c-iop3xx.c	2005-08-02 18:31:04.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/busses/i2c-iop3xx.c	2005-08-02 18:49:40.000000000 +0200
@@ -399,7 +399,6 @@
 }
 
 static struct i2c_algorithm iop3xx_i2c_algo = {
-	.name		= "IOP3xx I2C algorithm",
 	.id		= I2C_ALGO_IOP3XX,
 	.master_xfer	= iop3xx_i2c_master_xfer,
 	.algo_control	= iop3xx_i2c_algo_control,
--- linux-2.6.13-rc5.orig/drivers/i2c/busses/i2c-isa.c	2005-08-02 18:42:06.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/busses/i2c-isa.c	2005-08-02 20:30:04.000000000 +0200
@@ -43,7 +43,6 @@
 
 /* This is the actual algorithm we define */
 static struct i2c_algorithm isa_algorithm = {
-	.name		= "ISA bus algorithm",
 	.id		= I2C_ALGO_ISA,
 	.functionality	= isa_func,
 };
--- linux-2.6.13-rc5.orig/drivers/i2c/busses/i2c-keywest.c	2005-08-02 18:31:04.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/busses/i2c-keywest.c	2005-08-02 18:49:40.000000000 +0200
@@ -498,7 +498,6 @@
 
 /* For now, we only handle combined mode (smbus) */
 static struct i2c_algorithm keywest_algorithm = {
-	.name		= "Keywest i2c",
 	.id		= I2C_ALGO_SMBUS,
 	.smbus_xfer	= keywest_smbus_xfer,
 	.master_xfer	= keywest_xfer,
--- linux-2.6.13-rc5.orig/drivers/i2c/busses/i2c-mpc.c	2005-08-02 18:31:04.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/busses/i2c-mpc.c	2005-08-02 18:49:40.000000000 +0200
@@ -272,7 +272,6 @@
 }
 
 static struct i2c_algorithm mpc_algo = {
-	.name = "MPC algorithm",
 	.id = I2C_ALGO_MPC107,
 	.master_xfer = mpc_xfer,
 	.functionality = mpc_functionality,
--- linux-2.6.13-rc5.orig/drivers/i2c/busses/i2c-mv64xxx.c	2005-08-01 22:48:49.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/busses/i2c-mv64xxx.c	2005-08-02 18:49:40.000000000 +0200
@@ -433,7 +433,6 @@
 }
 
 static struct i2c_algorithm mv64xxx_i2c_algo = {
-	.name = MV64XXX_I2C_CTLR_NAME " algorithm",
 	.id = I2C_ALGO_MV64XXX,
 	.master_xfer = mv64xxx_i2c_xfer,
 	.functionality = mv64xxx_i2c_functionality,
--- linux-2.6.13-rc5.orig/drivers/i2c/busses/i2c-nforce2.c	2005-08-02 18:47:21.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/busses/i2c-nforce2.c	2005-08-02 18:49:40.000000000 +0200
@@ -105,7 +105,6 @@
 
 
 static struct i2c_algorithm smbus_algorithm = {
-	.name = "Non-I2C SMBus adapter",
 	.id = I2C_ALGO_SMBUS,
 	.smbus_xfer = nforce2_access,
 	.functionality = nforce2_func,
--- linux-2.6.13-rc5.orig/drivers/i2c/busses/i2c-piix4.c	2005-08-02 18:31:04.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/busses/i2c-piix4.c	2005-08-02 18:49:40.000000000 +0200
@@ -399,7 +399,6 @@
 }
 
 static struct i2c_algorithm smbus_algorithm = {
-	.name		= "Non-I2C SMBus adapter",
 	.id		= I2C_ALGO_SMBUS,
 	.smbus_xfer	= piix4_access,
 	.functionality	= piix4_func,
--- linux-2.6.13-rc5.orig/drivers/i2c/busses/i2c-s3c2410.c	2005-08-02 18:31:04.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/busses/i2c-s3c2410.c	2005-08-02 18:49:40.000000000 +0200
@@ -568,7 +568,6 @@
 /* i2c bus registration info */
 
 static struct i2c_algorithm s3c24xx_i2c_algorithm = {
-	.name			= "S3C2410-I2C-Algorithm",
 	.master_xfer		= s3c24xx_i2c_xfer,
 	.functionality		= s3c24xx_i2c_func,
 };
--- linux-2.6.13-rc5.orig/drivers/i2c/busses/i2c-sis5595.c	2005-08-02 18:31:04.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/busses/i2c-sis5595.c	2005-08-02 18:49:40.000000000 +0200
@@ -357,7 +357,6 @@
 }
 
 static struct i2c_algorithm smbus_algorithm = {
-	.name		= "Non-I2C SMBus adapter",
 	.id		= I2C_ALGO_SMBUS,
 	.smbus_xfer	= sis5595_access,
 	.functionality	= sis5595_func,
--- linux-2.6.13-rc5.orig/drivers/i2c/busses/i2c-sis630.c	2005-08-02 18:31:04.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/busses/i2c-sis630.c	2005-08-02 18:49:40.000000000 +0200
@@ -448,7 +448,6 @@
 
 
 static struct i2c_algorithm smbus_algorithm = {
-	.name		= "Non-I2C SMBus adapter",
 	.id		= I2C_ALGO_SMBUS,
 	.smbus_xfer	= sis630_access,
 	.functionality	= sis630_func,
--- linux-2.6.13-rc5.orig/drivers/i2c/busses/i2c-sis96x.c	2005-08-02 18:31:04.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/busses/i2c-sis96x.c	2005-08-02 18:49:40.000000000 +0200
@@ -249,7 +249,6 @@
 }
 
 static struct i2c_algorithm smbus_algorithm = {
-	.name		= "Non-I2C SMBus adapter",
 	.id		= I2C_ALGO_SMBUS,
 	.smbus_xfer	= sis96x_access,
 	.functionality	= sis96x_func,
--- linux-2.6.13-rc5.orig/drivers/i2c/busses/i2c-stub.c	2005-08-02 18:31:04.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/busses/i2c-stub.c	2005-08-02 18:49:40.000000000 +0200
@@ -109,7 +109,6 @@
 }
 
 static struct i2c_algorithm smbus_algorithm = {
-	.name		= "Non-I2C SMBus adapter",
 	.id		= I2C_ALGO_SMBUS,
 	.functionality	= stub_func,
 	.smbus_xfer	= stub_xfer,
--- linux-2.6.13-rc5.orig/drivers/i2c/busses/i2c-viapro.c	2005-08-02 18:31:04.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/busses/i2c-viapro.c	2005-08-02 18:49:40.000000000 +0200
@@ -286,7 +286,6 @@
 }
 
 static struct i2c_algorithm smbus_algorithm = {
-	.name		= "Non-I2C SMBus adapter",
 	.id		= I2C_ALGO_SMBUS,
 	.smbus_xfer	= vt596_access,
 	.functionality	= vt596_func,
--- linux-2.6.13-rc5.orig/drivers/i2c/busses/scx200_acb.c	2005-08-02 18:31:04.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/busses/scx200_acb.c	2005-08-02 18:49:40.000000000 +0200
@@ -395,7 +395,6 @@
 
 /* For now, we only handle combined mode (smbus) */
 static struct i2c_algorithm scx200_acb_algorithm = {
-	.name		= "NatSemi SCx200 ACCESS.bus",
 	.id		= I2C_ALGO_SMBUS,
 	.smbus_xfer	= scx200_acb_smbus_xfer,
 	.functionality	= scx200_acb_func,
--- linux-2.6.13-rc5.orig/drivers/media/common/saa7146_i2c.c	2005-08-01 22:48:49.000000000 +0200
+++ linux-2.6.13-rc5/drivers/media/common/saa7146_i2c.c	2005-08-02 18:49:40.000000000 +0200
@@ -387,7 +387,6 @@
 
 /* exported algorithm data */
 static struct i2c_algorithm saa7146_algo = {
-	.name		= "saa7146 i2c algorithm",
 	.id		= I2C_ALGO_SAA7146,
 	.master_xfer	= saa7146_i2c_xfer,
 	.functionality	= saa7146_i2c_func,
--- linux-2.6.13-rc5.orig/drivers/media/dvb/b2c2/flexcop-i2c.c	2005-08-01 22:48:49.000000000 +0200
+++ linux-2.6.13-rc5/drivers/media/dvb/b2c2/flexcop-i2c.c	2005-08-02 18:49:40.000000000 +0200
@@ -172,7 +172,6 @@
 }
 
 static struct i2c_algorithm flexcop_algo = {
-	.name			= "FlexCop I2C algorithm",
 	.id				= I2C_ALGO_BIT,
 	.master_xfer	= flexcop_master_xfer,
 	.functionality	= flexcop_i2c_func,
--- linux-2.6.13-rc5.orig/drivers/media/dvb/dvb-usb/cxusb.c	2005-08-02 18:31:07.000000000 +0200
+++ linux-2.6.13-rc5/drivers/media/dvb/dvb-usb/cxusb.c	2005-08-02 18:49:40.000000000 +0200
@@ -141,7 +141,6 @@
 }
 
 static struct i2c_algorithm cxusb_i2c_algo = {
-	.name          = "Conexant USB I2C algorithm",
 	.id            = I2C_ALGO_BIT,
 	.master_xfer   = cxusb_i2c_xfer,
 	.functionality = cxusb_i2c_func,
--- linux-2.6.13-rc5.orig/drivers/media/dvb/dvb-usb/dibusb-common.c	2005-08-02 18:31:07.000000000 +0200
+++ linux-2.6.13-rc5/drivers/media/dvb/dvb-usb/dibusb-common.c	2005-08-02 18:49:40.000000000 +0200
@@ -147,7 +147,6 @@
 }
 
 struct i2c_algorithm dibusb_i2c_algo = {
-	.name          = "DiBcom USB I2C algorithm",
 	.id            = I2C_ALGO_BIT,
 	.master_xfer   = dibusb_i2c_xfer,
 	.functionality = dibusb_i2c_func,
--- linux-2.6.13-rc5.orig/drivers/media/dvb/dvb-usb/digitv.c	2005-08-02 18:31:07.000000000 +0200
+++ linux-2.6.13-rc5/drivers/media/dvb/dvb-usb/digitv.c	2005-08-02 18:49:40.000000000 +0200
@@ -77,7 +77,6 @@
 }
 
 static struct i2c_algorithm digitv_i2c_algo = {
-	.name          = "Nebula DigiTV USB I2C algorithm",
 	.id            = I2C_ALGO_BIT,
 	.master_xfer   = digitv_i2c_xfer,
 	.functionality = digitv_i2c_func,
--- linux-2.6.13-rc5.orig/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-08-02 18:31:08.000000000 +0200
+++ linux-2.6.13-rc5/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-08-02 18:49:40.000000000 +0200
@@ -1472,7 +1472,6 @@
 
 
 static struct i2c_algorithm ttusb_dec_algo = {
-	.name		= "ttusb dec i2c algorithm",
 	.id		= I2C_ALGO_BIT,
 	.master_xfer	= master_xfer,
 	.functionality	= functionality,
--- linux-2.6.13-rc5.orig/drivers/media/video/bttv-i2c.c	2005-08-02 18:31:08.000000000 +0200
+++ linux-2.6.13-rc5/drivers/media/video/bttv-i2c.c	2005-08-02 18:49:40.000000000 +0200
@@ -270,7 +270,6 @@
 }
 
 static struct i2c_algorithm bttv_algo = {
-	.name          = "bt878",
 	.id            = I2C_ALGO_BIT | I2C_HW_B_BT848 /* FIXME */,
 	.master_xfer   = bttv_i2c_xfer,
 	.algo_control  = algo_control,
--- linux-2.6.13-rc5.orig/drivers/media/video/saa7134/saa7134-i2c.c	2005-08-02 18:31:08.000000000 +0200
+++ linux-2.6.13-rc5/drivers/media/video/saa7134/saa7134-i2c.c	2005-08-02 18:49:40.000000000 +0200
@@ -370,7 +370,6 @@
 }
 
 static struct i2c_algorithm saa7134_algo = {
-	.name          = "saa7134",
 	.id            = I2C_ALGO_SAA7134,
 	.master_xfer   = saa7134_i2c_xfer,
 	.algo_control  = algo_control,
--- linux-2.6.13-rc5.orig/drivers/usb/media/w9968cf.c	2005-08-01 22:48:49.000000000 +0200
+++ linux-2.6.13-rc5/drivers/usb/media/w9968cf.c	2005-08-02 18:49:40.000000000 +0200
@@ -1573,7 +1573,6 @@
 	int err = 0;
 
 	static struct i2c_algorithm algo = {
-		.name =          "W996[87]CF algorithm",
 		.id =            I2C_ALGO_SMBUS,
 		.smbus_xfer =    w9968cf_i2c_smbus_xfer,
 		.algo_control =  w9968cf_i2c_control,
--- linux-2.6.13-rc5.orig/include/linux/i2c.h	2005-08-02 18:49:38.000000000 +0200
+++ linux-2.6.13-rc5/include/linux/i2c.h	2005-08-02 18:49:40.000000000 +0200
@@ -192,7 +192,6 @@
  * to name two of the most common.
  */
 struct i2c_algorithm {
-	char name[32];				/* textual description 	*/
 	unsigned int id;
 
 	/* If an adapter algorithm can't do I2C-level access, set master_xfer


-- 
Jean Delvare
