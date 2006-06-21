Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030330AbWFUV5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030330AbWFUV5t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030328AbWFUV5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:57:49 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:51210 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030330AbWFUV5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:57:45 -0400
Date: Wed, 21 Jun 2006 23:57:44 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, v4l-dvb-maintainer@linuxtv.org
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] drivers/media/video/vivi.c: make 2 functions static
Message-ID: <20060621215744.GN9111@stusta.de>
References: <20060621034857.35cfe36f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621034857.35cfe36f.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 03:48:57AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-rc6-mm2:
>...
>  git-dvb.patch
>...
>  git trees
>...

This patch makes two needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/media/video/vivi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.17-mm1-full/drivers/media/video/vivi.c.old	2006-06-21 23:04:12.000000000 +0200
+++ linux-2.6.17-mm1-full/drivers/media/video/vivi.c	2006-06-21 23:04:31.000000000 +0200
@@ -1011,7 +1011,7 @@
 }
 #endif
 
-int vidioc_streamon (struct file *file, void *priv, enum v4l2_buf_type i)
+static int vidioc_streamon(struct file *file, void *priv, enum v4l2_buf_type i)
 {
 	struct vivi_fh  *fh=priv;
 	struct vivi_dev *dev    = fh->dev;
@@ -1026,7 +1026,7 @@
 	return (videobuf_streamon(&fh->vb_vidq));
 }
 
-int vidioc_streamoff (struct file *file, void *priv, enum v4l2_buf_type i)
+static int vidioc_streamoff(struct file *file, void *priv, enum v4l2_buf_type i)
 {
 	struct vivi_fh  *fh=priv;
 	struct vivi_dev *dev    = fh->dev;

