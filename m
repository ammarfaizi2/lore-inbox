Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267289AbSK3Tv6>; Sat, 30 Nov 2002 14:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267290AbSK3Tv5>; Sat, 30 Nov 2002 14:51:57 -0500
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:14341 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S267289AbSK3Tvf>; Sat, 30 Nov 2002 14:51:35 -0500
Date: Sat, 30 Nov 2002 11:45:09 -0600
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 initializers for drivers/media/radio
Message-ID: <20021130174509.GD10613@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's a patch set for switching drivers/media/radio to use C99
initializers. The patches are against 2.5.50.

Art Haas

--- linux-2.5.50/drivers/media/radio/miropcm20-radio.c.old	2002-07-05 18:42:19.000000000 -0500
+++ linux-2.5.50/drivers/media/radio/miropcm20-radio.c	2002-11-30 11:17:17.000000000 -0600
@@ -217,26 +217,25 @@
 }
 
 static struct pcm20_device pcm20_unit = {
-	freq:   87*16000,
-	muted:  1,
-	stereo: 0
+	.freq   = 87*16000,
+	.muted  = 1,
 };
 
 static struct file_operations pcm20_fops = {
-	owner:		THIS_MODULE,
-	open:           video_exclusive_open,
-	release:        video_exclusive_release,
-	ioctl:		pcm20_ioctl,
-	llseek:         no_llseek,
+	.owner		= THIS_MODULE,
+	.open           = video_exclusive_open,
+	.release        = video_exclusive_release,
+	.ioctl		= pcm20_ioctl,
+	.llseek         = no_llseek,
 };
 
 static struct video_device pcm20_radio = {
-	owner:		THIS_MODULE,
-	name:		"Miro PCM 20 radio",
-	type:		VID_TYPE_TUNER,
-	hardware:	VID_HARDWARE_RTRACK,
-	fops:           &pcm20_fops,
-	priv:		&pcm20_unit
+	.owner		= THIS_MODULE,
+	.name		= "Miro PCM 20 radio",
+	.type		= VID_TYPE_TUNER,
+	.hardware	= VID_HARDWARE_RTRACK,
+	.fops           = &pcm20_fops,
+	.priv		= &pcm20_unit
 };
 
 static int __init pcm20_init(void)
--- linux-2.5.50/drivers/media/radio/miropcm20-rds.c.old	2002-11-18 01:02:00.000000000 -0600
+++ linux-2.5.50/drivers/media/radio/miropcm20-rds.c	2002-11-30 11:18:05.000000000 -0600
@@ -105,10 +105,10 @@
 }
 
 static struct file_operations rds_f_ops = {
-	owner:	THIS_MODULE,
-	read:    rds_f_read,
-	open:    rds_f_open,
-	release: rds_f_release
+	.owner		= THIS_MODULE,
+	.read		= rds_f_read,
+	.open		= rds_f_open,
+	.release	= rds_f_release
 };
 
 
--- linux-2.5.50/drivers/media/radio/radio-aimslab.c.old	2002-07-05 18:42:19.000000000 -0500
+++ linux-2.5.50/drivers/media/radio/radio-aimslab.c	2002-11-29 10:30:35.000000000 -0600
@@ -300,20 +300,20 @@
 static struct rt_device rtrack_unit;
 
 static struct file_operations rtrack_fops = {
-	owner:		THIS_MODULE,
-	open:           video_exclusive_open,
-	release:        video_exclusive_release,
-	ioctl:	        rt_ioctl,
-	llseek:         no_llseek,
+	.owner		= THIS_MODULE,
+	.open           = video_exclusive_open,
+	.release        = video_exclusive_release,
+	.ioctl	        = rt_ioctl,
+	.llseek         = no_llseek,
 };
 
 static struct video_device rtrack_radio=
 {
-	owner:		THIS_MODULE,
-	name:		"RadioTrack radio",
-	type:		VID_TYPE_TUNER,
-	hardware:	VID_HARDWARE_RTRACK,
-	fops:           &rtrack_fops,
+	.owner		= THIS_MODULE,
+	.name		= "RadioTrack radio",
+	.type		= VID_TYPE_TUNER,
+	.hardware	= VID_HARDWARE_RTRACK,
+	.fops           = &rtrack_fops,
 };
 
 static int __init rtrack_init(void)
