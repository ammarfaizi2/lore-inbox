Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965667AbWCTP6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965667AbWCTP6v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965662AbWCTP6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:58:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:55192 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966540AbWCTPSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:18:01 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 024/141] V4L/DVB (3423): CodingStyle fixes.
Date: Mon, 20 Mar 2006 12:08:41 -0300
Message-id: <20060320150841.PS024584000024@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab@infradead.org>
Date: 1138043469 -0200

- CodingStyle fixes.

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/em28xx/em28xx-video.c b/drivers/media/video/em28xx/em28xx-video.c
diff --git a/drivers/media/video/em28xx/em28xx-video.c b/drivers/media/video/em28xx/em28xx-video.c
index d8d02c4..1b0e10d 100644
--- a/drivers/media/video/em28xx/em28xx-video.c
+++ b/drivers/media/video/em28xx/em28xx-video.c
@@ -1012,19 +1012,15 @@ static int em28xx_set_fmt(struct em28xx 
 			width /= 2;
 	}
 
-	if ((hscale =
-	(((unsigned long)maxw) << 12) / width - 4096L) >=
-	0x4000)
+	if ((hscale = (((unsigned long)maxw) << 12) / width - 4096L) >= 0x4000)
 		hscale = 0x3fff;
-	width =
-	(((unsigned long)maxw) << 12) / (hscale + 4096L);
 
-	if ((vscale =
-	(((unsigned long)maxh) << 12) / height - 4096L) >=
-	0x4000)
+	width = (((unsigned long)maxw) << 12) / (hscale + 4096L);
+
+	if ((vscale = (((unsigned long)maxh) << 12) / height - 4096L) >= 0x4000)
 		vscale = 0x3fff;
-	height =
-	(((unsigned long)maxh) << 12) / (vscale + 4096L);
+
+	height = (((unsigned long)maxh) << 12) / (vscale + 4096L);
 
 	format->fmt.pix.width = width;
 	format->fmt.pix.height = height;
@@ -1035,10 +1031,9 @@ static int em28xx_set_fmt(struct em28xx 
 	format->fmt.pix.field = V4L2_FIELD_INTERLACED;
 
 	em28xx_videodbg("%s: returned %dx%d (%d, %d)\n",
-		cmd ==
-		VIDIOC_TRY_FMT ? "VIDIOC_TRY_FMT" :
-		"VIDIOC_S_FMT", format->fmt.pix.width,
-		format->fmt.pix.height, hscale, vscale);
+		cmd == VIDIOC_TRY_FMT ?
+		"VIDIOC_TRY_FMT" :"VIDIOC_S_FMT",
+		format->fmt.pix.width, format->fmt.pix.height, hscale, vscale);
 
 	if (cmd == VIDIOC_TRY_FMT)
 		return 0;
