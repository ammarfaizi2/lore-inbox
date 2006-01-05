Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWAEKnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWAEKnk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 05:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWAEKnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 05:43:39 -0500
Received: from alpha.uhasselt.be ([193.190.2.30]:30994 "EHLO alpha.uhasselt.be")
	by vger.kernel.org with ESMTP id S1751117AbWAEKni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 05:43:38 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/media: Conversions from kmalloc+memset to kzalloc.
Cc: akpm@osdl.org, torvalds@osdl.org, takis@issaris.org
Reply-To: takis@issaris.org
Message-Id: <20060105104332.3E5CC6ADE@localhost.localdomain>
Date: Thu,  5 Jan 2006 11:43:32 +0100 (CET)
From: takis@issaris.org (Panagiotis Issaris)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Panagiotis Issaris <takis@issaris.org>

drivers/media: Conversions from kmalloc+memset to kzalloc.

Signed-off-by: Panagiotis Issaris <takis@issaris.org>

---

 drivers/media/common/saa7146_core.c               |    9 +++-----
 drivers/media/common/saa7146_fops.c               |    6 ++---
 drivers/media/dvb/b2c2/flexcop.c                  |    6 ++---
 drivers/media/dvb/bt8xx/dvb-bt8xx.c               |    3 +--
 drivers/media/dvb/dvb-core/dvb_ca_en50221.c       |    8 ++-----
 drivers/media/dvb/dvb-core/dvb_frontend.c         |    3 +--
 drivers/media/dvb/dvb-usb/dtt200u-fe.c            |    3 +--
 drivers/media/dvb/dvb-usb/dvb-usb-init.c          |    6 ++---
 drivers/media/dvb/dvb-usb/dvb-usb-urb.c           |    9 +++-----
 drivers/media/dvb/dvb-usb/vp702x-fe.c             |    3 +--
 drivers/media/dvb/dvb-usb/vp7045-fe.c             |    3 +--
 drivers/media/dvb/frontends/bcm3510.c             |    3 +--
 drivers/media/dvb/frontends/dib3000mb.c           |    3 +--
 drivers/media/dvb/frontends/dib3000mc.c           |    3 +--
 drivers/media/dvb/frontends/lgdt330x.c            |    3 +--
 drivers/media/dvb/frontends/mt352.c               |    3 +--
 drivers/media/dvb/frontends/nxt200x.c             |    3 +--
 drivers/media/dvb/pluto2/pluto2.c                 |    3 +--
 drivers/media/dvb/ttpci/av7110.c                  |    4 +---
 drivers/media/dvb/ttpci/budget-av.c               |    4 +---
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    4 +---
 drivers/media/dvb/ttusb-dec/ttusb_dec.c           |    4 +---
 drivers/media/radio/radio-gemtek-pci.c            |    3 +--
 drivers/media/video/adv7170.c                     |    6 ++---
 drivers/media/video/adv7175.c                     |    6 ++---
 drivers/media/video/bt819.c                       |    6 ++---
 drivers/media/video/bt832.c                       |    3 +--
 drivers/media/video/bt856.c                       |    6 ++---
 drivers/media/video/bttv-gpio.c                   |    3 +--
 drivers/media/video/cpia_pp.c                     |    3 +--
 drivers/media/video/cpia_usb.c                    |    4 +---
 drivers/media/video/cs53l32a.c                    |    3 +--
 drivers/media/video/cx25840/cx25840-core.c        |    6 ++---
 drivers/media/video/cx88/cx88-blackbird.c         |    6 ++---
 drivers/media/video/cx88/cx88-core.c              |    3 +--
 drivers/media/video/cx88/cx88-dvb.c               |    3 +--
 drivers/media/video/cx88/cx88-video.c             |    6 ++---
 drivers/media/video/dpc7146.c                     |    3 +--
 drivers/media/video/em28xx/em28xx-video.c         |    3 +--
 drivers/media/video/hexium_gemini.c               |    3 +--
 drivers/media/video/hexium_orion.c                |    3 +--
 drivers/media/video/indycam.c                     |    7 ++----
 drivers/media/video/msp3400.c                     |    3 +--
 drivers/media/video/mxb.c                         |    3 +--
 drivers/media/video/ovcamchip/ov6x20.c            |    3 +--
 drivers/media/video/ovcamchip/ov6x30.c            |    3 +--
 drivers/media/video/ovcamchip/ov76be.c            |    3 +--
 drivers/media/video/ovcamchip/ov7x10.c            |    3 +--
 drivers/media/video/ovcamchip/ov7x20.c            |    3 +--
 drivers/media/video/ovcamchip/ovcamchip_core.c    |    3 +--
 drivers/media/video/saa5246a.c                    |    3 +--
 drivers/media/video/saa5249.c                     |    5 ++--
 drivers/media/video/saa7110.c                     |    6 ++---
 drivers/media/video/saa7111.c                     |    6 ++---
 drivers/media/video/saa7114.c                     |    6 ++---
 drivers/media/video/saa7115.c                     |    6 ++---
 drivers/media/video/saa711x.c                     |    6 ++---
 drivers/media/video/saa7127.c                     |    6 ++---
 drivers/media/video/saa7134/saa6752hs.c           |    3 +--
 drivers/media/video/saa7134/saa7134-core.c        |    3 +--
 drivers/media/video/saa7134/saa7134-video.c       |    3 +--
 drivers/media/video/saa7185.c                     |    6 ++---
 drivers/media/video/saa7191.c                     |    7 ++----
 drivers/media/video/stradis.c                     |    3 +--
 drivers/media/video/tda7432.c                     |    3 +--
 drivers/media/video/tda9875.c                     |    3 +--
 drivers/media/video/tda9887.c                     |    3 +--
 drivers/media/video/tea6420.c                     |    3 +--
 drivers/media/video/tuner-core.c                  |    3 +--
 drivers/media/video/tvaudio.c                     |    3 +--
 drivers/media/video/tveeprom.c                    |    6 ++---
 drivers/media/video/tvp5150.c                     |    3 +--
 drivers/media/video/v4l1-compat.c                 |   24 +++++++--------------
 drivers/media/video/video-buf.c                   |    9 +++-----
 drivers/media/video/videocodec.c                  |   11 ++--------
 drivers/media/video/videodev.c                    |    5 +---
 drivers/media/video/vino.c                        |    4 +---
 drivers/media/video/vpx3220.c                     |    7 ++----
 drivers/media/video/wm8775.c                      |    3 +--
 drivers/media/video/zoran_card.c                  |    3 +--
 drivers/media/video/zoran_driver.c                |    3 +--
 drivers/media/video/zr36016.c                     |    3 +--
 drivers/media/video/zr36050.c                     |    3 +--
 drivers/media/video/zr36060.c                     |    3 +--
 84 files changed, 121 insertions(+), 259 deletions(-)

993e5ce2979baa3df3d8dd238d74ea3b607e4693
diff --git a/drivers/media/common/saa7146_core.c b/drivers/media/common/saa7146_core.c
index 2899d34..38982a7 100644
--- a/drivers/media/common/saa7146_core.c
+++ b/drivers/media/common/saa7146_core.c
@@ -109,10 +109,9 @@ static struct scatterlist* vmalloc_to_sg
 	struct page *pg;
 	int i;
 
-	sglist = kmalloc(sizeof(struct scatterlist)*nr_pages, GFP_KERNEL);
+	sglist = kzalloc(sizeof(struct scatterlist)*nr_pages, GFP_KERNEL);
 	if (NULL == sglist)
 		return NULL;