--- linux-2.5.50/drivers/media/radio/radio-aztech.c.old	2002-07-05 18:42:27.000000000 -0500
+++ linux-2.5.50/drivers/media/radio/radio-aztech.c	2002-11-29 10:30:37.000000000 -0600
@@ -252,20 +252,20 @@
 static struct az_device aztech_unit;
 
 static struct file_operations aztech_fops = {
-	owner:		THIS_MODULE,
-	open:           video_exclusive_open,
-	release:        video_exclusive_release,
-	ioctl:		az_ioctl,
-	llseek:         no_llseek,
+	.owner		= THIS_MODULE,
+	.open           = video_exclusive_open,
+	.release        = video_exclusive_release,
+	.ioctl		= az_ioctl,
+	.llseek         = no_llseek,
 };
 
 static struct video_device aztech_radio=
 {
-	owner:		THIS_MODULE,
-	name:		"Aztech radio",
-	type:		VID_TYPE_TUNER,
-	hardware:	VID_HARDWARE_AZTECH,
-	fops:           &aztech_fops,
+	.owner		= THIS_MODULE,
+	.name		= "Aztech radio",
+	.type		= VID_TYPE_TUNER,
+	.hardware	= VID_HARDWARE_AZTECH,
+	.fops           = &aztech_fops,
 };
 
 static int __init aztech_init(void)
--- linux-2.5.50/drivers/media/radio/radio-cadet.c.old	2002-10-12 09:46:51.000000000 -0500
+++ linux-2.5.50/drivers/media/radio/radio-cadet.c	2002-11-29 10:30:36.000000000 -0600
@@ -524,21 +524,21 @@
 
 
 static struct file_operations cadet_fops = {
-	owner:		THIS_MODULE,
-	open:		cadet_open,
-	release:       	cadet_release,
-	read:		cadet_read,
-	ioctl:		cadet_ioctl,
-	llseek:         no_llseek,
+	.owner		= THIS_MODULE,
+	.open		= cadet_open,
+	.release       	= cadet_release,
+	.read		= cadet_read,
+	.ioctl		= cadet_ioctl,
+	.llseek         = no_llseek,
 };
 
 static struct video_device cadet_radio=
 {
-	owner:		THIS_MODULE,
-	name:		"Cadet radio",
-	type:		VID_TYPE_TUNER,
-	hardware:	VID_HARDWARE_CADET,
-	fops:           &cadet_fops,
+	.owner		= THIS_MODULE,
+	.name		= "Cadet radio",
+	.type		= VID_TYPE_TUNER,
+	.hardware	= VID_HARDWARE_CADET,
+	.fops           = &cadet_fops,
 };
 
 static int isapnp_cadet_probe(void)
--- linux-2.5.50/drivers/media/radio/radio-gemtek-pci.c.old	2002-07-05 18:42:04.000000000 -0500
+++ linux-2.5.50/drivers/media/radio/radio-gemtek-pci.c	2002-11-30 11:19:03.000000000 -0600
@@ -298,19 +298,19 @@
 static u8 mx = 1;
 
 static struct file_operations gemtek_pci_fops = {
-	owner:		THIS_MODULE,
-	open:           video_exclusive_open,
-	release:        video_exclusive_release,
-	ioctl:		gemtek_pci_ioctl,
-	llseek:         no_llseek,
+	.owner		= THIS_MODULE,
+	.open           = video_exclusive_open,
+	.release        = video_exclusive_release,
+	.ioctl		= gemtek_pci_ioctl,
+	.llseek         = no_llseek,
 };
 
 static struct video_device vdev_template = {
-	owner:         THIS_MODULE,
-	name:          "Gemtek PCI Radio",
-	type:          VID_TYPE_TUNER,
-	hardware:      VID_HARDWARE_GEMTEK,
-	fops:          &gemtek_pci_fops,
+	.owner         = THIS_MODULE,
+	.name          = "Gemtek PCI Radio",
+	.type          = VID_TYPE_TUNER,
+	.hardware      = VID_HARDWARE_GEMTEK,
+	.fops          = &gemtek_pci_fops,
 };
 
 static int __devinit gemtek_pci_probe( struct pci_dev *pci_dev, const struct pci_device_id *pci_id )
@@ -387,10 +387,10 @@
 
 static struct pci_driver gemtek_pci_driver =
 {
-    name:	"gemtek_pci",
-id_table:	gemtek_pci_id,
-   probe:	gemtek_pci_probe,
-  remove:	__devexit_p(gemtek_pci_remove),
+	.name		= "gemtek_pci",
+	.id_table	= gemtek_pci_id,
+	.probe		= gemtek_pci_probe,
+	.remove		= __devexit_p(gemtek_pci_remove),
 };
 
 static int __init gemtek_pci_init_module( void )