@@ -1064,7 +1059,7 @@ static int em28xx_set_fmt(struct em28xx 
 	dev->width = width;
 	dev->height = height;
 	dev->frame_size = dev->width * dev->height * 2;
-	dev->field_size = dev->frame_size >> 1;	/*both_fileds ? dev->frame_size>>1 : dev->frame_size; */
+	dev->field_size = dev->frame_size >> 1;
 	dev->bytesperline = dev->width * 2;
 	dev->hscale = hscale;
 	dev->vscale = vscale;
@@ -1092,374 +1087,367 @@ static int em28xx_do_ioctl(struct inode 
 	switch (cmd) {
 		/* ---------- tv norms ---------- */
 	case VIDIOC_ENUMSTD:
-		{
-			struct v4l2_standard *e = arg;
-			unsigned int i;
+	{
+		struct v4l2_standard *e = arg;
+		unsigned int i;
 
-			i = e->index;
-			if (i >= TVNORMS)
-				return -EINVAL;
-			ret = v4l2_video_std_construct(e, tvnorms[e->index].id,
-						       tvnorms[e->index].name);
-			e->index = i;
-			if (ret < 0)
-				return ret;
-			return 0;
-		}
+		i = e->index;
+		if (i >= TVNORMS)
+			return -EINVAL;
+		ret = v4l2_video_std_construct(e, tvnorms[e->index].id,
+						tvnorms[e->index].name);
+		e->index = i;
+		if (ret < 0)
+			return ret;
+		return 0;
+	}
 	case VIDIOC_G_STD:
-		{
-			v4l2_std_id *id = arg;
+	{
+		v4l2_std_id *id = arg;
 
-			*id = dev->tvnorm->id;
-			return 0;
-		}
+		*id = dev->tvnorm->id;
+		return 0;
+	}
 	case VIDIOC_S_STD:
-		{
-			v4l2_std_id *id = arg;
-			unsigned int i;
-
+	{
+		v4l2_std_id *id = arg;
+		unsigned int i;
+
+		for (i = 0; i < TVNORMS; i++)
+			if (*id == tvnorms[i].id)
+				break;
+		if (i == TVNORMS)
 			for (i = 0; i < TVNORMS; i++)
-				if (*id == tvnorms[i].id)
+				if (*id & tvnorms[i].id)
 					break;
-			if (i == TVNORMS)
-				for (i = 0; i < TVNORMS; i++)
-					if (*id & tvnorms[i].id)
-						break;
-			if (i == TVNORMS)
-				return -EINVAL;
+		if (i == TVNORMS)
+			return -EINVAL;
 
-			down(&dev->lock);
-			dev->tvnorm = &tvnorms[i];
+		down(&dev->lock);
+		dev->tvnorm = &tvnorms[i];
 
-			em28xx_set_norm(dev, dev->width, dev->height);
+		em28xx_set_norm(dev, dev->width, dev->height);
 
-			em28xx_i2c_call_clients(dev, DECODER_SET_NORM,
-						&tvnorms[i].mode);
-			em28xx_i2c_call_clients(dev, VIDIOC_S_STD,
-						&dev->tvnorm->id);
+		em28xx_i2c_call_clients(dev, DECODER_SET_NORM,
+					&tvnorms[i].mode);
+		em28xx_i2c_call_clients(dev, VIDIOC_S_STD,
+					&dev->tvnorm->id);
 
-			up(&dev->lock);
+		up(&dev->lock);
 
-			return 0;
-		}
+		return 0;
+	}
 
-		/* ------ input switching ---------- */
+	/* ------ input switching ---------- */
 	case VIDIOC_ENUMINPUT:
-		{
-			struct v4l2_input *i = arg;
-			unsigned int n;
-			static const char *iname[] = {
-				[EM28XX_VMUX_COMPOSITE1] = "Composite1",
-				[EM28XX_VMUX_COMPOSITE2] = "Composite2",
-				[EM28XX_VMUX_COMPOSITE3] = "Composite3",
-				[EM28XX_VMUX_COMPOSITE4] = "Composite4",
-				[EM28XX_VMUX_SVIDEO] = "S-Video",
-				[EM28XX_VMUX_TELEVISION] = "Television",
-				[EM28XX_VMUX_CABLE] = "Cable TV",
-				[EM28XX_VMUX_DVB] = "DVB",
-				[EM28XX_VMUX_DEBUG] = "for debug only",
-			};
-
-			n = i->index;
-			if (n >= MAX_EM28XX_INPUT)
-				return -EINVAL;
-			if (0 == INPUT(n)->type)
-				return -EINVAL;
-			memset(i, 0, sizeof(*i));
-			i->index = n;
-			i->type = V4L2_INPUT_TYPE_CAMERA;
-			strcpy(i->name, iname[INPUT(n)->type]);
-			if ((EM28XX_VMUX_TELEVISION == INPUT(n)->type) ||
-			    (EM28XX_VMUX_CABLE == INPUT(n)->type))
-				i->type = V4L2_INPUT_TYPE_TUNER;
-			for (n = 0; n < ARRAY_SIZE(tvnorms); n++)
-				i->std |= tvnorms[n].id;
-			return 0;
-		}
+	{
+		struct v4l2_input *i = arg;
+		unsigned int n;
+		static const char *iname[] = {
+			[EM28XX_VMUX_COMPOSITE1] = "Composite1",
+			[EM28XX_VMUX_COMPOSITE2] = "Composite2",
+			[EM28XX_VMUX_COMPOSITE3] = "Composite3",
+			[EM28XX_VMUX_COMPOSITE4] = "Composite4",
+			[EM28XX_VMUX_SVIDEO] = "S-Video",
+			[EM28XX_VMUX_TELEVISION] = "Television",
+			[EM28XX_VMUX_CABLE] = "Cable TV",
+			[EM28XX_VMUX_DVB] = "DVB",
+			[EM28XX_VMUX_DEBUG] = "for debug only",
+		};
 
+		n = i->index;
+		if (n >= MAX_EM28XX_INPUT)
+			return -EINVAL;
+		if (0 == INPUT(n)->type)
+			return -EINVAL;
+		memset(i, 0, sizeof(*i));
+		i->index = n;
+		i->type = V4L2_INPUT_TYPE_CAMERA;
+		strcpy(i->name, iname[INPUT(n)->type]);
+		if ((EM28XX_VMUX_TELEVISION == INPUT(n)->type) ||
+			(EM28XX_VMUX_CABLE == INPUT(n)->type))
+			i->type = V4L2_INPUT_TYPE_TUNER;
+		for (n = 0; n < ARRAY_SIZE(tvnorms); n++)
+			i->std |= tvnorms[n].id;
+		return 0;
+	}
 	case VIDIOC_G_INPUT:
-		{
-			int *i = arg;
-			*i = dev->ctl_input;
-
-			return 0;
-		}
+	{
+		int *i = arg;
+		*i = dev->ctl_input;
 
+		return 0;
+	}
 	case VIDIOC_S_INPUT:
-		{
-			int *index = arg;
-
-			if (*index >= MAX_EM28XX_INPUT)
-				return -EINVAL;
-			if (0 == INPUT(*index)->type)
-				return -EINVAL;
+	{
+		int *index = arg;
 
-			down(&dev->lock);
-			video_mux(dev, *index);
-			up(&dev->lock);
+		if (*index >= MAX_EM28XX_INPUT)
+			return -EINVAL;
+		if (0 == INPUT(*index)->type)
+			return -EINVAL;
 
-			return 0;
-		}
+		down(&dev->lock);
+		video_mux(dev, *index);
+		up(&dev->lock);
 
+		return 0;
+	}
 	case VIDIOC_G_AUDIO:
-		{
-			struct v4l2_audio *a = arg;
-			unsigned int index = a->index;
+	{
+		struct v4l2_audio *a = arg;
+		unsigned int index = a->index;
 
-			if (a->index > 1)
-				return -EINVAL;
-			memset(a, 0, sizeof(*a));
-			index = dev->ctl_ainput;
+		if (a->index > 1)
+			return -EINVAL;
+		memset(a, 0, sizeof(*a));
+		index = dev->ctl_ainput;
 
-			if (index == 0) {
-				strcpy(a->name, "Television");
-			} else {
-				strcpy(a->name, "Line In");
-			}
-			a->capability = V4L2_AUDCAP_STEREO;
-			a->index = index;
-			return 0;
+		if (index == 0) {
+			strcpy(a->name, "Television");
+		} else {
+			strcpy(a->name, "Line In");
 		}
-
+		a->capability = V4L2_AUDCAP_STEREO;
+		a->index = index;
+		return 0;
+	}
 	case VIDIOC_S_AUDIO:
-		{
-			struct v4l2_audio *a = arg;
-			if (a->index != dev->ctl_ainput)
-				return -EINVAL;
-
-			return 0;
-		}
+	{
+		struct v4l2_audio *a = arg;
 
-		/* --- controls ---------------------------------------------- */
-	case VIDIOC_QUERYCTRL:
-		{
-			struct v4l2_queryctrl *qc = arg;
-			int i, id=qc->id;
+		if (a->index != dev->ctl_ainput)
+			return -EINVAL;
 
-			memset(qc,0,sizeof(*qc));
-			qc->id=id;
+		return 0;
+	}
 
-			if (!dev->has_msp34xx) {
-				for (i = 0; i < ARRAY_SIZE(em28xx_qctrl); i++) {
-					if (qc->id && qc->id == em28xx_qctrl[i].id) {
-						memcpy(qc, &(em28xx_qctrl[i]),
-						sizeof(*qc));
-						return 0;
-					}
-				}
-			}
-			if (dev->decoder == EM28XX_TVP5150) {
-				em28xx_i2c_call_clients(dev,cmd,qc);
-				if (qc->type)
-					return 0;
-				else
-					return -EINVAL;
-			}
-			for (i = 0; i < ARRAY_SIZE(saa711x_qctrl); i++) {
-				if (qc->id && qc->id == saa711x_qctrl[i].id) {
-					memcpy(qc, &(saa711x_qctrl[i]),
-					       sizeof(*qc));
+	/* --- controls ---------------------------------------------- */
+	case VIDIOC_QUERYCTRL:
+	{
+		struct v4l2_queryctrl *qc = arg;
+		int i, id=qc->id;
+
+		memset(qc,0,sizeof(*qc));
+		qc->id=id;
+
+		if (!dev->has_msp34xx) {
+			for (i = 0; i < ARRAY_SIZE(em28xx_qctrl); i++) {
+				if (qc->id && qc->id == em28xx_qctrl[i].id) {
+					memcpy(qc, &(em28xx_qctrl[i]),
+					sizeof(*qc));
 					return 0;
 				}
 			}
-
-			return -EINVAL;
+		}
+		if (dev->decoder == EM28XX_TVP5150) {
+			em28xx_i2c_call_clients(dev,cmd,qc);
+			if (qc->type)
+				return 0;
+			else
+				return -EINVAL;
+		}
+		for (i = 0; i < ARRAY_SIZE(saa711x_qctrl); i++) {
+			if (qc->id && qc->id == saa711x_qctrl[i].id) {
+				memcpy(qc, &(saa711x_qctrl[i]),
+					sizeof(*qc));
+				return 0;
+			}
 		}
 
+		return -EINVAL;
+	}
 	case VIDIOC_G_CTRL:
-		{
-			struct v4l2_control *ctrl = arg;
-			int retval=-EINVAL;
-
-			if (!dev->has_msp34xx)
-				retval=em28xx_get_ctrl(dev, ctrl);
-			if (retval==-EINVAL) {
-				if (dev->decoder == EM28XX_TVP5150) {
-					em28xx_i2c_call_clients(dev,cmd,arg);
-					return 0;
-				}
-
-				return saa711x_get_ctrl(dev, ctrl);
-			} else return retval;
-		}
+	{
+		struct v4l2_control *ctrl = arg;
+		int retval=-EINVAL;
+
+		if (!dev->has_msp34xx)
+			retval=em28xx_get_ctrl(dev, ctrl);
+		if (retval==-EINVAL) {
+			if (dev->decoder == EM28XX_TVP5150) {
+				em28xx_i2c_call_clients(dev,cmd,arg);
+				return 0;
+			}
 
+			return saa711x_get_ctrl(dev, ctrl);
+		} else return retval;
+	}
 	case VIDIOC_S_CTRL:
-		{
-			struct v4l2_control *ctrl = arg;
-			u8 i;
-
-			if (!dev->has_msp34xx){
-				for (i = 0; i < ARRAY_SIZE(em28xx_qctrl); i++) {
-					if (ctrl->id == em28xx_qctrl[i].id) {
-						if (ctrl->value <
-						em28xx_qctrl[i].minimum
-						|| ctrl->value >
-						em28xx_qctrl[i].maximum)
-							return -ERANGE;
-						return em28xx_set_ctrl(dev, ctrl);
-					}
+	{
+		struct v4l2_control *ctrl = arg;
+		u8 i;
+
+		if (!dev->has_msp34xx){
+			for (i = 0; i < ARRAY_SIZE(em28xx_qctrl); i++) {
+				if (ctrl->id == em28xx_qctrl[i].id) {
+					if (ctrl->value <
+					em28xx_qctrl[i].minimum
+					|| ctrl->value >
+					em28xx_qctrl[i].maximum)
+						return -ERANGE;
+					return em28xx_set_ctrl(dev, ctrl);
 				}
 			}
+		}
 
-			if (dev->decoder == EM28XX_TVP5150) {
-				em28xx_i2c_call_clients(dev,cmd,arg);
-				return 0;
-			} else if (!dev->has_msp34xx) {
-				for (i = 0; i < ARRAY_SIZE(em28xx_qctrl); i++) {
-					if (ctrl->id == em28xx_qctrl[i].id) {
-						if (ctrl->value <
-						em28xx_qctrl[i].minimum
-						|| ctrl->value >
-						em28xx_qctrl[i].maximum)
-							return -ERANGE;
-						return em28xx_set_ctrl(dev, ctrl);
-					}
+		if (dev->decoder == EM28XX_TVP5150) {
+			em28xx_i2c_call_clients(dev,cmd,arg);
+			return 0;
+		} else if (!dev->has_msp34xx) {
+			for (i = 0; i < ARRAY_SIZE(em28xx_qctrl); i++) {
+				if (ctrl->id == em28xx_qctrl[i].id) {
+					if (ctrl->value <
+					em28xx_qctrl[i].minimum
+					|| ctrl->value >
+					em28xx_qctrl[i].maximum)
+						return -ERANGE;
+					return em28xx_set_ctrl(dev, ctrl);
 				}
-				for (i = 0; i < ARRAY_SIZE(saa711x_qctrl); i++) {
-					if (ctrl->id == saa711x_qctrl[i].id) {
-						if (ctrl->value <
-						saa711x_qctrl[i].minimum
-						|| ctrl->value >
-						saa711x_qctrl[i].maximum)
-							return -ERANGE;
-						return saa711x_set_ctrl(dev, ctrl);
-					}
+			}
+			for (i = 0; i < ARRAY_SIZE(saa711x_qctrl); i++) {
+				if (ctrl->id == saa711x_qctrl[i].id) {
+					if (ctrl->value <
+					saa711x_qctrl[i].minimum
+					|| ctrl->value >
+					saa711x_qctrl[i].maximum)
+						return -ERANGE;
+					return saa711x_set_ctrl(dev, ctrl);
 				}
 			}
-
-			return -EINVAL;
 		}
 
-		/* --- tuner ioctls ------------------------------------------ */
+		return -EINVAL;
+	}
+	/* --- tuner ioctls ------------------------------------------ */
 	case VIDIOC_G_TUNER:
-		{
-			struct v4l2_tuner *t = arg;
-			int status = 0;
+	{
+		struct v4l2_tuner *t = arg;
+		int status = 0;
 
-			if (0 != t->index)
-				return -EINVAL;
+		if (0 != t->index)
+			return -EINVAL;
 
-			memset(t, 0, sizeof(*t));
-			strcpy(t->name, "Tuner");
-			t->type = V4L2_TUNER_ANALOG_TV;
-			t->capability = V4L2_TUNER_CAP_NORM;
-			t->rangehigh = 0xffffffffUL;	/* FIXME: set correct range */
+		memset(t, 0, sizeof(*t));
+		strcpy(t->name, "Tuner");
+		t->type = V4L2_TUNER_ANALOG_TV;
+		t->capability = V4L2_TUNER_CAP_NORM;
+		t->rangehigh = 0xffffffffUL;	/* FIXME: set correct range */
 /*		t->signal = 0xffff;*/
 /*		em28xx_i2c_call_clients(dev,VIDIOC_G_TUNER,t);*/
-			/* No way to get signal strength? */
-			down(&dev->lock);
-			em28xx_i2c_call_clients(dev, DECODER_GET_STATUS,
-						&status);
-			up(&dev->lock);
-			t->signal =
-			    (status & DECODER_STATUS_GOOD) != 0 ? 0xffff : 0;
+		/* No way to get signal strength? */
+		down(&dev->lock);
+		em28xx_i2c_call_clients(dev, DECODER_GET_STATUS,
+					&status);
+		up(&dev->lock);
+		t->signal =
+			(status & DECODER_STATUS_GOOD) != 0 ? 0xffff : 0;
 
-			em28xx_videodbg("VIDIO_G_TUNER: signal=%x, afc=%x\n", t->signal,
-				 t->afc);
-			return 0;
-		}
+		em28xx_videodbg("VIDIO_G_TUNER: signal=%x, afc=%x\n", t->signal,
+				t->afc);
+		return 0;
+	}
 	case VIDIOC_S_TUNER:
-		{
-			struct v4l2_tuner *t = arg;
-			int status = 0;
+	{
+		struct v4l2_tuner *t = arg;
+		int status = 0;
 
-			if (0 != t->index)
-				return -EINVAL;
-			memset(t, 0, sizeof(*t));
-			strcpy(t->name, "Tuner");
-			t->type = V4L2_TUNER_ANALOG_TV;
-			t->capability = V4L2_TUNER_CAP_NORM;
-			t->rangehigh = 0xffffffffUL;	/* FIXME: set correct range */
+		if (0 != t->index)
+			return -EINVAL;
+		memset(t, 0, sizeof(*t));
+		strcpy(t->name, "Tuner");
+		t->type = V4L2_TUNER_ANALOG_TV;
+		t->capability = V4L2_TUNER_CAP_NORM;
+		t->rangehigh = 0xffffffffUL;	/* FIXME: set correct range */
 /*		t->signal = 0xffff; */
-			/* No way to get signal strength? */
-			down(&dev->lock);
-			em28xx_i2c_call_clients(dev, DECODER_GET_STATUS,
-						&status);
-			up(&dev->lock);
-			t->signal =
-			    (status & DECODER_STATUS_GOOD) != 0 ? 0xffff : 0;
+		/* No way to get signal strength? */
+		down(&dev->lock);
+		em28xx_i2c_call_clients(dev, DECODER_GET_STATUS,
+					&status);
+		up(&dev->lock);
+		t->signal =
+			(status & DECODER_STATUS_GOOD) != 0 ? 0xffff : 0;
 
-			em28xx_videodbg("VIDIO_S_TUNER: signal=%x, afc=%x\n",
-				 t->signal, t->afc);
-			return 0;
-		}
+		em28xx_videodbg("VIDIO_S_TUNER: signal=%x, afc=%x\n",
+				t->signal, t->afc);
+		return 0;
+	}
 	case VIDIOC_G_FREQUENCY:
-		{
-			struct v4l2_frequency *f = arg;
+	{
+		struct v4l2_frequency *f = arg;
 
-			memset(f, 0, sizeof(*f));
-			f->type = V4L2_TUNER_ANALOG_TV;
-			f->frequency = dev->ctl_freq;
+		memset(f, 0, sizeof(*f));
+		f->type = V4L2_TUNER_ANALOG_TV;
+		f->frequency = dev->ctl_freq;
 
-			return 0;
-		}
+		return 0;
+	}
 	case VIDIOC_S_FREQUENCY:
-		{
-			struct v4l2_frequency *f = arg;
-
-			if (0 != f->tuner)
-				return -EINVAL;
+	{
+		struct v4l2_frequency *f = arg;
 
-			if (V4L2_TUNER_ANALOG_TV != f->type)
-				return -EINVAL;
+		if (0 != f->tuner)
+			return -EINVAL;
 
-			down(&dev->lock);
-			dev->ctl_freq = f->frequency;
-			em28xx_i2c_call_clients(dev, VIDIOC_S_FREQUENCY, f);
-			up(&dev->lock);
-			return 0;
-		}
+		if (V4L2_TUNER_ANALOG_TV != f->type)
+			return -EINVAL;
 
+		down(&dev->lock);
+		dev->ctl_freq = f->frequency;
+		em28xx_i2c_call_clients(dev, VIDIOC_S_FREQUENCY, f);
+		up(&dev->lock);
+		return 0;
+	}
 	case VIDIOC_CROPCAP:
-		{
-			struct v4l2_cropcap *cc = arg;
+	{
+		struct v4l2_cropcap *cc = arg;
 
-			if (cc->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
-				return -EINVAL;
-			cc->bounds.left = 0;
-			cc->bounds.top = 0;
-			cc->bounds.width = dev->width;
-			cc->bounds.height = dev->height;
-			cc->defrect = cc->bounds;
-			cc->pixelaspect.numerator = 54;	/* 4:3 FIXME: remove magic numbers */
-			cc->pixelaspect.denominator = 59;
-			return 0;
-		}
+		if (cc->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
+			return -EINVAL;
+		cc->bounds.left = 0;
+		cc->bounds.top = 0;
+		cc->bounds.width = dev->width;
+		cc->bounds.height = dev->height;
+		cc->defrect = cc->bounds;
+		cc->pixelaspect.numerator = 54;	/* 4:3 FIXME: remove magic numbers */
+		cc->pixelaspect.denominator = 59;
+		return 0;
+	}
 	case VIDIOC_STREAMON:
-		{
-			int *type = arg;
+	{
+		int *type = arg;
 
-			if (*type != V4L2_BUF_TYPE_VIDEO_CAPTURE
-			    || dev->io != IO_MMAP)
-				return -EINVAL;
+		if (*type != V4L2_BUF_TYPE_VIDEO_CAPTURE
+			|| dev->io != IO_MMAP)
+			return -EINVAL;
 
-			if (list_empty(&dev->inqueue))
-				return -EINVAL;
+		if (list_empty(&dev->inqueue))
+			return -EINVAL;
 
-			dev->stream = STREAM_ON;	/* FIXME: Start video capture here? */
+		dev->stream = STREAM_ON;	/* FIXME: Start video capture here? */
 
-			em28xx_videodbg("VIDIOC_STREAMON: starting stream\n");
+		em28xx_videodbg("VIDIOC_STREAMON: starting stream\n");
 
-			return 0;
-		}
+		return 0;
+	}
 	case VIDIOC_STREAMOFF:
-		{
-			int *type = arg;
-			int ret;
-
-			if (*type != V4L2_BUF_TYPE_VIDEO_CAPTURE
-			    || dev->io != IO_MMAP)
-				return -EINVAL;
+	{
+		int *type = arg;
+		int ret;
 
-			if (dev->stream == STREAM_ON) {
-				em28xx_videodbg ("VIDIOC_STREAMOFF: interrupting stream\n");
-				if ((ret = em28xx_stream_interrupt(dev)))
-					return ret;
-			}
-			em28xx_empty_framequeues(dev);
+		if (*type != V4L2_BUF_TYPE_VIDEO_CAPTURE
+			|| dev->io != IO_MMAP)
+			return -EINVAL;
 
-			return 0;
+		if (dev->stream == STREAM_ON) {
+			em28xx_videodbg ("VIDIOC_STREAMOFF: interrupting stream\n");
+			if ((ret = em28xx_stream_interrupt(dev)))
+				return ret;
 		}
+		em28xx_empty_framequeues(dev);
+
+		return 0;
+	}
 	default:
 		return v4l_compat_translate_ioctl(inode, filp, cmd, arg,
 						  driver_ioctl);
@@ -1489,40 +1477,38 @@ static int em28xx_video_do_ioctl(struct 
 		/* --- capabilities ------------------------------------------ */
 	case VIDIOC_QUERYCAP:
 		{
-			struct v4l2_capability *cap = arg;
+		struct v4l2_capability *cap = arg;
 
-			memset(cap, 0, sizeof(*cap));
-			strlcpy(cap->driver, "em28xx", sizeof(cap->driver));
-			strlcpy(cap->card, em28xx_boards[dev->model].name,
-				sizeof(cap->card));
-			strlcpy(cap->bus_info, dev->udev->dev.bus_id,
-				sizeof(cap->bus_info));
-			cap->version = EM28XX_VERSION_CODE;
-			cap->capabilities =
-			    V4L2_CAP_SLICED_VBI_CAPTURE |
-			    V4L2_CAP_VIDEO_CAPTURE |
-			    V4L2_CAP_AUDIO |
-			    V4L2_CAP_READWRITE | V4L2_CAP_STREAMING;
-			if (dev->has_tuner)
-				cap->capabilities |= V4L2_CAP_TUNER;
-			return 0;
-		}
-
-		/* --- capture ioctls ---------------------------------------- */
+		memset(cap, 0, sizeof(*cap));
+		strlcpy(cap->driver, "em28xx", sizeof(cap->driver));
+		strlcpy(cap->card, em28xx_boards[dev->model].name,
+			sizeof(cap->card));
+		strlcpy(cap->bus_info, dev->udev->dev.bus_id,
+			sizeof(cap->bus_info));
+		cap->version = EM28XX_VERSION_CODE;
+		cap->capabilities =
+				V4L2_CAP_SLICED_VBI_CAPTURE |
+				V4L2_CAP_VIDEO_CAPTURE |
+				V4L2_CAP_AUDIO |
+				V4L2_CAP_READWRITE | V4L2_CAP_STREAMING;
+		if (dev->has_tuner)
+			cap->capabilities |= V4L2_CAP_TUNER;
+		return 0;
+	}
+	/* --- capture ioctls ---------------------------------------- */
 	case VIDIOC_ENUM_FMT:
-		{
-			struct v4l2_fmtdesc *fmtd = arg;
-
-			if (fmtd->index != 0)
-				return -EINVAL;
-			memset(fmtd, 0, sizeof(*fmtd));
-			fmtd->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
-			strcpy(fmtd->description, "Packed YUY2");
-			fmtd->pixelformat = V4L2_PIX_FMT_YUYV;
-			memset(fmtd->reserved, 0, sizeof(fmtd->reserved));
-			return 0;
-		}
+	{
+		struct v4l2_fmtdesc *fmtd = arg;
 
+		if (fmtd->index != 0)
+			return -EINVAL;
+		memset(fmtd, 0, sizeof(*fmtd));
+		fmtd->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+		strcpy(fmtd->description, "Packed YUY2");
+		fmtd->pixelformat = V4L2_PIX_FMT_YUYV;
+		memset(fmtd->reserved, 0, sizeof(fmtd->reserved));
+		return 0;
+	}
 	case VIDIOC_G_FMT:
 		return em28xx_get_fmt(dev, (struct v4l2_format *) arg);
 
@@ -1531,131 +1517,130 @@ static int em28xx_video_do_ioctl(struct 
 		return em28xx_set_fmt(dev, cmd, (struct v4l2_format *)arg);
 
 	case VIDIOC_REQBUFS:
-		{
-			struct v4l2_requestbuffers *rb = arg;
-			u32 i;
-			int ret;
+	{
+		struct v4l2_requestbuffers *rb = arg;
+		u32 i;
+		int ret;
 
-			if (rb->type != V4L2_BUF_TYPE_VIDEO_CAPTURE ||
-			    rb->memory != V4L2_MEMORY_MMAP)
-				return -EINVAL;
-
-			if (dev->io == IO_READ) {
-				em28xx_videodbg ("method is set to read;"
-					" close and open the device again to"
-					" choose the mmap I/O method\n");
-				return -EINVAL;
-			}
+		if (rb->type != V4L2_BUF_TYPE_VIDEO_CAPTURE ||
+			rb->memory != V4L2_MEMORY_MMAP)
+			return -EINVAL;
 
-			for (i = 0; i < dev->num_frames; i++)
-				if (dev->frame[i].vma_use_count) {
-					em28xx_videodbg ("VIDIOC_REQBUFS failed; previous buffers are still mapped\n");
-					return -EINVAL;
-				}
+		if (dev->io == IO_READ) {
+			em28xx_videodbg ("method is set to read;"
+				" close and open the device again to"
+				" choose the mmap I/O method\n");
+			return -EINVAL;
+		}
 
-			if (dev->stream == STREAM_ON) {
-				em28xx_videodbg("VIDIOC_REQBUFS: interrupting stream\n");
-				if ((ret = em28xx_stream_interrupt(dev)))
-					return ret;
+		for (i = 0; i < dev->num_frames; i++)
+			if (dev->frame[i].vma_use_count) {
+				em28xx_videodbg ("VIDIOC_REQBUFS failed; previous buffers are still mapped\n");
+				return -EINVAL;
 			}
 
-			em28xx_empty_framequeues(dev);
-
-			em28xx_release_buffers(dev);
-			if (rb->count)
-				rb->count =
-				    em28xx_request_buffers(dev, rb->count);
-
-			dev->frame_current = NULL;
-
-			em28xx_videodbg ("VIDIOC_REQBUFS: setting io method to mmap: num bufs %i\n",
-						     rb->count);
-			dev->io = rb->count ? IO_MMAP : IO_NONE;
-			return 0;
+		if (dev->stream == STREAM_ON) {
+			em28xx_videodbg("VIDIOC_REQBUFS: interrupting stream\n");
+			if ((ret = em28xx_stream_interrupt(dev)))
+				return ret;
 		}
 
+		em28xx_empty_framequeues(dev);
+
+		em28xx_release_buffers(dev);
+		if (rb->count)
+			rb->count =
+				em28xx_request_buffers(dev, rb->count);
+
+		dev->frame_current = NULL;
+
+		em28xx_videodbg ("VIDIOC_REQBUFS: setting io method to mmap: num bufs %i\n",
+						rb->count);
+		dev->io = rb->count ? IO_MMAP : IO_NONE;
+		return 0;
+	}
 	case VIDIOC_QUERYBUF:
-		{
-			struct v4l2_buffer *b = arg;
+	{
+		struct v4l2_buffer *b = arg;
 
-			if (b->type != V4L2_BUF_TYPE_VIDEO_CAPTURE ||
-			    b->index >= dev->num_frames || dev->io != IO_MMAP)
-				return -EINVAL;
+		if (b->type != V4L2_BUF_TYPE_VIDEO_CAPTURE ||
+			b->index >= dev->num_frames || dev->io != IO_MMAP)
+			return -EINVAL;
 
-			memcpy(b, &dev->frame[b->index].buf, sizeof(*b));
+		memcpy(b, &dev->frame[b->index].buf, sizeof(*b));
 
-			if (dev->frame[b->index].vma_use_count) {
-				b->flags |= V4L2_BUF_FLAG_MAPPED;
-			}
-			if (dev->frame[b->index].state == F_DONE)
-				b->flags |= V4L2_BUF_FLAG_DONE;
-			else if (dev->frame[b->index].state != F_UNUSED)
-				b->flags |= V4L2_BUF_FLAG_QUEUED;
-			return 0;
+		if (dev->frame[b->index].vma_use_count) {
+			b->flags |= V4L2_BUF_FLAG_MAPPED;
 		}
+		if (dev->frame[b->index].state == F_DONE)
+			b->flags |= V4L2_BUF_FLAG_DONE;
+		else if (dev->frame[b->index].state != F_UNUSED)
+			b->flags |= V4L2_BUF_FLAG_QUEUED;
+		return 0;
+	}
 	case VIDIOC_QBUF:
-		{
-			struct v4l2_buffer *b = arg;
-			unsigned long lock_flags;
+	{
+		struct v4l2_buffer *b = arg;
+		unsigned long lock_flags;
 
-			if (b->type != V4L2_BUF_TYPE_VIDEO_CAPTURE ||
-			    b->index >= dev->num_frames || dev->io != IO_MMAP) {
-				return -EINVAL;
-			}
+		if (b->type != V4L2_BUF_TYPE_VIDEO_CAPTURE ||
+			b->index >= dev->num_frames || dev->io != IO_MMAP) {
+			return -EINVAL;
+		}
 
-			if (dev->frame[b->index].state != F_UNUSED) {
-				return -EAGAIN;
-			}
-			dev->frame[b->index].state = F_QUEUED;
+		if (dev->frame[b->index].state != F_UNUSED) {
+			return -EAGAIN;
+		}
+		dev->frame[b->index].state = F_QUEUED;
 
-			/* add frame to fifo */
-			spin_lock_irqsave(&dev->queue_lock, lock_flags);
-			list_add_tail(&dev->frame[b->index].frame,
-				      &dev->inqueue);
-			spin_unlock_irqrestore(&dev->queue_lock, lock_flags);
+		/* add frame to fifo */
+		spin_lock_irqsave(&dev->queue_lock, lock_flags);
+		list_add_tail(&dev->frame[b->index].frame,
+				&dev->inqueue);
+		spin_unlock_irqrestore(&dev->queue_lock, lock_flags);
 
-			return 0;
-		}
+		return 0;
+	}
 	case VIDIOC_DQBUF:
-		{
-			struct v4l2_buffer *b = arg;
-			struct em28xx_frame_t *f;
-			unsigned long lock_flags;
-			int ret = 0;
+	{
+		struct v4l2_buffer *b = arg;
+		struct em28xx_frame_t *f;
+		unsigned long lock_flags;
+		int ret = 0;
 
-			if (b->type != V4L2_BUF_TYPE_VIDEO_CAPTURE
-			    || dev->io != IO_MMAP)
-				return -EINVAL;
+		if (b->type != V4L2_BUF_TYPE_VIDEO_CAPTURE
+			|| dev->io != IO_MMAP)
+			return -EINVAL;
 
-			if (list_empty(&dev->outqueue)) {
-				if (dev->stream == STREAM_OFF)
-					return -EINVAL;
-				if (filp->f_flags & O_NONBLOCK)
-					return -EAGAIN;
-				ret = wait_event_interruptible
-				    (dev->wait_frame,
-				     (!list_empty(&dev->outqueue)) ||
-				     (dev->state & DEV_DISCONNECTED));
-				if (ret)
-					return ret;
-				if (dev->state & DEV_DISCONNECTED)
-					return -ENODEV;
-			}
+		if (list_empty(&dev->outqueue)) {
+			if (dev->stream == STREAM_OFF)
+				return -EINVAL;
+			if (filp->f_flags & O_NONBLOCK)
+				return -EAGAIN;
+			ret = wait_event_interruptible
+				(dev->wait_frame,
+				(!list_empty(&dev->outqueue)) ||
+				(dev->state & DEV_DISCONNECTED));
+			if (ret)
+				return ret;
+			if (dev->state & DEV_DISCONNECTED)
+				return -ENODEV;
+		}
 
-			spin_lock_irqsave(&dev->queue_lock, lock_flags);
-			f = list_entry(dev->outqueue.next,
-				       struct em28xx_frame_t, frame);
-			list_del(dev->outqueue.next);
-			spin_unlock_irqrestore(&dev->queue_lock, lock_flags);
+		spin_lock_irqsave(&dev->queue_lock, lock_flags);
+		f = list_entry(dev->outqueue.next,
+				struct em28xx_frame_t, frame);
+		list_del(dev->outqueue.next);
+		spin_unlock_irqrestore(&dev->queue_lock, lock_flags);
 
-			f->state = F_UNUSED;
-			memcpy(b, &f->buf, sizeof(*b));
+		f->state = F_UNUSED;
+		memcpy(b, &f->buf, sizeof(*b));
 
-			if (f->vma_use_count)
-				b->flags |= V4L2_BUF_FLAG_MAPPED;
+		if (f->vma_use_count)
+			b->flags |= V4L2_BUF_FLAG_MAPPED;
 
-			return 0;
-		}
+		return 0;
+	}
 	default:
 		return em28xx_do_ioctl(inode, filp, dev, cmd, arg,
 				       em28xx_video_do_ioctl);