-	memset(sglist,0,sizeof(struct scatterlist)*nr_pages);
 	for (i = 0; i < nr_pages; i++, virt += PAGE_SIZE) {
 		pg = vmalloc_to_page(virt);
 		if (NULL == pg)
@@ -306,15 +305,13 @@ static int saa7146_init_one(struct pci_d
 	struct saa7146_dev *dev;
 	int err = -ENOMEM;
 
-	dev = kmalloc(sizeof(struct saa7146_dev), GFP_KERNEL);
+	/* clear out mem for sure */
+	dev = kzalloc(sizeof(struct saa7146_dev), GFP_KERNEL);
 	if (!dev) {
 		ERR(("out of memory.\n"));
 		goto out;
 	}
 
-	/* clear out mem for sure */
-	memset(dev, 0x0, sizeof(struct saa7146_dev));
-
 	DEB_EE(("pci:%p\n",pci));
 
 	err = pci_enable_device(pci);
diff --git a/drivers/media/common/saa7146_fops.c b/drivers/media/common/saa7146_fops.c
index 09ec964..abf1fe0 100644
--- a/drivers/media/common/saa7146_fops.c
+++ b/drivers/media/common/saa7146_fops.c
@@ -239,13 +239,12 @@ static int fops_open(struct inode *inode
 	}
 
 	/* allocate per open data */
-	fh = kmalloc(sizeof(*fh),GFP_KERNEL);
+	fh = kzalloc(sizeof(*fh),GFP_KERNEL);
 	if (NULL == fh) {
 		DEB_S(("cannot allocate memory for per open data.\n"));
 		result = -ENOMEM;
 		goto out;
 	}
-	memset(fh,0,sizeof(*fh));
 
 	file->private_data = fh;
 	fh->dev = dev;
@@ -435,12 +434,11 @@ static struct video_device device_templa
 
 int saa7146_vv_init(struct saa7146_dev* dev, struct saa7146_ext_vv *ext_vv)
 {
-	struct saa7146_vv *vv = kmalloc (sizeof(struct saa7146_vv),GFP_KERNEL);
+	struct saa7146_vv *vv = kzalloc (sizeof(struct saa7146_vv),GFP_KERNEL);
 	if( NULL == vv ) {
 		ERR(("out of memory. aborting.\n"));
 		return -1;
 	}
-	memset(vv, 0x0, sizeof(*vv));
 
 	DEB_EE(("dev:%p\n",dev));
 
diff --git a/drivers/media/dvb/b2c2/flexcop.c b/drivers/media/dvb/b2c2/flexcop.c
index 123ed96..56ba524 100644
--- a/drivers/media/dvb/b2c2/flexcop.c
+++ b/drivers/media/dvb/b2c2/flexcop.c
@@ -220,20 +220,18 @@ EXPORT_SYMBOL(flexcop_reset_block_300);
 struct flexcop_device *flexcop_device_kmalloc(size_t bus_specific_len)
 {
 	void *bus;
-	struct flexcop_device *fc = kmalloc(sizeof(struct flexcop_device), GFP_KERNEL);
+	struct flexcop_device *fc = kzalloc(sizeof(struct flexcop_device), GFP_KERNEL);
 	if (!fc) {
 		err("no memory");
 		return NULL;
 	}
-	memset(fc, 0, sizeof(struct flexcop_device));
 
-	bus = kmalloc(bus_specific_len, GFP_KERNEL);
+	bus = kzalloc(bus_specific_len, GFP_KERNEL);
 	if (!bus) {
 		err("no memory");
 		kfree(fc);
 		return NULL;
 	}
-	memset(bus, 0, bus_specific_len);
 
 	fc->bus_specific = bus;
 
diff --git a/drivers/media/dvb/bt8xx/dvb-bt8xx.c b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
index 77977e9..88ff71d 100644
--- a/drivers/media/dvb/bt8xx/dvb-bt8xx.c
+++ b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
@@ -794,10 +794,9 @@ static int dvb_bt8xx_probe(struct device
 	struct pci_dev* bttv_pci_dev;
 	int ret;
 
-	if (!(card = kmalloc(sizeof(struct dvb_bt8xx_card), GFP_KERNEL)))
+	if (!(card = kzalloc(sizeof(struct dvb_bt8xx_card), GFP_KERNEL)))
 		return -ENOMEM;
 
-	memset(card, 0, sizeof(*card));
 	init_MUTEX(&card->lock);
 	card->bttv_nr = sub->core->nr;
 	strncpy(card->card_name, sub->core->name, sizeof(sub->core->name));
diff --git a/drivers/media/dvb/dvb-core/dvb_ca_en50221.c b/drivers/media/dvb/dvb-core/dvb_ca_en50221.c
index 5956c35..a9714f3 100644
--- a/drivers/media/dvb/dvb-core/dvb_ca_en50221.c
+++ b/drivers/media/dvb/dvb-core/dvb_ca_en50221.c
@@ -1649,21 +1649,17 @@ int dvb_ca_en50221_init(struct dvb_adapt
 		return -EINVAL;
 
 	/* initialise the system data */
-	if ((ca =
-	     (struct dvb_ca_private *) kmalloc(sizeof(struct dvb_ca_private),
-					       GFP_KERNEL)) == NULL) {
+	if ((ca = kzalloc(sizeof(struct dvb_ca_private), GFP_KERNEL)) == NULL) {
 		ret = -ENOMEM;
 		goto error;
 	}
-	memset(ca, 0, sizeof(struct dvb_ca_private));
 	ca->pub = pubca;
 	ca->flags = flags;
 	ca->slot_count = slot_count;
-	if ((ca->slot_info = kmalloc(sizeof(struct dvb_ca_slot) * slot_count, GFP_KERNEL)) == NULL) {
+	if ((ca->slot_info = kzalloc(sizeof(struct dvb_ca_slot) * slot_count, GFP_KERNEL)) == NULL) {
 		ret = -ENOMEM;
 		goto error;
 	}
-	memset(ca->slot_info, 0, sizeof(struct dvb_ca_slot) * slot_count);
 	init_waitqueue_head(&ca->wait_queue);
 	ca->thread_pid = 0;
 	init_waitqueue_head(&ca->thread_queue);
diff --git a/drivers/media/dvb/dvb-core/dvb_frontend.c b/drivers/media/dvb/dvb-core/dvb_frontend.c
index 95ea509..da85737 100644
--- a/drivers/media/dvb/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb/dvb-core/dvb_frontend.c
@@ -976,13 +976,12 @@ int dvb_register_frontend(struct dvb_ada
 	if (down_interruptible (&frontend_mutex))
 		return -ERESTARTSYS;
 
-	fe->frontend_priv = kmalloc(sizeof(struct dvb_frontend_private), GFP_KERNEL);
+	fe->frontend_priv = kzalloc(sizeof(struct dvb_frontend_private), GFP_KERNEL);
 	if (fe->frontend_priv == NULL) {
 		up(&frontend_mutex);
 		return -ENOMEM;
 	}
 	fepriv = fe->frontend_priv;
-	memset(fe->frontend_priv, 0, sizeof(struct dvb_frontend_private));
 
 	init_MUTEX (&fepriv->sem);
 	init_waitqueue_head (&fepriv->wait_queue);
diff --git a/drivers/media/dvb/dvb-usb/dtt200u-fe.c b/drivers/media/dvb/dvb-usb/dtt200u-fe.c
index 0a94ec2..cd21ddb 100644
--- a/drivers/media/dvb/dvb-usb/dtt200u-fe.c
+++ b/drivers/media/dvb/dvb-usb/dtt200u-fe.c
@@ -156,10 +156,9 @@ struct dvb_frontend* dtt200u_fe_attach(s
 	struct dtt200u_fe_state* state = NULL;
 
 	/* allocate memory for the internal state */
-	state = (struct dtt200u_fe_state*) kmalloc(sizeof(struct dtt200u_fe_state), GFP_KERNEL);
+	state = kzalloc(sizeof(struct dtt200u_fe_state), GFP_KERNEL);
 	if (state == NULL)
 		goto error;
-	memset(state,0,sizeof(struct dtt200u_fe_state));
 
 	deb_info("attaching frontend dtt200u\n");
 
diff --git a/drivers/media/dvb/dvb-usb/dvb-usb-init.c b/drivers/media/dvb/dvb-usb/dvb-usb-init.c
index dd8e0b9..e60b4b3 100644
--- a/drivers/media/dvb/dvb-usb/dvb-usb-init.c
+++ b/drivers/media/dvb/dvb-usb/dvb-usb-init.c
@@ -148,12 +148,11 @@ int dvb_usb_device_init(struct usb_inter
 		ret = usb_cypress_load_firmware(udev,props->firmware,props->usb_ctrl);
 	} else {
 		info("found a '%s' in warm state.",desc->name);
-		d = kmalloc(sizeof(struct dvb_usb_device),GFP_KERNEL);
+		d = kzalloc(sizeof(struct dvb_usb_device),GFP_KERNEL);
 		if (d == NULL) {
 			err("no memory for 'struct dvb_usb_device'");
 			return ret;
 		}
-		memset(d,0,sizeof(struct dvb_usb_device));
 
 		d->udev = udev;
 		memcpy(&d->props,props,sizeof(struct dvb_usb_properties));
@@ -161,13 +160,12 @@ int dvb_usb_device_init(struct usb_inter
 		d->owner = owner;
 
 		if (d->props.size_of_priv > 0) {
-			d->priv = kmalloc(d->props.size_of_priv,GFP_KERNEL);
+			d->priv = kzalloc(d->props.size_of_priv,GFP_KERNEL);
 			if (d->priv == NULL) {
 				err("no memory for priv in 'struct dvb_usb_device'");
 				kfree(d);
 				return -ENOMEM;
 			}
-			memset(d->priv,0,d->props.size_of_priv);
 		}
 
 		usb_set_intfdata(intf, d);
diff --git a/drivers/media/dvb/dvb-usb/dvb-usb-urb.c b/drivers/media/dvb/dvb-usb/dvb-usb-urb.c
index 36b7048..403f307 100644
--- a/drivers/media/dvb/dvb-usb/dvb-usb-urb.c
+++ b/drivers/media/dvb/dvb-usb/dvb-usb-urb.c
@@ -175,15 +175,13 @@ static int dvb_usb_allocate_stream_buffe
 
 	deb_mem("all in all I will use %lu bytes for streaming\n",num*size);
 
-	if ((d->buf_list = kmalloc(num*sizeof(u8 *), GFP_ATOMIC)) == NULL)
+	if ((d->buf_list = kzalloc(num*sizeof(u8 *), GFP_ATOMIC)) == NULL)
 		return -ENOMEM;
 
-	if ((d->dma_addr = kmalloc(num*sizeof(dma_addr_t), GFP_ATOMIC)) == NULL) {
+	if ((d->dma_addr = kzalloc(num*sizeof(dma_addr_t), GFP_ATOMIC)) == NULL) {
 		kfree(d->buf_list);
 		return -ENOMEM;
 	}
-	memset(d->buf_list,0,num*sizeof(u8 *));
-	memset(d->dma_addr,0,num*sizeof(dma_addr_t));
 
 	d->state |= DVB_USB_STATE_URB_BUF;
 
@@ -285,10 +283,9 @@ int dvb_usb_urb_init(struct dvb_usb_devi
 	usb_clear_halt(d->udev,usb_rcvbulkpipe(d->udev,d->props.urb.endpoint));
 
 	/* allocate the array for the data transfer URBs */
-	d->urb_list = kmalloc(d->props.urb.count * sizeof(struct urb *),GFP_KERNEL);
+	d->urb_list = kzalloc(d->props.urb.count * sizeof(struct urb *),GFP_KERNEL);
 	if (d->urb_list == NULL)
 		return -ENOMEM;
-	memset(d->urb_list,0,d->props.urb.count * sizeof(struct urb *));
 	d->state |= DVB_USB_STATE_URB_LIST;
 
 	switch (d->props.urb.type) {
diff --git a/drivers/media/dvb/dvb-usb/vp702x-fe.c b/drivers/media/dvb/dvb-usb/vp702x-fe.c
index 104b5d0..7e8a898 100644
--- a/drivers/media/dvb/dvb-usb/vp702x-fe.c
+++ b/drivers/media/dvb/dvb-usb/vp702x-fe.c
@@ -281,10 +281,9 @@ static struct dvb_frontend_ops vp702x_fe
 
 struct dvb_frontend * vp702x_fe_attach(struct dvb_usb_device *d)
 {
-	struct vp702x_fe_state *s = kmalloc(sizeof(struct vp702x_fe_state), GFP_KERNEL);
+	struct vp702x_fe_state *s = kzalloc(sizeof(struct vp702x_fe_state), GFP_KERNEL);
 	if (s == NULL)
 		goto error;
-	memset(s,0,sizeof(struct vp702x_fe_state));
 
 	s->d = d;
 	s->fe.ops = &vp702x_fe_ops;
diff --git a/drivers/media/dvb/dvb-usb/vp7045-fe.c b/drivers/media/dvb/dvb-usb/vp7045-fe.c
index 83f1de1..5242cca 100644
--- a/drivers/media/dvb/dvb-usb/vp7045-fe.c
+++ b/drivers/media/dvb/dvb-usb/vp7045-fe.c
@@ -145,10 +145,9 @@ static struct dvb_frontend_ops vp7045_fe
 
 struct dvb_frontend * vp7045_fe_attach(struct dvb_usb_device *d)
 {
-	struct vp7045_fe_state *s = kmalloc(sizeof(struct vp7045_fe_state), GFP_KERNEL);
+	struct vp7045_fe_state *s = kzalloc(sizeof(struct vp7045_fe_state), GFP_KERNEL);
 	if (s == NULL)
 		goto error;
-	memset(s,0,sizeof(struct vp7045_fe_state));
 
 	s->d = d;
 	s->fe.ops = &vp7045_fe_ops;
diff --git a/drivers/media/dvb/frontends/bcm3510.c b/drivers/media/dvb/frontends/bcm3510.c
index 8ceb9a3..016c937 100644
--- a/drivers/media/dvb/frontends/bcm3510.c
+++ b/drivers/media/dvb/frontends/bcm3510.c
@@ -782,10 +782,9 @@ struct dvb_frontend* bcm3510_attach(cons
 	bcm3510_register_value v;
 
 	/* allocate memory for the internal state */
-	state = kmalloc(sizeof(struct bcm3510_state), GFP_KERNEL);
+	state = kzalloc(sizeof(struct bcm3510_state), GFP_KERNEL);
 	if (state == NULL)
 		goto error;
-	memset(state,0,sizeof(struct bcm3510_state));
 
 	/* setup the state */
 
diff --git a/drivers/media/dvb/frontends/dib3000mb.c b/drivers/media/dvb/frontends/dib3000mb.c
index 6b05536..ae589ad 100644
--- a/drivers/media/dvb/frontends/dib3000mb.c
+++ b/drivers/media/dvb/frontends/dib3000mb.c
@@ -700,10 +700,9 @@ struct dvb_frontend* dib3000mb_attach(co
 	struct dib3000_state* state = NULL;
 
 	/* allocate memory for the internal state */
-	state = kmalloc(sizeof(struct dib3000_state), GFP_KERNEL);
+	state = kzalloc(sizeof(struct dib3000_state), GFP_KERNEL);
 	if (state == NULL)
 		goto error;
-	memset(state,0,sizeof(struct dib3000_state));
 
 	/* setup the state */
 	state->i2c = i2c;
diff --git a/drivers/media/dvb/frontends/dib3000mc.c b/drivers/media/dvb/frontends/dib3000mc.c
index c024fad..3b303db 100644
--- a/drivers/media/dvb/frontends/dib3000mc.c
+++ b/drivers/media/dvb/frontends/dib3000mc.c
@@ -832,10 +832,9 @@ struct dvb_frontend* dib3000mc_attach(co
 	u16 devid;
 
 	/* allocate memory for the internal state */
-	state = kmalloc(sizeof(struct dib3000_state), GFP_KERNEL);
+	state = kzalloc(sizeof(struct dib3000_state), GFP_KERNEL);
 	if (state == NULL)
 		goto error;
-	memset(state,0,sizeof(struct dib3000_state));
 
 	/* setup the state */
 	state->i2c = i2c;
diff --git a/drivers/media/dvb/frontends/lgdt330x.c b/drivers/media/dvb/frontends/lgdt330x.c
index cb53018..7886269 100644
--- a/drivers/media/dvb/frontends/lgdt330x.c
+++ b/drivers/media/dvb/frontends/lgdt330x.c
@@ -711,10 +711,9 @@ struct dvb_frontend* lgdt330x_attach(con
 	u8 buf[1];
 
 	/* Allocate memory for the internal state */
-	state = (struct lgdt330x_state*) kmalloc(sizeof(struct lgdt330x_state), GFP_KERNEL);
+	state = kzalloc(sizeof(struct lgdt330x_state), GFP_KERNEL);
 	if (state == NULL)
 		goto error;
-	memset(state,0,sizeof(*state));
 
 	/* Setup the state */
 	state->config = config;
diff --git a/drivers/media/dvb/frontends/mt352.c b/drivers/media/dvb/frontends/mt352.c
index f0c610f..aaaec90 100644
--- a/drivers/media/dvb/frontends/mt352.c
+++ b/drivers/media/dvb/frontends/mt352.c
@@ -535,9 +535,8 @@ struct dvb_frontend* mt352_attach(const 
 	struct mt352_state* state = NULL;
 
 	/* allocate memory for the internal state */
-	state = kmalloc(sizeof(struct mt352_state), GFP_KERNEL);
+	state = kzalloc(sizeof(struct mt352_state), GFP_KERNEL);
 	if (state == NULL) goto error;
-	memset(state,0,sizeof(*state));
 
 	/* setup the state */
 	state->i2c = i2c;
diff --git a/drivers/media/dvb/frontends/nxt200x.c b/drivers/media/dvb/frontends/nxt200x.c
index aeafef4..78d2b93 100644
--- a/drivers/media/dvb/frontends/nxt200x.c
+++ b/drivers/media/dvb/frontends/nxt200x.c
@@ -1110,10 +1110,9 @@ struct dvb_frontend* nxt200x_attach(cons
 	u8 buf [] = {0,0,0,0,0};
 
 	/* allocate memory for the internal state */
-	state = (struct nxt200x_state*) kmalloc(sizeof(struct nxt200x_state), GFP_KERNEL);
+	state = kzalloc(sizeof(struct nxt200x_state), GFP_KERNEL);
 	if (state == NULL)
 		goto error;
-	memset(state,0,sizeof(*state));
 
 	/* setup the state */
 	state->config = config;
diff --git a/drivers/media/dvb/pluto2/pluto2.c b/drivers/media/dvb/pluto2/pluto2.c
index bbebd1c..1c5316e 100644
--- a/drivers/media/dvb/pluto2/pluto2.c
+++ b/drivers/media/dvb/pluto2/pluto2.c
@@ -584,11 +584,10 @@ static int __devinit pluto2_probe(struct
 	struct dmx_demux *dmx;
 	int ret = -ENOMEM;
 
-	pluto = kmalloc(sizeof(struct pluto), GFP_KERNEL);
+	pluto = kzalloc(sizeof(struct pluto), GFP_KERNEL);
 	if (!pluto)
 		goto out;
 
-	memset(pluto, 0, sizeof(struct pluto));
 	pluto->pdev = pdev;
 
 	ret = pci_enable_device(pdev);
diff --git a/drivers/media/dvb/ttpci/av7110.c b/drivers/media/dvb/ttpci/av7110.c
index 7dae91e..9084c09 100644
--- a/drivers/media/dvb/ttpci/av7110.c
+++ b/drivers/media/dvb/ttpci/av7110.c
@@ -2514,14 +2514,12 @@ static int av7110_attach(struct saa7146_
 	}
 
 	/* prepare the av7110 device struct */
-	av7110 = kmalloc(sizeof(struct av7110), GFP_KERNEL);
+	av7110 = kzalloc(sizeof(struct av7110), GFP_KERNEL);
 	if (!av7110) {
 		dprintk(1, "out of memory\n");
 		return -ENOMEM;
 	}
 
-	memset(av7110, 0, sizeof(struct av7110));
-
 	av7110->card_name = (char*) pci_ext->ext_priv;
 	av7110->dev = dev;
 	dev->ext_priv = av7110;
diff --git a/drivers/media/dvb/ttpci/budget-av.c b/drivers/media/dvb/ttpci/budget-av.c
index 9f51bae..38e4699 100644
--- a/drivers/media/dvb/ttpci/budget-av.c
+++ b/drivers/media/dvb/ttpci/budget-av.c
@@ -854,11 +854,9 @@ static int budget_av_attach(struct saa71
 
 	dprintk(2, "dev: %p\n", dev);
 
-	if (!(budget_av = kmalloc(sizeof(struct budget_av), GFP_KERNEL)))
+	if (!(budget_av = kzalloc(sizeof(struct budget_av), GFP_KERNEL)))
 		return -ENOMEM;
 
-	memset(budget_av, 0, sizeof(struct budget_av));
-
 	budget_av->has_saa7113 = 0;
 	budget_av->budget.ci_present = 0;
 
diff --git a/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c b/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
index 104df61..5a13c47 100644
--- a/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
+++ b/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
@@ -1489,11 +1489,9 @@ static int ttusb_probe(struct usb_interf
 
 	if (intf->altsetting->desc.bInterfaceNumber != 1) return -ENODEV;
 
-	if (!(ttusb = kmalloc(sizeof(struct ttusb), GFP_KERNEL)))
+	if (!(ttusb = kzalloc(sizeof(struct ttusb), GFP_KERNEL)))
 		return -ENOMEM;
 
-	memset(ttusb, 0, sizeof(struct ttusb));
-
 	ttusb->dev = udev;
 	ttusb->c = 0;
 	ttusb->mux_state = 0;
diff --git a/drivers/media/dvb/ttusb-dec/ttusb_dec.c b/drivers/media/dvb/ttusb-dec/ttusb_dec.c
index 8abc218..307f89a 100644
--- a/drivers/media/dvb/ttusb-dec/ttusb_dec.c
+++ b/drivers/media/dvb/ttusb-dec/ttusb_dec.c
@@ -1606,15 +1606,13 @@ static int ttusb_dec_probe(struct usb_in
 
 	udev = interface_to_usbdev(intf);
 
-	if (!(dec = kmalloc(sizeof(struct ttusb_dec), GFP_KERNEL))) {
+	if (!(dec = kzalloc(sizeof(struct ttusb_dec), GFP_KERNEL))) {
 		printk("%s: couldn't allocate memory.\n", __FUNCTION__);
 		return -ENOMEM;
 	}
 
 	usb_set_intfdata(intf, (void *)dec);
 
-	memset(dec, 0, sizeof(struct ttusb_dec));
-
 	switch (le16_to_cpu(id->idProduct)) {
 	case 0x1006:
 		ttusb_dec_set_model(dec, TTUSB_DEC3000S);
diff --git a/drivers/media/radio/radio-gemtek-pci.c b/drivers/media/radio/radio-gemtek-pci.c
index 630cc78..71d86d7 100644
--- a/drivers/media/radio/radio-gemtek-pci.c
+++ b/drivers/media/radio/radio-gemtek-pci.c
@@ -317,11 +317,10 @@ static int __devinit gemtek_pci_probe( s
 	struct gemtek_pci_card *card;
 	struct video_device *devradio;
 
-	if ( (card = kmalloc( sizeof( struct gemtek_pci_card ), GFP_KERNEL )) == NULL ) {
+	if ( (card = kzalloc( sizeof( struct gemtek_pci_card ), GFP_KERNEL )) == NULL ) {
 		printk( KERN_ERR "gemtek_pci: out of memory\n" );
 		return -ENOMEM;
 	}
-	memset( card, 0, sizeof( struct gemtek_pci_card ) );
 
 	if ( pci_enable_device( pci_dev ) ) 
 		goto err_pci;
diff --git a/drivers/media/video/adv7170.c b/drivers/media/video/adv7170.c
index 1ca2b67..2e19cae 100644
--- a/drivers/media/video/adv7170.c
+++ b/drivers/media/video/adv7170.c
@@ -413,10 +413,9 @@ adv7170_detect_client (struct i2c_adapte
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return 0;
 
-	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (client == 0)
 		return -ENOMEM;
-	memset(client, 0, sizeof(struct i2c_client));
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_adv7170;
@@ -434,12 +433,11 @@ adv7170_detect_client (struct i2c_adapte
 	}
 	strlcpy(I2C_NAME(client), dname, sizeof(I2C_NAME(client)));
 
-	encoder = kmalloc(sizeof(struct adv7170), GFP_KERNEL);
+	encoder = kzalloc(sizeof(struct adv7170), GFP_KERNEL);
 	if (encoder == NULL) {
 		kfree(client);
 		return -ENOMEM;
 	}
-	memset(encoder, 0, sizeof(struct adv7170));
 	encoder->norm = VIDEO_MODE_NTSC;
 	encoder->input = 0;
 	encoder->enable = 1;
diff --git a/drivers/media/video/adv7175.c b/drivers/media/video/adv7175.c
index 173bca1..2be0017 100644
--- a/drivers/media/video/adv7175.c
+++ b/drivers/media/video/adv7175.c
@@ -463,10 +463,9 @@ adv7175_detect_client (struct i2c_adapte
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return 0;
 
-	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (client == 0)
 		return -ENOMEM;
-	memset(client, 0, sizeof(struct i2c_client));
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_adv7175;
@@ -484,12 +483,11 @@ adv7175_detect_client (struct i2c_adapte
 	}
 	strlcpy(I2C_NAME(client), dname, sizeof(I2C_NAME(client)));
 
-	encoder = kmalloc(sizeof(struct adv7175), GFP_KERNEL);
+	encoder = kzalloc(sizeof(struct adv7175), GFP_KERNEL);
 	if (encoder == NULL) {
 		kfree(client);
 		return -ENOMEM;
 	}
-	memset(encoder, 0, sizeof(struct adv7175));
 	encoder->norm = VIDEO_MODE_PAL;
 	encoder->input = 0;
 	encoder->enable = 1;
diff --git a/drivers/media/video/bt819.c b/drivers/media/video/bt819.c
index 3ee0afc..4eb7d9e 100644
--- a/drivers/media/video/bt819.c
+++ b/drivers/media/video/bt819.c
@@ -528,22 +528,20 @@ bt819_detect_client (struct i2c_adapter 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return 0;
 
-	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (client == 0)
 		return -ENOMEM;
-	memset(client, 0, sizeof(struct i2c_client));
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_bt819;
 	client->flags = I2C_CLIENT_ALLOW_USE;
 
-	decoder = kmalloc(sizeof(struct bt819), GFP_KERNEL);
+	decoder = kzalloc(sizeof(struct bt819), GFP_KERNEL);
 	if (decoder == NULL) {
 		kfree(client);
 		return -ENOMEM;
 	}
 
-	memset(decoder, 0, sizeof(struct bt819));
 	decoder->norm = VIDEO_MODE_NTSC;
 	decoder->input = 0;
 	decoder->enable = 1;
diff --git a/drivers/media/video/bt832.c b/drivers/media/video/bt832.c
index 3ca1d76..3f60184 100644
--- a/drivers/media/video/bt832.c
+++ b/drivers/media/video/bt832.c
@@ -166,9 +166,8 @@ static int bt832_attach(struct i2c_adapt
 
 	printk("bt832: chip found @ 0x%x\n", addr<<1);
 
-	if (NULL == (t = kmalloc(sizeof(*t), GFP_KERNEL)))
+	if (NULL == (t = kzalloc(sizeof(*t), GFP_KERNEL)))
 		return -ENOMEM;
-	memset(t,0,sizeof(*t));
 	t->client = client_template;
 	i2c_set_clientdata(&t->client, t);
 	i2c_attach_client(&t->client);
diff --git a/drivers/media/video/bt856.c b/drivers/media/video/bt856.c
index 8eb871d..da63d1d 100644
--- a/drivers/media/video/bt856.c
+++ b/drivers/media/video/bt856.c
@@ -316,22 +316,20 @@ bt856_detect_client (struct i2c_adapter 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return 0;
 
-	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (client == 0)
 		return -ENOMEM;
-	memset(client, 0, sizeof(struct i2c_client));
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_bt856;
 	client->flags = I2C_CLIENT_ALLOW_USE;
 	strlcpy(I2C_NAME(client), "bt856", sizeof(I2C_NAME(client)));
 
-	encoder = kmalloc(sizeof(struct bt856), GFP_KERNEL);
+	encoder = kzalloc(sizeof(struct bt856), GFP_KERNEL);
 	if (encoder == NULL) {
 		kfree(client);
 		return -ENOMEM;
 	}
-	memset(encoder, 0, sizeof(struct bt856));
 	encoder->norm = VIDEO_MODE_NTSC;
 	encoder->enable = 1;
 	i2c_set_clientdata(client, encoder);
diff --git a/drivers/media/video/bttv-gpio.c b/drivers/media/video/bttv-gpio.c
index 616a5b7..7db251d 100644
--- a/drivers/media/video/bttv-gpio.c
+++ b/drivers/media/video/bttv-gpio.c
@@ -64,10 +64,9 @@ int bttv_sub_add_device(struct bttv_core
 	struct bttv_sub_device *sub;
 	int err;
 
-	sub = kmalloc(sizeof(*sub),GFP_KERNEL);
+	sub = kzalloc(sizeof(*sub),GFP_KERNEL);
 	if (NULL == sub)
 		return -ENOMEM;
-	memset(sub,0,sizeof(*sub));
 
 	sub->core        = core;
 	sub->dev.parent  = &core->pci->dev;
diff --git a/drivers/media/video/cpia_pp.c b/drivers/media/video/cpia_pp.c
index ddf184f..6d096f2 100644
--- a/drivers/media/video/cpia_pp.c
+++ b/drivers/media/video/cpia_pp.c
@@ -706,12 +706,11 @@ static int cpia_pp_register(struct parpo
 		return -ENXIO;
 	}
 
-	cam = kmalloc(sizeof(struct pp_cam_entry), GFP_KERNEL);
+	cam = kzalloc(sizeof(struct pp_cam_entry), GFP_KERNEL);
 	if (cam == NULL) {
 		LOG("failed to allocate camera structure\n");
 		return -ENOMEM;
 	}
-	memset(cam,0,sizeof(struct pp_cam_entry));
 	
 	pdev = parport_register_device(port, "cpia_pp", NULL, NULL,
 	                               NULL, 0, cam);
diff --git a/drivers/media/video/cpia_usb.c b/drivers/media/video/cpia_usb.c
index 9774e94..8e775dd 100644
--- a/drivers/media/video/cpia_usb.c
+++ b/drivers/media/video/cpia_usb.c
@@ -499,14 +499,12 @@ static int cpia_probe(struct usb_interfa
 
 	printk(KERN_INFO "USB CPiA camera found\n");
 
-	ucpia = kmalloc(sizeof(*ucpia), GFP_KERNEL);
+	ucpia = kzalloc(sizeof(*ucpia), GFP_KERNEL);
 	if (!ucpia) {
 		printk(KERN_ERR "couldn't kmalloc cpia struct\n");
 		return -ENOMEM;
 	}
 
-	memset(ucpia, 0, sizeof(*ucpia));
-
 	ucpia->dev = udev;
 	ucpia->iface = interface->desc.bInterfaceNumber;
 	init_waitqueue_head(&ucpia->wq_stream);
diff --git a/drivers/media/video/cs53l32a.c b/drivers/media/video/cs53l32a.c
index 780b352..f9e3b8b 100644
--- a/drivers/media/video/cs53l32a.c
+++ b/drivers/media/video/cs53l32a.c
@@ -146,11 +146,10 @@ static int cs53l32a_attach(struct i2c_ad
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return 0;
 
-	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (client == 0)
 		return -ENOMEM;
 
-	memset(client, 0, sizeof(struct i2c_client));
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver;
diff --git a/drivers/media/video/cx25840/cx25840-core.c b/drivers/media/video/cx25840/cx25840-core.c
index 5b93723..7028bfc 100644
--- a/drivers/media/video/cx25840/cx25840-core.c
+++ b/drivers/media/video/cx25840/cx25840-core.c
@@ -765,11 +765,10 @@ static int cx25840_detect_client(struct 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_I2C))
 		return 0;
 
-	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (client == 0)
 		return -ENOMEM;
 
-	memset(client, 0, sizeof(struct i2c_client));
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_cx25840;
@@ -794,14 +793,13 @@ static int cx25840_detect_client(struct 
 		    (device_id & 0x0f) < 3 ? (device_id & 0x0f) + 1 : 3,
 		    address << 1, adapter->name);
 
-	state = kmalloc(sizeof(struct cx25840_state), GFP_KERNEL);
+	state = kzalloc(sizeof(struct cx25840_state), GFP_KERNEL);
 	if (state == NULL) {
 		kfree(client);
 		return -ENOMEM;
 	}
 
 	i2c_set_clientdata(client, state);
-	memset(state, 0, sizeof(struct cx25840_state));
 	state->input = CX25840_TUNER;
 	state->audclk_freq = V4L2_AUDCLK_48_KHZ;
 	state->audio_input = AUDIO_TUNER;
diff --git a/drivers/media/video/cx88/cx88-blackbird.c b/drivers/media/video/cx88/cx88-blackbird.c
index 74e57a5..8add6c6 100644
--- a/drivers/media/video/cx88/cx88-blackbird.c
+++ b/drivers/media/video/cx88/cx88-blackbird.c
@@ -1539,10 +1539,9 @@ static int mpeg_open(struct inode *inode
 	dprintk(1,"open minor=%d\n",minor);
 
 	/* allocate + initialize per filehandle data */
-	fh = kmalloc(sizeof(*fh),GFP_KERNEL);
+	fh = kzalloc(sizeof(*fh),GFP_KERNEL);
 	if (NULL == fh)
 		return -ENOMEM;
-	memset(fh,0,sizeof(*fh));
 	file->private_data = fh;
 	fh->dev      = dev;
 
@@ -1678,10 +1677,9 @@ static int __devinit blackbird_probe(str
 		goto fail_core;
 
 	err = -ENOMEM;
-	dev = kmalloc(sizeof(*dev),GFP_KERNEL);
+	dev = kzalloc(sizeof(*dev),GFP_KERNEL);
 	if (NULL == dev)
 		goto fail_core;
-	memset(dev,0,sizeof(*dev));
 	dev->pci = pci_dev;
 	dev->core = core;
 	dev->width = 720;
diff --git a/drivers/media/video/cx88/cx88-core.c b/drivers/media/video/cx88/cx88-core.c
index bb6eb54..07ab5bf 100644
--- a/drivers/media/video/cx88/cx88-core.c
+++ b/drivers/media/video/cx88/cx88-core.c
@@ -1104,11 +1104,10 @@ struct cx88_core* cx88_core_get(struct p
 		up(&devlist);
 		return core;
 	}
-	core = kmalloc(sizeof(*core),GFP_KERNEL);
+	core = kzalloc(sizeof(*core),GFP_KERNEL);
 	if (NULL == core)
 		goto fail_unlock;
 
-	memset(core,0,sizeof(*core));
 	atomic_inc(&core->refcount);
 	core->pci_bus  = pci->bus->number;
 	core->pci_slot = PCI_SLOT(pci->devfn);
diff --git a/drivers/media/video/cx88/cx88-dvb.c b/drivers/media/video/cx88/cx88-dvb.c
index 99ea955..8c0f581 100644
--- a/drivers/media/video/cx88/cx88-dvb.c
+++ b/drivers/media/video/cx88/cx88-dvb.c
@@ -462,10 +462,9 @@ static int __devinit dvb_probe(struct pc
 		goto fail_core;
 
 	err = -ENOMEM;
-	dev = kmalloc(sizeof(*dev),GFP_KERNEL);
+	dev = kzalloc(sizeof(*dev),GFP_KERNEL);
 	if (NULL == dev)
 		goto fail_core;
-	memset(dev,0,sizeof(*dev));
 	dev->pci = pci_dev;
 	dev->core = core;
 
diff --git a/drivers/media/video/cx88/cx88-video.c b/drivers/media/video/cx88/cx88-video.c
index 24a48f8..4db7e50 100644
--- a/drivers/media/video/cx88/cx88-video.c
+++ b/drivers/media/video/cx88/cx88-video.c
@@ -748,10 +748,9 @@ static int video_open(struct inode *inod
 		minor,radio,v4l2_type_names[type]);
 
 	/* allocate + initialize per filehandle data */
-	fh = kmalloc(sizeof(*fh),GFP_KERNEL);
+	fh = kzalloc(sizeof(*fh),GFP_KERNEL);
 	if (NULL == fh)
 		return -ENOMEM;
-	memset(fh,0,sizeof(*fh));
 	file->private_data = fh;
 	fh->dev      = dev;
 	fh->radio    = radio;
@@ -1813,10 +1812,9 @@ static int __devinit cx8800_initdev(stru
 	struct cx88_core *core;
 	int err;
 
-	dev = kmalloc(sizeof(*dev),GFP_KERNEL);
+	dev = kzalloc(sizeof(*dev),GFP_KERNEL);
 	if (NULL == dev)
 		return -ENOMEM;
-	memset(dev,0,sizeof(*dev));
 
 	/* pci init */
 	dev->pci = pci_dev;
diff --git a/drivers/media/video/dpc7146.c b/drivers/media/video/dpc7146.c
index da94811..2831bdd 100644
--- a/drivers/media/video/dpc7146.c
+++ b/drivers/media/video/dpc7146.c
@@ -94,12 +94,11 @@ static int dpc_probe(struct saa7146_dev*
 	struct i2c_client *client;
 	struct list_head *item;
 
-	dpc = (struct dpc*)kmalloc(sizeof(struct dpc), GFP_KERNEL);
+	dpc = kzalloc(sizeof(struct dpc), GFP_KERNEL);
 	if( NULL == dpc ) {
 		printk("dpc_v4l2.o: dpc_probe: not enough kernel memory.\n");
 		return -ENOMEM;
 	}
-	memset(dpc, 0x0, sizeof(struct dpc));	
 
 	/* FIXME: enable i2c-port pins, video-port-pins
 	   video port pins should be enabled here ?! */
diff --git a/drivers/media/video/em28xx/em28xx-video.c b/drivers/media/video/em28xx/em28xx-video.c
index 06d7687..1320363 100644
--- a/drivers/media/video/em28xx/em28xx-video.c
+++ b/drivers/media/video/em28xx/em28xx-video.c
@@ -1777,12 +1777,11 @@ static int em28xx_usb_probe(struct usb_i
 	}
 
 	/* allocate memory for our device state and initialize it */
-	dev = kmalloc(sizeof(*dev), GFP_KERNEL);
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (dev == NULL) {
 		em28xx_err(DRIVER_NAME ": out of memory!\n");
 		return -ENOMEM;
 	}
-	memset(dev, 0, sizeof(*dev));
 
 	/* compute alternate max packet sizes */
 	uif = udev->actconfig->interface[0];
diff --git a/drivers/media/video/hexium_gemini.c b/drivers/media/video/hexium_gemini.c
index c9b00ea..e7bbeb1 100644
--- a/drivers/media/video/hexium_gemini.c
+++ b/drivers/media/video/hexium_gemini.c
@@ -240,12 +240,11 @@ static int hexium_attach(struct saa7146_
 
 	DEB_EE((".\n"));
 
-	hexium = (struct hexium *) kmalloc(sizeof(struct hexium), GFP_KERNEL);
+	hexium = kzalloc(sizeof(struct hexium), GFP_KERNEL);
 	if (NULL == hexium) {
 		printk("hexium_gemini: not enough kernel memory in hexium_attach().\n");
 		return -ENOMEM;
 	}
-	memset(hexium, 0x0, sizeof(struct hexium));
 	dev->ext_priv = hexium;
 
 	/* enable i2c-port pins */
diff --git a/drivers/media/video/hexium_orion.c b/drivers/media/video/hexium_orion.c
index 42a9414..0b6c209 100644
--- a/drivers/media/video/hexium_orion.c
+++ b/drivers/media/video/hexium_orion.c
@@ -224,12 +224,11 @@ static int hexium_probe(struct saa7146_d
 		return -EFAULT;
 	}
 
-	hexium = (struct hexium *) kmalloc(sizeof(struct hexium), GFP_KERNEL);
+	hexium = kzalloc(sizeof(struct hexium), GFP_KERNEL);
 	if (NULL == hexium) {
 		printk("hexium_orion: hexium_probe: not enough kernel memory.\n");
 		return -ENOMEM;
 	}
-	memset(hexium, 0x0, sizeof(struct hexium));
 
 	/* enable i2c-port pins */
 	saa7146_write(dev, MC1, (MASK_08 | MASK_24 | MASK_10 | MASK_26));
diff --git a/drivers/media/video/indycam.c b/drivers/media/video/indycam.c
index deeef12..4006e00 100644
--- a/drivers/media/video/indycam.c
+++ b/drivers/media/video/indycam.c
@@ -289,18 +289,15 @@ static int indycam_attach(struct i2c_ada
 	printk(KERN_INFO "SGI IndyCam driver version %s\n",
 	       INDYCAM_MODULE_VERSION);
 
-	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (!client)
 		return -ENOMEM;
-	camera = kmalloc(sizeof(struct indycam), GFP_KERNEL);
+	camera = kzalloc(sizeof(struct indycam), GFP_KERNEL);
 	if (!camera) {
 		err = -ENOMEM;
 		goto out_free_client;
 	}
 
-	memset(client, 0, sizeof(struct i2c_client));
-	memset(camera, 0, sizeof(struct indycam));
-
 	client->addr = addr;
 	client->adapter = adap;
 	client->driver = &i2c_driver_indycam;
diff --git a/drivers/media/video/msp3400.c b/drivers/media/video/msp3400.c
index d86f8e9..c61d352 100644
--- a/drivers/media/video/msp3400.c
+++ b/drivers/media/video/msp3400.c
@@ -1599,12 +1599,11 @@ static int msp_attach(struct i2c_adapter
 	if (NULL == (client = kmalloc(sizeof(struct i2c_client),GFP_KERNEL)))
 		return -ENOMEM;
 	memcpy(client,&client_template,sizeof(struct i2c_client));
-	if (NULL == (msp = kmalloc(sizeof(struct msp3400c),GFP_KERNEL))) {
+	if (NULL == (msp = kzalloc(sizeof(struct msp3400c),GFP_KERNEL))) {
 		kfree(client);
 		return -ENOMEM;
 	}
 
-	memset(msp,0,sizeof(struct msp3400c));
 	msp->norm = VIDEO_MODE_NTSC;
 	msp->left = 58880;	/* 0db gain */
 	msp->right = 58880;	/* 0db gain */
diff --git a/drivers/media/video/mxb.c b/drivers/media/video/mxb.c
index d04793f..5854784 100644
--- a/drivers/media/video/mxb.c
+++ b/drivers/media/video/mxb.c
@@ -176,12 +176,11 @@ static int mxb_probe(struct saa7146_dev*
 		return -ENODEV;
 	}
 
-	mxb = (struct mxb*)kmalloc(sizeof(struct mxb), GFP_KERNEL);
+	mxb = kzalloc(sizeof(struct mxb), GFP_KERNEL);
 	if( NULL == mxb ) {
 		DEB_D(("not enough kernel memory.\n"));
 		return -ENOMEM;
 	}
-	memset(mxb, 0x0, sizeof(struct mxb));	
 
 	mxb->i2c_adapter = (struct i2c_adapter) {
 		.class = I2C_CLASS_TV_ANALOG,
diff --git a/drivers/media/video/ovcamchip/ov6x20.c b/drivers/media/video/ovcamchip/ov6x20.c
index b3f4d26..c04130d 100644
--- a/drivers/media/video/ovcamchip/ov6x20.c
+++ b/drivers/media/video/ovcamchip/ov6x20.c
@@ -178,10 +178,9 @@ static int ov6x20_init(struct i2c_client
 	if (rc < 0)
 		return rc;
 
-	ov->spriv = s = kmalloc(sizeof *s, GFP_KERNEL);
+	ov->spriv = s = kzalloc(sizeof *s, GFP_KERNEL);
 	if (!s)
 		return -ENOMEM;
-	memset(s, 0, sizeof *s);
 
 	s->auto_brt = 1;
 	s->auto_exp = 1;
diff --git a/drivers/media/video/ovcamchip/ov6x30.c b/drivers/media/video/ovcamchip/ov6x30.c
index 6eab458..73b94f5 100644
--- a/drivers/media/video/ovcamchip/ov6x30.c
+++ b/drivers/media/video/ovcamchip/ov6x30.c
@@ -141,10 +141,9 @@ static int ov6x30_init(struct i2c_client
 	if (rc < 0)
 		return rc;
 
-	ov->spriv = s = kmalloc(sizeof *s, GFP_KERNEL);
+	ov->spriv = s = kzalloc(sizeof *s, GFP_KERNEL);
 	if (!s)
 		return -ENOMEM;
-	memset(s, 0, sizeof *s);
 
 	s->auto_brt = 1;
 	s->auto_exp = 1;
diff --git a/drivers/media/video/ovcamchip/ov76be.c b/drivers/media/video/ovcamchip/ov76be.c
index 29bbdc0..11f6be9 100644
--- a/drivers/media/video/ovcamchip/ov76be.c
+++ b/drivers/media/video/ovcamchip/ov76be.c
@@ -105,10 +105,9 @@ static int ov76be_init(struct i2c_client
 	if (rc < 0)
 		return rc;
 
-	ov->spriv = s = kmalloc(sizeof *s, GFP_KERNEL);
+	ov->spriv = s = kzalloc(sizeof *s, GFP_KERNEL);
 	if (!s)
 		return -ENOMEM;
-	memset(s, 0, sizeof *s);
 
 	s->auto_brt = 1;
 	s->auto_exp = 1;
diff --git a/drivers/media/video/ovcamchip/ov7x10.c b/drivers/media/video/ovcamchip/ov7x10.c
index 6c383d4..5206e79 100644
--- a/drivers/media/video/ovcamchip/ov7x10.c
+++ b/drivers/media/video/ovcamchip/ov7x10.c
@@ -115,10 +115,9 @@ static int ov7x10_init(struct i2c_client
 	if (rc < 0)
 		return rc;
 
-	ov->spriv = s = kmalloc(sizeof *s, GFP_KERNEL);
+	ov->spriv = s = kzalloc(sizeof *s, GFP_KERNEL);
 	if (!s)
 		return -ENOMEM;
-	memset(s, 0, sizeof *s);
 
 	s->auto_brt = 1;
 	s->auto_exp = 1;
diff --git a/drivers/media/video/ovcamchip/ov7x20.c b/drivers/media/video/ovcamchip/ov7x20.c
index 3c8c48f..8e26ae3 100644
--- a/drivers/media/video/ovcamchip/ov7x20.c
+++ b/drivers/media/video/ovcamchip/ov7x20.c
@@ -232,10 +232,9 @@ static int ov7x20_init(struct i2c_client
 	if (rc < 0)
 		return rc;
 
-	ov->spriv = s = kmalloc(sizeof *s, GFP_KERNEL);
+	ov->spriv = s = kzalloc(sizeof *s, GFP_KERNEL);
 	if (!s)
 		return -ENOMEM;
-	memset(s, 0, sizeof *s);
 
 	s->auto_brt = 1;
 	s->auto_exp = DFL_AUTO_EXP;
diff --git a/drivers/media/video/ovcamchip/ovcamchip_core.c b/drivers/media/video/ovcamchip/ovcamchip_core.c
index 2de34eb..1d6a387 100644
--- a/drivers/media/video/ovcamchip/ovcamchip_core.c
+++ b/drivers/media/video/ovcamchip/ovcamchip_core.c
@@ -316,12 +316,11 @@ static int ovcamchip_attach(struct i2c_a
 	c->adapter = adap;
 	strcpy(c->name, "OV????");
 
-	ov = kmalloc(sizeof *ov, GFP_KERNEL);
+	ov = kzalloc(sizeof *ov, GFP_KERNEL);
 	if (!ov) {
 		rc = -ENOMEM;
 		goto no_ov;
 	}
-	memset(ov, 0, sizeof *ov);
 	i2c_set_clientdata(c, ov);
 
 	rc = ovcamchip_detect(c);
diff --git a/drivers/media/video/saa5246a.c b/drivers/media/video/saa5246a.c
index b8054da..6c2d4de 100644
--- a/drivers/media/video/saa5246a.c
+++ b/drivers/media/video/saa5246a.c
@@ -83,13 +83,12 @@ static int saa5246a_attach(struct i2c_ad
 	client_template.adapter = adap;
 	client_template.addr = addr;
 	memcpy(client, &client_template, sizeof(*client));
-	t = kmalloc(sizeof(*t), GFP_KERNEL);
+	t = kzalloc(sizeof(*t), GFP_KERNEL);
 	if(t==NULL)
 	{
 		kfree(client);
 		return -ENOMEM;
 	}
-	memset(t, 0, sizeof(*t));
 	strlcpy(client->name, IF_NAME, I2C_NAME_SIZE);
 	init_MUTEX(&t->lock);
 
diff --git a/drivers/media/video/saa5249.c b/drivers/media/video/saa5249.c
index 7ffa2e9..b6b1e62 100644
--- a/drivers/media/video/saa5249.c
+++ b/drivers/media/video/saa5249.c
@@ -151,13 +151,12 @@ static int saa5249_attach(struct i2c_ada
         client_template.adapter = adap;
         client_template.addr = addr;
 	memcpy(client, &client_template, sizeof(*client));
-	t = kmalloc(sizeof(*t), GFP_KERNEL);
+	t = kzalloc(sizeof(*t), GFP_KERNEL);
 	if(t==NULL)
 	{
 		kfree(client);
 		return -ENOMEM;
 	}
-	memset(t, 0, sizeof(*t));
 	strlcpy(client->name, IF_NAME, I2C_NAME_SIZE);
 	init_MUTEX(&t->lock);
 	
@@ -165,7 +164,7 @@ static int saa5249_attach(struct i2c_ada
 	 *	Now create a video4linux device
 	 */
 	 
-	vd = (struct video_device *)kmalloc(sizeof(struct video_device), GFP_KERNEL);
+	vd = kmalloc(sizeof(struct video_device), GFP_KERNEL);
 	if(vd==NULL)
 	{
 		kfree(t);
diff --git a/drivers/media/video/saa7110.c b/drivers/media/video/saa7110.c
index e116bdb..93270e5 100644
--- a/drivers/media/video/saa7110.c
+++ b/drivers/media/video/saa7110.c
@@ -494,22 +494,20 @@ saa7110_detect_client (struct i2c_adapte
 	     I2C_FUNC_SMBUS_READ_BYTE | I2C_FUNC_SMBUS_WRITE_BYTE_DATA))
 		return 0;
 
-	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (client == 0)
 		return -ENOMEM;
-	memset(client, 0, sizeof(struct i2c_client));
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_saa7110;
 	client->flags = I2C_CLIENT_ALLOW_USE;
 	strlcpy(I2C_NAME(client), "saa7110", sizeof(I2C_NAME(client)));
 
-	decoder = kmalloc(sizeof(struct saa7110), GFP_KERNEL);
+	decoder = kzalloc(sizeof(struct saa7110), GFP_KERNEL);
 	if (decoder == 0) {
 		kfree(client);
 		return -ENOMEM;
 	}
-	memset(decoder, 0, sizeof(struct saa7110));
 	decoder->norm = VIDEO_MODE_PAL;
 	decoder->input = 0;
 	decoder->enable = 1;
diff --git a/drivers/media/video/saa7111.c b/drivers/media/video/saa7111.c
index fe8a5e4..a01ce4b 100644
--- a/drivers/media/video/saa7111.c
+++ b/drivers/media/video/saa7111.c
@@ -511,22 +511,20 @@ saa7111_detect_client (struct i2c_adapte
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return 0;
 
-	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (client == 0)
 		return -ENOMEM;
-	memset(client, 0, sizeof(struct i2c_client));
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_saa7111;
 	client->flags = I2C_CLIENT_ALLOW_USE;
 	strlcpy(I2C_NAME(client), "saa7111", sizeof(I2C_NAME(client)));
 
-	decoder = kmalloc(sizeof(struct saa7111), GFP_KERNEL);
+	decoder = kzalloc(sizeof(struct saa7111), GFP_KERNEL);
 	if (decoder == NULL) {
 		kfree(client);
 		return -ENOMEM;
 	}
-	memset(decoder, 0, sizeof(struct saa7111));
 	decoder->norm = VIDEO_MODE_NTSC;
 	decoder->input = 0;
 	decoder->enable = 1;
diff --git a/drivers/media/video/saa7114.c b/drivers/media/video/saa7114.c
index d9f50e2..a1b1bcf 100644
--- a/drivers/media/video/saa7114.c
+++ b/drivers/media/video/saa7114.c
@@ -852,22 +852,20 @@ saa7114_detect_client (struct i2c_adapte
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return 0;
 
-	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (client == 0)
 		return -ENOMEM;
-	memset(client, 0, sizeof(struct i2c_client));
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_saa7114;
 	client->flags = I2C_CLIENT_ALLOW_USE;
 	strlcpy(I2C_NAME(client), "saa7114", sizeof(I2C_NAME(client)));
 
-	decoder = kmalloc(sizeof(struct saa7114), GFP_KERNEL);
+	decoder = kzalloc(sizeof(struct saa7114), GFP_KERNEL);
 	if (decoder == NULL) {
 		kfree(client);
 		return -ENOMEM;
 	}
-	memset(decoder, 0, sizeof(struct saa7114));
 	decoder->norm = VIDEO_MODE_NTSC;
 	decoder->input = -1;
 	decoder->enable = 1;
diff --git a/drivers/media/video/saa7115.c b/drivers/media/video/saa7115.c
index e717e30..c163710 100644
--- a/drivers/media/video/saa7115.c
+++ b/drivers/media/video/saa7115.c
@@ -1263,10 +1263,9 @@ static int saa7115_attach(struct i2c_ada
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return 0;
 
-	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (client == 0)
 		return -ENOMEM;
-	memset(client, 0, sizeof(struct i2c_client));
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_saa7115;
@@ -1287,13 +1286,12 @@ static int saa7115_attach(struct i2c_ada
 	}
 	saa7115_info("saa711%d found @ 0x%x (%s)\n", chip_id, address << 1, adapter->name);
 
-	state = kmalloc(sizeof(struct saa7115_state), GFP_KERNEL);
+	state = kzalloc(sizeof(struct saa7115_state), GFP_KERNEL);
 	i2c_set_clientdata(client, state);
 	if (state == NULL) {
 		kfree(client);
 		return -ENOMEM;
 	}
-	memset(state, 0, sizeof(struct saa7115_state));
 	state->std = V4L2_STD_NTSC;
 	state->input = -1;
 	state->enable = 1;
diff --git a/drivers/media/video/saa711x.c b/drivers/media/video/saa711x.c
index 31f7b95..f0f5fb5 100644
--- a/drivers/media/video/saa711x.c
+++ b/drivers/media/video/saa711x.c
@@ -487,21 +487,19 @@ saa711x_detect_client (struct i2c_adapte
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return 0;
 
-	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (client == 0)
 		return -ENOMEM;
-	memset(client, 0, sizeof(struct i2c_client));
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_saa711x;
 	client->flags = I2C_CLIENT_ALLOW_USE;
 	strlcpy(I2C_NAME(client), "saa711x", sizeof(I2C_NAME(client)));
-	decoder = kmalloc(sizeof(struct saa711x), GFP_KERNEL);
+	decoder = kzalloc(sizeof(struct saa711x), GFP_KERNEL);
 	if (decoder == NULL) {
 		kfree(client);
 		return -ENOMEM;
 	}
-	memset(decoder, 0, sizeof(struct saa711x));
 	decoder->norm = VIDEO_MODE_NTSC;
 	decoder->input = 0;
 	decoder->enable = 1;
diff --git a/drivers/media/video/saa7127.c b/drivers/media/video/saa7127.c
index c36f014..3baf9f8 100644
--- a/drivers/media/video/saa7127.c
+++ b/drivers/media/video/saa7127.c
@@ -711,11 +711,10 @@ static int saa7127_attach(struct i2c_ada
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return 0;
 
-	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (client == 0)
 		return -ENOMEM;
 
-	memset(client, 0, sizeof(struct i2c_client));
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_saa7127;
@@ -735,7 +734,7 @@ static int saa7127_attach(struct i2c_ada
 		kfree(client);
 		return 0;
 	}
-	state = kmalloc(sizeof(struct saa7127_state), GFP_KERNEL);
+	state = kzalloc(sizeof(struct saa7127_state), GFP_KERNEL);
 
 	if (state == NULL) {
 		kfree(client);
@@ -743,7 +742,6 @@ static int saa7127_attach(struct i2c_ada
 	}
 
 	i2c_set_clientdata(client, state);
-	memset(state, 0, sizeof(struct saa7127_state));
 
 	/* Configure Encoder */
 
diff --git a/drivers/media/video/saa7134/saa6752hs.c b/drivers/media/video/saa7134/saa6752hs.c
index a61d24f..6e8ed65 100644
--- a/drivers/media/video/saa7134/saa6752hs.c
+++ b/drivers/media/video/saa7134/saa6752hs.c
@@ -511,9 +511,8 @@ static int saa6752hs_attach(struct i2c_a
 
 	printk("saa6752hs: chip found @ 0x%x\n", addr<<1);
 
-	if (NULL == (h = kmalloc(sizeof(*h), GFP_KERNEL)))
+	if (NULL == (h = kzalloc(sizeof(*h), GFP_KERNEL)))
 		return -ENOMEM;
-	memset(h,0,sizeof(*h));
 	h->client = client_template;
 	h->params = param_defaults;
 	h->client.adapter = adap;
diff --git a/drivers/media/video/saa7134/saa7134-core.c b/drivers/media/video/saa7134/saa7134-core.c
index 23d8747..8c175f0 100644
--- a/drivers/media/video/saa7134/saa7134-core.c
+++ b/drivers/media/video/saa7134/saa7134-core.c
@@ -840,10 +840,9 @@ static int __devinit saa7134_initdev(str
 	struct saa7134_mpeg_ops *mops;
 	int err;
 
-	dev = kmalloc(sizeof(*dev),GFP_KERNEL);
+	dev = kzalloc(sizeof(*dev),GFP_KERNEL);
 	if (NULL == dev)
 		return -ENOMEM;
-	memset(dev,0,sizeof(*dev));
 
 	/* pci init */
 	dev->pci = pci_dev;
diff --git a/drivers/media/video/saa7134/saa7134-video.c b/drivers/media/video/saa7134/saa7134-video.c
index 45c852d..191c2de 100644
--- a/drivers/media/video/saa7134/saa7134-video.c
+++ b/drivers/media/video/saa7134/saa7134-video.c
@@ -1263,10 +1263,9 @@ static int video_open(struct inode *inod
 		v4l2_type_names[type]);
 
 	/* allocate + initialize per filehandle data */
-	fh = kmalloc(sizeof(*fh),GFP_KERNEL);
+	fh = kzalloc(sizeof(*fh),GFP_KERNEL);
 	if (NULL == fh)
 		return -ENOMEM;
-	memset(fh,0,sizeof(*fh));
 	file->private_data = fh;
 	fh->dev      = dev;
 	fh->radio    = radio;
diff --git a/drivers/media/video/saa7185.c b/drivers/media/video/saa7185.c
index 132aa79..7ac4adc 100644
--- a/drivers/media/video/saa7185.c
+++ b/drivers/media/video/saa7185.c
@@ -408,22 +408,20 @@ saa7185_detect_client (struct i2c_adapte
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return 0;
 
-	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (client == 0)
 		return -ENOMEM;
-	memset(client, 0, sizeof(struct i2c_client));
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_saa7185;
 	client->flags = I2C_CLIENT_ALLOW_USE;
 	strlcpy(I2C_NAME(client), "saa7185", sizeof(I2C_NAME(client)));
 
-	encoder = kmalloc(sizeof(struct saa7185), GFP_KERNEL);
+	encoder = kzalloc(sizeof(struct saa7185), GFP_KERNEL);
 	if (encoder == NULL) {
 		kfree(client);
 		return -ENOMEM;
 	}
-	memset(encoder, 0, sizeof(struct saa7185));
 	encoder->norm = VIDEO_MODE_NTSC;
 	encoder->enable = 1;
 	i2c_set_clientdata(client, encoder);
diff --git a/drivers/media/video/saa7191.c b/drivers/media/video/saa7191.c
index cbca896..ba4c26e 100644
--- a/drivers/media/video/saa7191.c
+++ b/drivers/media/video/saa7191.c
@@ -571,18 +571,15 @@ static int saa7191_attach(struct i2c_ada
 	printk(KERN_INFO "Philips SAA7191 driver version %s\n",
 	       SAA7191_MODULE_VERSION);
 
-	client = kmalloc(sizeof(*client), GFP_KERNEL);
+	client = kzalloc(sizeof(*client), GFP_KERNEL);
 	if (!client)
 		return -ENOMEM;
-	decoder = kmalloc(sizeof(*decoder), GFP_KERNEL);
+	decoder = kzalloc(sizeof(*decoder), GFP_KERNEL);
 	if (!decoder) {
 		err = -ENOMEM;
 		goto out_free_client;
 	}
 
-	memset(client, 0, sizeof(struct i2c_client));
-	memset(decoder, 0, sizeof(struct saa7191));
-
 	client->addr = addr;
 	client->adapter = adap;
 	client->driver = &i2c_driver_saa7191;
diff --git a/drivers/media/video/stradis.c b/drivers/media/video/stradis.c
index d4497db..fc61f96 100644
--- a/drivers/media/video/stradis.c
+++ b/drivers/media/video/stradis.c
@@ -2135,7 +2135,7 @@ static int init_saa7146(int i)
 			return -ENOMEM;
 		}
 	/* allocate 81920 byte buffer for clipping */
-	if ((saa->dmavid2 = kmalloc(VIDEO_CLIPMAP_SIZE, GFP_KERNEL)) == NULL) {
+	if ((saa->dmavid2 = kzalloc(VIDEO_CLIPMAP_SIZE, GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "stradis%d: clip kmalloc failed\n", saa->nr);
 		vfree(saa->vidbuf);
 		vfree(saa->audbuf);
@@ -2144,7 +2144,6 @@ static int init_saa7146(int i)
 		saa->dmavid2 = NULL;
 		return -1;
 	}
-	memset(saa->dmavid2, 0x00, VIDEO_CLIPMAP_SIZE);	/* clip everything */
 	/* setup clipping registers */
 	saawrite(virt_to_bus(saa->dmavid2), SAA7146_BASE_EVEN2);
 	saawrite(virt_to_bus(saa->dmavid2) + 128, SAA7146_BASE_ODD2);
diff --git a/drivers/media/video/tda7432.c b/drivers/media/video/tda7432.c
index d32737d..d3d15cb 100644
--- a/drivers/media/video/tda7432.c
+++ b/drivers/media/video/tda7432.c
@@ -303,10 +303,9 @@ static int tda7432_attach(struct i2c_ada
 	struct i2c_client *client;
 	d2printk("tda7432: In tda7432_attach\n");
 
-	t = kmalloc(sizeof *t,GFP_KERNEL);
+	t = kzalloc(sizeof *t,GFP_KERNEL);
 	if (!t)
 		return -ENOMEM;
-	memset(t,0,sizeof *t);
 
 	client = &t->c;
 	memcpy(client,&client_template,sizeof(struct i2c_client));
diff --git a/drivers/media/video/tda9875.c b/drivers/media/video/tda9875.c
index a5e37dc..7a00fe2 100644
--- a/drivers/media/video/tda9875.c
+++ b/drivers/media/video/tda9875.c
@@ -232,10 +232,9 @@ static int tda9875_attach(struct i2c_ada
 	struct i2c_client *client;
 	dprintk("In tda9875_attach\n");
 
-	t = kmalloc(sizeof *t,GFP_KERNEL);
+	t = kzalloc(sizeof *t,GFP_KERNEL);
 	if (!t)
 		return -ENOMEM;
-	memset(t,0,sizeof *t);
 
 	client = &t->c;
 	memcpy(client,&client_template,sizeof(struct i2c_client));
diff --git a/drivers/media/video/tda9887.c b/drivers/media/video/tda9887.c
index 2f2414e..115dceb 100644
--- a/drivers/media/video/tda9887.c
+++ b/drivers/media/video/tda9887.c
@@ -619,9 +619,8 @@ static int tda9887_attach(struct i2c_ada
 	client_template.adapter = adap;
 	client_template.addr    = addr;
 
-	if (NULL == (t = kmalloc(sizeof(*t), GFP_KERNEL)))
+	if (NULL == (t = kzalloc(sizeof(*t), GFP_KERNEL)))
 		return -ENOMEM;
-	memset(t,0,sizeof(*t));
 
 	t->client      = client_template;
 	t->std         = 0;
diff --git a/drivers/media/video/tea6420.c b/drivers/media/video/tea6420.c
index 17975c1..7c63214 100644
--- a/drivers/media/video/tea6420.c
+++ b/drivers/media/video/tea6420.c
@@ -99,11 +99,10 @@ static int tea6420_detect(struct i2c_ada
 	}
 
 	/* allocate memory for client structure */
-	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (0 == client) {
 		return -ENOMEM;
 	}
-	memset(client, 0x0, sizeof(struct i2c_client));
 
 	/* fill client structure */
 	memcpy(client, &client_template, sizeof(struct i2c_client));
diff --git a/drivers/media/video/tuner-core.c b/drivers/media/video/tuner-core.c
index e58abdf..38492e2 100644
--- a/drivers/media/video/tuner-core.c
+++ b/drivers/media/video/tuner-core.c
@@ -342,10 +342,9 @@ static int tuner_attach(struct i2c_adapt
 	client_template.adapter = adap;
 	client_template.addr = addr;
 
-	t = kmalloc(sizeof(struct tuner), GFP_KERNEL);
+	t = kzalloc(sizeof(struct tuner), GFP_KERNEL);
 	if (NULL == t)
 		return -ENOMEM;
-	memset(t, 0, sizeof(struct tuner));
 	memcpy(&t->i2c, &client_template, sizeof(struct i2c_client));
 	i2c_set_clientdata(&t->i2c, t);
 	t->type = UNSET;
diff --git a/drivers/media/video/tvaudio.c b/drivers/media/video/tvaudio.c
index 5b20e81..f291524 100644
--- a/drivers/media/video/tvaudio.c
+++ b/drivers/media/video/tvaudio.c
@@ -1480,10 +1480,9 @@ static int chip_attach(struct i2c_adapte
 	struct CHIPSTATE *chip;
 	struct CHIPDESC  *desc;
 
-	chip = kmalloc(sizeof(*chip),GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip),GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
-	memset(chip,0,sizeof(*chip));
 	memcpy(&chip->c,&client_template,sizeof(struct i2c_client));
 	chip->c.adapter = adap;
 	chip->c.addr = addr;
diff --git a/drivers/media/video/tveeprom.c b/drivers/media/video/tveeprom.c
index 5ac2353..2601b38 100644
--- a/drivers/media/video/tveeprom.c
+++ b/drivers/media/video/tveeprom.c
@@ -720,8 +720,7 @@ tveeprom_command(struct i2c_client *clie
 
 	switch (cmd) {
 	case 0:
-		buf = kmalloc(256,GFP_KERNEL);
-		memset(buf,0,256);
+		buf = kzalloc(256,GFP_KERNEL);
 		tveeprom_read(client,buf,256);
 		tveeprom_hauppauge_analog(client, &eeprom,buf);
 		kfree(buf);
@@ -744,10 +743,9 @@ tveeprom_detect_client(struct i2c_adapte
 {
 	struct i2c_client *client;
 
-	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (NULL == client)
 		return -ENOMEM;
-	memset(client, 0, sizeof(struct i2c_client));
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_tveeprom;
diff --git a/drivers/media/video/tvp5150.c b/drivers/media/video/tvp5150.c
index 97431e2..6654987 100644
--- a/drivers/media/video/tvp5150.c
+++ b/drivers/media/video/tvp5150.c
@@ -744,12 +744,11 @@ static int tvp5150_detect_client(struct 
 		return -ENOMEM;
 	memcpy(client, &client_template, sizeof(struct i2c_client));
 
-	core = kmalloc(sizeof(struct tvp5150), GFP_KERNEL);
+	core = kzalloc(sizeof(struct tvp5150), GFP_KERNEL);
 	if (core == 0) {
 		kfree(client);
 		return -ENOMEM;
 	}
-	memset(core, 0, sizeof(struct tvp5150));
 	i2c_set_clientdata(client, core);
 
 	rv = i2c_attach_client(client);
diff --git a/drivers/media/video/v4l1-compat.c b/drivers/media/video/v4l1-compat.c
index 4134549..8e485b0 100644
--- a/drivers/media/video/v4l1-compat.c
+++ b/drivers/media/video/v4l1-compat.c
@@ -305,9 +305,8 @@ v4l_compat_translate_ioctl(struct inode 
 	{
 		struct video_capability *cap = arg;
 
-		cap2 = kmalloc(sizeof(*cap2),GFP_KERNEL);
+		cap2 = kzalloc(sizeof(*cap2),GFP_KERNEL);
 		memset(cap, 0, sizeof(*cap));
-		memset(cap2, 0, sizeof(*cap2));
 		memset(&fbuf2, 0, sizeof(fbuf2));
 
 		err = drv(inode, file, VIDIOC_QUERYCAP, cap2);
@@ -422,9 +421,8 @@ v4l_compat_translate_ioctl(struct inode 
 	{
 		struct video_window	*win = arg;
 
-		fmt2 = kmalloc(sizeof(*fmt2),GFP_KERNEL);
+		fmt2 = kzalloc(sizeof(*fmt2),GFP_KERNEL);
 		memset(win,0,sizeof(*win));
-		memset(fmt2,0,sizeof(*fmt2));
 
 		fmt2->type = V4L2_BUF_TYPE_VIDEO_OVERLAY;
 		err = drv(inode, file, VIDIOC_G_FMT, fmt2);
@@ -461,8 +459,7 @@ v4l_compat_translate_ioctl(struct inode 
 		struct video_window	*win = arg;
 		int err1,err2;
 
-		fmt2 = kmalloc(sizeof(*fmt2),GFP_KERNEL);
-		memset(fmt2,0,sizeof(*fmt2));
+		fmt2 = kzalloc(sizeof(*fmt2),GFP_KERNEL);
 		fmt2->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 		drv(inode, file, VIDIOC_STREAMOFF, &fmt2->type);
 		err1 = drv(inode, file, VIDIOC_G_FMT, fmt2);
@@ -595,8 +592,7 @@ v4l_compat_translate_ioctl(struct inode 
 		pict->whiteness = get_v4l_control(inode, file,
 						  V4L2_CID_WHITENESS, drv);
 
-		fmt2 = kmalloc(sizeof(*fmt2),GFP_KERNEL);
-		memset(fmt2,0,sizeof(*fmt2));
+		fmt2 = kzalloc(sizeof(*fmt2),GFP_KERNEL);
 		fmt2->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 		err = drv(inode, file, VIDIOC_G_FMT, fmt2);
 		if (err < 0) {
@@ -622,8 +618,7 @@ v4l_compat_translate_ioctl(struct inode 
 		set_v4l_control(inode, file,
 				V4L2_CID_WHITENESS, pict->whiteness, drv);
 
-		fmt2 = kmalloc(sizeof(*fmt2),GFP_KERNEL);
-		memset(fmt2,0,sizeof(*fmt2));
+		fmt2 = kzalloc(sizeof(*fmt2),GFP_KERNEL);
 		fmt2->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 		err = drv(inode, file, VIDIOC_G_FMT, fmt2);
 		if (err < 0)
@@ -846,9 +841,8 @@ v4l_compat_translate_ioctl(struct inode 
 	{
 		struct video_mmap	*mm = arg;
 
-		fmt2 = kmalloc(sizeof(*fmt2),GFP_KERNEL);
+		fmt2 = kzalloc(sizeof(*fmt2),GFP_KERNEL);
 		memset(&buf2,0,sizeof(buf2));
-		memset(fmt2,0,sizeof(*fmt2));
 
 		fmt2->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 		err = drv(inode, file, VIDIOC_G_FMT, fmt2);
@@ -942,8 +936,7 @@ v4l_compat_translate_ioctl(struct inode 
 	{
 		struct vbi_format      *fmt = arg;
 
-		fmt2 = kmalloc(sizeof(*fmt2),GFP_KERNEL);
-		memset(fmt2, 0, sizeof(*fmt2));
+		fmt2 = kzalloc(sizeof(*fmt2),GFP_KERNEL);
 		fmt2->type = V4L2_BUF_TYPE_VBI_CAPTURE;
 
 		err = drv(inode, file, VIDIOC_G_FMT, fmt2);
@@ -966,8 +959,7 @@ v4l_compat_translate_ioctl(struct inode 
 	{
 		struct vbi_format      *fmt = arg;
 
-		fmt2 = kmalloc(sizeof(*fmt2),GFP_KERNEL);
-		memset(fmt2, 0, sizeof(*fmt2));
+		fmt2 = kzalloc(sizeof(*fmt2),GFP_KERNEL);
 
 		fmt2->type = V4L2_BUF_TYPE_VBI_CAPTURE;
 		fmt2->fmt.vbi.samples_per_line = fmt->samples_per_line;
diff --git a/drivers/media/video/video-buf.c b/drivers/media/video/video-buf.c
index 9a6bf28..33434bb 100644
--- a/drivers/media/video/video-buf.c
+++ b/drivers/media/video/video-buf.c
@@ -52,10 +52,9 @@ videobuf_vmalloc_to_sg(unsigned char *vi
 	struct page *pg;
 	int i;
 
-	sglist = kmalloc(sizeof(struct scatterlist)*nr_pages, GFP_KERNEL);
+	sglist = kzalloc(sizeof(struct scatterlist)*nr_pages, GFP_KERNEL);
 	if (NULL == sglist)
 		return NULL;
-	memset(sglist,0,sizeof(struct scatterlist)*nr_pages);
 	for (i = 0; i < nr_pages; i++, virt += PAGE_SIZE) {
 		pg = vmalloc_to_page(virt);
 		if (NULL == pg)
@@ -80,10 +79,9 @@ videobuf_pages_to_sg(struct page **pages
 
 	if (NULL == pages[0])
 		return NULL;
-	sglist = kmalloc(sizeof(*sglist) * nr_pages, GFP_KERNEL);
+	sglist = kzalloc(sizeof(*sglist) * nr_pages, GFP_KERNEL);
 	if (NULL == sglist)
 		return NULL;
-	memset(sglist, 0, sizeof(*sglist) * nr_pages);
 
 	if (NULL == pages[0])
 		goto nopage;
@@ -284,9 +282,8 @@ void* videobuf_alloc(unsigned int size)
 {
 	struct videobuf_buffer *vb;
 
-	vb = kmalloc(size,GFP_KERNEL);
+	vb = kzalloc(size,GFP_KERNEL);
 	if (NULL != vb) {
-		memset(vb,0,size);
 		videobuf_dma_init(&vb->dma);
 		init_waitqueue_head(&vb->done);
 		vb->magic     = MAGIC_BUFFER;
diff --git a/drivers/media/video/videocodec.c b/drivers/media/video/videocodec.c
index 839db62..8f271de 100644
--- a/drivers/media/video/videocodec.c
+++ b/drivers/media/video/videocodec.c
@@ -124,17 +124,13 @@ videocodec_attach (struct videocodec_mas
 			if (res == 0) {
 				dprintk(3, "videocodec_attach '%s'\n",
 					codec->name);
-				ptr = (struct attached_list *)
-				    kmalloc(sizeof(struct attached_list),
-					    GFP_KERNEL);
+				ptr = kzalloc(sizeof(struct attached_list), GFP_KERNEL);
 				if (!ptr) {
 					dprintk(1,
 						KERN_ERR
 						"videocodec_attach: no memory\n");
 					goto out_kfree;
 				}
-				memset(ptr, 0,
-				       sizeof(struct attached_list));
 				ptr->codec = codec;
 
 				a = h->list;
@@ -249,14 +245,11 @@ videocodec_register (const struct videoc
 		"videocodec: register '%s', type: %x, flags %lx, magic %lx\n",
 		codec->name, codec->type, codec->flags, codec->magic);
 
-	ptr =
-	    (struct codec_list *) kmalloc(sizeof(struct codec_list),
-					  GFP_KERNEL);
+	ptr = kzalloc(sizeof(struct codec_list), GFP_KERNEL);
 	if (!ptr) {
 		dprintk(1, KERN_ERR "videocodec_register: no memory\n");
 		return -ENOMEM;
 	}
-	memset(ptr, 0, sizeof(struct codec_list));
 	ptr->codec = codec;
 
 	if (!h) {
diff --git a/drivers/media/video/videodev.c b/drivers/media/video/videodev.c
index 6de5b00..7df0026 100644
--- a/drivers/media/video/videodev.c
+++ b/drivers/media/video/videodev.c
@@ -52,10 +52,7 @@ struct video_device *video_device_alloc(
 {
 	struct video_device *vfd;
 
-	vfd = kmalloc(sizeof(*vfd),GFP_KERNEL);
-	if (NULL == vfd)
-		return NULL;
-	memset(vfd,0,sizeof(*vfd));
+	vfd = kzalloc(sizeof(*vfd),GFP_KERNEL);
 	return vfd;
 }
 
diff --git a/drivers/media/video/vino.c b/drivers/media/video/vino.c
index 71b28e9..c8fd823 100644
--- a/drivers/media/video/vino.c
+++ b/drivers/media/video/vino.c
@@ -4499,13 +4499,11 @@ static int vino_init(void)
 	dma_addr_t dma_dummy_address;
 	int i;
 
-	vino_drvdata = (struct vino_settings *)
-		kmalloc(sizeof(struct vino_settings), GFP_KERNEL);
+	vino_drvdata = kzalloc(sizeof(struct vino_settings), GFP_KERNEL);
 	if (!vino_drvdata) {
 		vino_module_cleanup(vino_init_stage);
 		return -ENOMEM;
 	}
-	memset(vino_drvdata, 0, sizeof(struct vino_settings));
 	vino_init_stage++;
 
 	/* create a dummy dma descriptor */
diff --git a/drivers/media/video/vpx3220.c b/drivers/media/video/vpx3220.c
index 137b58f..9f69953 100644
--- a/drivers/media/video/vpx3220.c
+++ b/drivers/media/video/vpx3220.c
@@ -621,13 +621,11 @@ vpx3220_detect_client (struct i2c_adapte
 	    (adapter, I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
 		return 0;
 
-	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (client == NULL) {
 		return -ENOMEM;
 	}
 
-	memset(client, 0, sizeof(struct i2c_client));
-
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &vpx3220_i2c_driver;
@@ -676,12 +674,11 @@ vpx3220_detect_client (struct i2c_adapte
 			sizeof(I2C_NAME(client)));
 	}
 
-	decoder = kmalloc(sizeof(struct vpx3220), GFP_KERNEL);
+	decoder = kzalloc(sizeof(struct vpx3220), GFP_KERNEL);
 	if (decoder == NULL) {
 		kfree(client);
 		return -ENOMEM;
 	}
-	memset(decoder, 0, sizeof(struct vpx3220));
 	decoder->norm = VIDEO_MODE_PAL;
 	decoder->input = 0;
 	decoder->enable = 1;
diff --git a/drivers/media/video/wm8775.c b/drivers/media/video/wm8775.c
index a6936ad..04f7bf2 100644
--- a/drivers/media/video/wm8775.c
+++ b/drivers/media/video/wm8775.c
@@ -160,11 +160,10 @@ static int wm8775_attach(struct i2c_adap
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return 0;
 
-	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (client == 0)
 		return -ENOMEM;
 
-	memset(client, 0, sizeof(struct i2c_client));
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver;
diff --git a/drivers/media/video/zoran_card.c b/drivers/media/video/zoran_card.c
index 39a0d23..ea32886 100644
--- a/drivers/media/video/zoran_card.c
+++ b/drivers/media/video/zoran_card.c
@@ -1050,7 +1050,7 @@ zr36057_init (struct zoran *zr)
 	/* allocate memory *before* doing anything to the hardware
 	 * in case allocation fails */
 	mem_needed = BUZ_NUM_STAT_COM * 4;
-	mem = (unsigned long) kmalloc(mem_needed, GFP_KERNEL);
+	mem = kzalloc(mem_needed, GFP_KERNEL);
 	vdev = (void *) kmalloc(sizeof(struct video_device), GFP_KERNEL);
 	if (!mem || !vdev) {
 		dprintk(1,
@@ -1061,7 +1061,6 @@ zr36057_init (struct zoran *zr)
 		kfree((void *)mem);
 		return -ENOMEM;
 	}
-	memset((void *) mem, 0, mem_needed);
 	zr->stat_com = (u32 *) mem;
 	for (j = 0; j < BUZ_NUM_STAT_COM; j++) {
 		zr->stat_com[j] = 1;	/* mark as unavailable to zr36057 */
diff --git a/drivers/media/video/zoran_driver.c b/drivers/media/video/zoran_driver.c
index 07bde9a..de5dc48 100644
--- a/drivers/media/video/zoran_driver.c
+++ b/drivers/media/video/zoran_driver.c
@@ -1345,7 +1345,7 @@ zoran_open (struct inode *inode,
 		ZR_DEVNAME(zr), current->comm, current->pid, zr->user);
 
 	/* now, create the open()-specific file_ops struct */
-	fh = kmalloc(sizeof(struct zoran_fh), GFP_KERNEL);
+	fh = kzalloc(sizeof(struct zoran_fh), GFP_KERNEL);
 	if (!fh) {
 		dprintk(1,
 			KERN_ERR
@@ -1354,7 +1354,6 @@ zoran_open (struct inode *inode,
 		res = -ENOMEM;
 		goto open_unlock_and_return;
 	}
-	memset(fh, 0, sizeof(struct zoran_fh));
 	/* used to be BUZ_MAX_WIDTH/HEIGHT, but that gives overflows
 	 * on norm-change! */
 	fh->overlay_mask =
diff --git a/drivers/media/video/zr36016.c b/drivers/media/video/zr36016.c
index 4ed8985..10130ef 100644
--- a/drivers/media/video/zr36016.c
+++ b/drivers/media/video/zr36016.c
@@ -451,12 +451,11 @@ zr36016_setup (struct videocodec *codec)
 		return -ENOSPC;
 	}
 	//mem structure init
-	codec->data = ptr = kmalloc(sizeof(struct zr36016), GFP_KERNEL);
+	codec->data = ptr = kzalloc(sizeof(struct zr36016), GFP_KERNEL);
 	if (NULL == ptr) {
 		dprintk(1, KERN_ERR "zr36016: Can't get enough memory!\n");
 		return -ENOMEM;
 	}
-	memset(ptr, 0, sizeof(struct zr36016));
 
 	snprintf(ptr->name, sizeof(ptr->name), "zr36016[%d]",
 		 zr36016_codecs);
diff --git a/drivers/media/video/zr36050.c b/drivers/media/video/zr36050.c
index 0144576..bd0cd28 100644
--- a/drivers/media/video/zr36050.c
+++ b/drivers/media/video/zr36050.c
@@ -813,12 +813,11 @@ zr36050_setup (struct videocodec *codec)
 		return -ENOSPC;
 	}
 	//mem structure init
-	codec->data = ptr = kmalloc(sizeof(struct zr36050), GFP_KERNEL);
+	codec->data = ptr = kzalloc(sizeof(struct zr36050), GFP_KERNEL);
 	if (NULL == ptr) {
 		dprintk(1, KERN_ERR "zr36050: Can't get enough memory!\n");
 		return -ENOMEM;
 	}
-	memset(ptr, 0, sizeof(struct zr36050));
 
 	snprintf(ptr->name, sizeof(ptr->name), "zr36050[%d]",
 		 zr36050_codecs);
diff --git a/drivers/media/video/zr36060.c b/drivers/media/video/zr36060.c
index 129744a..28fa31a 100644
--- a/drivers/media/video/zr36060.c
+++ b/drivers/media/video/zr36060.c
@@ -919,12 +919,11 @@ zr36060_setup (struct videocodec *codec)
 		return -ENOSPC;
 	}
 	//mem structure init
-	codec->data = ptr = kmalloc(sizeof(struct zr36060), GFP_KERNEL);
+	codec->data = ptr = kzalloc(sizeof(struct zr36060), GFP_KERNEL);
 	if (NULL == ptr) {
 		dprintk(1, KERN_ERR "zr36060: Can't get enough memory!\n");
 		return -ENOMEM;
 	}
-	memset(ptr, 0, sizeof(struct zr36060));
 
 	snprintf(ptr->name, sizeof(ptr->name), "zr36060[%d]",
 		 zr36060_codecs);
-- 
0.99.9b-g58e3