--- linux-2.5.50/drivers/media/radio/radio-gemtek.c.old	2002-07-05 18:42:00.000000000 -0500
+++ linux-2.5.50/drivers/media/radio/radio-gemtek.c	2002-11-29 10:30:34.000000000 -0600
@@ -229,20 +229,20 @@
 static struct gemtek_device gemtek_unit;
 
 static struct file_operations gemtek_fops = {
-	owner:		THIS_MODULE,
-	open:           video_exclusive_open,
-	release:        video_exclusive_release,
-	ioctl:		gemtek_ioctl,
-	llseek:         no_llseek,
+	.owner		= THIS_MODULE,
+	.open           = video_exclusive_open,
+	.release        = video_exclusive_release,
+	.ioctl		= gemtek_ioctl,
+	.llseek         = no_llseek,
 };
 
 static struct video_device gemtek_radio=
 {
-	owner:		THIS_MODULE,
-	name:		"GemTek radio",
-	type:		VID_TYPE_TUNER,
-	hardware:	VID_HARDWARE_GEMTEK,
-	fops:           &gemtek_fops,
+	.owner		= THIS_MODULE,
+	.name		= "GemTek radio",
+	.type		= VID_TYPE_TUNER,
+	.hardware	= VID_HARDWARE_GEMTEK,
+	.fops           = &gemtek_fops,
 };
 
 static int __init gemtek_init(void)
--- linux-2.5.50/drivers/media/radio/radio-maestro.c.old	2002-07-05 18:42:31.000000000 -0500
+++ linux-2.5.50/drivers/media/radio/radio-maestro.c	2002-11-29 10:30:37.000000000 -0600
@@ -68,20 +68,20 @@
 		       unsigned int cmd, unsigned long arg);
 
 static struct file_operations maestro_fops = {
-	owner:		THIS_MODULE,
-	open:           video_exclusive_open,
-	release:        video_exclusive_release,
-	ioctl:		radio_ioctl,
-	llseek:         no_llseek,
+	.owner		= THIS_MODULE,
+	.open           = video_exclusive_open,
+	.release        = video_exclusive_release,
+	.ioctl		= radio_ioctl,
+	.llseek         = no_llseek,
 };
 
 static struct video_device maestro_radio=
 {
-	owner:		THIS_MODULE,
-	name:		"Maestro radio",
-	type:		VID_TYPE_TUNER,
-	hardware:	VID_HARDWARE_SF16MI,
-	fops:           &maestro_fops,
+	.owner		= THIS_MODULE,
+	.name		= "Maestro radio",
+	.type		= VID_TYPE_TUNER,
+	.hardware	= VID_HARDWARE_SF16MI,
+	.fops           = &maestro_fops,
 };
 
 static struct radio_device
--- linux-2.5.50/drivers/media/radio/radio-maxiradio.c.old	2002-07-05 18:42:37.000000000 -0500
+++ linux-2.5.50/drivers/media/radio/radio-maxiradio.c	2002-11-29 10:30:37.000000000 -0600
@@ -76,19 +76,19 @@
 		       unsigned int cmd, unsigned long arg);
 
 static struct file_operations maxiradio_fops = {
-	owner:		THIS_MODULE,
-	open:           video_exclusive_open,
-	release:        video_exclusive_release,
-	ioctl:	        radio_ioctl,
-	llseek:         no_llseek,
+	.owner		= THIS_MODULE,
+	.open           = video_exclusive_open,
+	.release        = video_exclusive_release,
+	.ioctl	        = radio_ioctl,
+	.llseek         = no_llseek,
 };
 static struct video_device maxiradio_radio =
 {
-	owner:		THIS_MODULE,
-	name:		"Maxi Radio FM2000 radio",
-	type:		VID_TYPE_TUNER,
-	hardware:	VID_HARDWARE_SF16MI,
-	fops:           &maxiradio_fops,
+	.owner		= THIS_MODULE,
+	.name		= "Maxi Radio FM2000 radio",
+	.type		= VID_TYPE_TUNER,
+	.hardware	= VID_HARDWARE_SF16MI,
+	.fops           = &maxiradio_fops,
 };
 
 static struct radio_device
@@ -336,10 +336,10 @@
 MODULE_DEVICE_TABLE(pci, maxiradio_pci_tbl);
 
 static struct pci_driver maxiradio_driver = {
-	name:		"radio-maxiradio",
-	id_table:	maxiradio_pci_tbl,
-	probe:		maxiradio_init_one,
-	remove:		__devexit_p(maxiradio_remove_one),
+	.name		= "radio-maxiradio",
+	.id_table	= maxiradio_pci_tbl,
+	.probe		= maxiradio_init_one,
+	.remove		= __devexit_p(maxiradio_remove_one),
 };
 
 int __init maxiradio_radio_init(void)
--- linux-2.5.50/drivers/media/radio/radio-rtrack2.c.old	2002-07-05 18:42:04.000000000 -0500
+++ linux-2.5.50/drivers/media/radio/radio-rtrack2.c	2002-11-29 10:30:35.000000000 -0600
@@ -195,20 +195,20 @@
 static struct rt_device rtrack2_unit;
 
 static struct file_operations rtrack2_fops = {
-	owner:		THIS_MODULE,
-	open:           video_exclusive_open,
-	release:        video_exclusive_release,
-	ioctl:		rt_ioctl,
-	llseek:         no_llseek,
+	.owner		= THIS_MODULE,
+	.open           = video_exclusive_open,
+	.release        = video_exclusive_release,
+	.ioctl		= rt_ioctl,
+	.llseek         = no_llseek,
 };
 
 static struct video_device rtrack2_radio=
 {
-	owner:		THIS_MODULE,
-	name:		"RadioTrack II radio",
-	type:		VID_TYPE_TUNER,
-	hardware:	VID_HARDWARE_RTRACK2,
-	fops:           &rtrack2_fops,
+	.owner		= THIS_MODULE,
+	.name		= "RadioTrack II radio",
+	.type		= VID_TYPE_TUNER,
+	.hardware	= VID_HARDWARE_RTRACK2,
+	.fops           = &rtrack2_fops,
 };
 
 static int __init rtrack2_init(void)
--- linux-2.5.50/drivers/media/radio/radio-sf16fmi.c.old	2002-11-29 09:24:05.000000000 -0600
+++ linux-2.5.50/drivers/media/radio/radio-sf16fmi.c	2002-11-29 10:30:36.000000000 -0600
@@ -223,20 +223,20 @@
 static struct fmi_device fmi_unit;
 
 static struct file_operations fmi_fops = {
-	owner:		THIS_MODULE,
-	open:           video_exclusive_open,
-	release:        video_exclusive_release,
-	ioctl:		fmi_ioctl,
-	llseek:         no_llseek,
+	.owner		= THIS_MODULE,
+	.open           = video_exclusive_open,
+	.release        = video_exclusive_release,
+	.ioctl		= fmi_ioctl,
+	.llseek         = no_llseek,
 };
 
 static struct video_device fmi_radio=
 {
-	owner:		THIS_MODULE,
-	name:		"SF16FMx radio",
-	type:		VID_TYPE_TUNER,
-	hardware:	VID_HARDWARE_SF16MI,
-	fops:           &fmi_fops,
+	.owner		= THIS_MODULE,
+	.name		= "SF16FMx radio",
+	.type		= VID_TYPE_TUNER,
+	.hardware	= VID_HARDWARE_SF16MI,
+	.fops           = &fmi_fops,
 };
 
 /* ladis: this is my card. does any other types exist? */
--- linux-2.5.50/drivers/media/radio/radio-terratec.c.old	2002-07-05 18:42:22.000000000 -0500
+++ linux-2.5.50/drivers/media/radio/radio-terratec.c	2002-11-29 10:30:36.000000000 -0600
@@ -272,20 +272,20 @@
 static struct tt_device terratec_unit;
 
 static struct file_operations terratec_fops = {
-	owner:		THIS_MODULE,
-	open:           video_exclusive_open,
-	release:        video_exclusive_release,
-	ioctl:		tt_ioctl,
-	llseek:         no_llseek,
+	.owner		= THIS_MODULE,
+	.open           = video_exclusive_open,
+	.release        = video_exclusive_release,
+	.ioctl		= tt_ioctl,
+	.llseek         = no_llseek,
 };
 
 static struct video_device terratec_radio=
 {
-	owner:		THIS_MODULE,
-	name:		"TerraTec ActiveRadio",
-	type:		VID_TYPE_TUNER,
-	hardware:	VID_HARDWARE_TERRATEC,
-	fops:           &terratec_fops,
+	.owner		= THIS_MODULE,
+	.name		= "TerraTec ActiveRadio",
+	.type		= VID_TYPE_TUNER,
+	.hardware	= VID_HARDWARE_TERRATEC,
+	.fops           = &terratec_fops,
 };
 
 static int __init terratec_init(void)
--- linux-2.5.50/drivers/media/radio/radio-trust.c.old	2002-07-05 18:42:23.000000000 -0500
+++ linux-2.5.50/drivers/media/radio/radio-trust.c	2002-11-29 10:30:37.000000000 -0600
@@ -251,20 +251,20 @@
 }
 
 static struct file_operations trust_fops = {
-	owner:		THIS_MODULE,
-	open:           video_exclusive_open,
-	release:        video_exclusive_release,
-	ioctl:		tr_ioctl,
-	llseek:         no_llseek,
+	.owner		= THIS_MODULE,
+	.open           = video_exclusive_open,
+	.release        = video_exclusive_release,
+	.ioctl		= tr_ioctl,
+	.llseek         = no_llseek,
 };
 
 static struct video_device trust_radio=
 {
-	owner:		THIS_MODULE,
-	name:		"Trust FM Radio",
-	type:		VID_TYPE_TUNER,
-	hardware:	VID_HARDWARE_TRUST,
-	fops:           &trust_fops,
+	.owner		= THIS_MODULE,
+	.name		= "Trust FM Radio",
+	.type		= VID_TYPE_TUNER,
+	.hardware	= VID_HARDWARE_TRUST,
+	.fops           = &trust_fops,
 };
 
 static int __init trust_init(void)
--- linux-2.5.50/drivers/media/radio/radio-typhoon.c.old	2002-07-05 18:42:21.000000000 -0500
+++ linux-2.5.50/drivers/media/radio/radio-typhoon.c	2002-11-29 10:30:36.000000000 -0600
@@ -251,26 +251,26 @@
 
 static struct typhoon_device typhoon_unit =
 {
-	iobase:		CONFIG_RADIO_TYPHOON_PORT,
-	curfreq:	CONFIG_RADIO_TYPHOON_MUTEFREQ,
-	mutefreq:	CONFIG_RADIO_TYPHOON_MUTEFREQ,
+	.iobase		= CONFIG_RADIO_TYPHOON_PORT,
+	.curfreq	= CONFIG_RADIO_TYPHOON_MUTEFREQ,
+	.mutefreq	= CONFIG_RADIO_TYPHOON_MUTEFREQ,
 };
 
 static struct file_operations typhoon_fops = {
-	owner:		THIS_MODULE,
-	open:           video_exclusive_open,
-	release:        video_exclusive_release,
-	ioctl:		typhoon_ioctl,
-	llseek:         no_llseek,
+	.owner		= THIS_MODULE,
+	.open           = video_exclusive_open,
+	.release        = video_exclusive_release,
+	.ioctl		= typhoon_ioctl,
+	.llseek         = no_llseek,
 };
 
 static struct video_device typhoon_radio =
 {
-	owner:		THIS_MODULE,
-	name:		"Typhoon Radio",
-	type:		VID_TYPE_TUNER,
-	hardware:	VID_HARDWARE_TYPHOON,
-	fops:           &typhoon_fops,
+	.owner		= THIS_MODULE,
+	.name		= "Typhoon Radio",
+	.type		= VID_TYPE_TUNER,
+	.hardware	= VID_HARDWARE_TYPHOON,
+	.fops           = &typhoon_fops,
 };
 
 #ifdef CONFIG_RADIO_TYPHOON_PROC_FS
--- linux-2.5.50/drivers/media/radio/radio-zoltrix.c.old	2002-10-12 09:46:51.000000000 -0500
+++ linux-2.5.50/drivers/media/radio/radio-zoltrix.c	2002-11-29 10:30:37.000000000 -0600
@@ -320,20 +320,20 @@
 
 static struct file_operations zoltrix_fops =
 {
-	owner:		THIS_MODULE,
-	open:           video_exclusive_open,
-	release:        video_exclusive_release,
-	ioctl:		zol_ioctl,
-	llseek:         no_llseek,
+	.owner		= THIS_MODULE,
+	.open           = video_exclusive_open,
+	.release        = video_exclusive_release,
+	.ioctl		= zol_ioctl,
+	.llseek         = no_llseek,
 };
 
 static struct video_device zoltrix_radio =
 {
-	owner:		THIS_MODULE,
-	name:		"Zoltrix Radio Plus",
-	type:		VID_TYPE_TUNER,
-	hardware:	VID_HARDWARE_ZOLTRIX,
-	fops:           &zoltrix_fops,
+	.owner		= THIS_MODULE,
+	.name		= "Zoltrix Radio Plus",
+	.type		= VID_TYPE_TUNER,
+	.hardware	= VID_HARDWARE_ZOLTRIX,
+	.fops           = &zoltrix_fops,
 };
 
 static int __init zoltrix_init(void)
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
