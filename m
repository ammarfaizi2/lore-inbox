Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264780AbRFXVj7>; Sun, 24 Jun 2001 17:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264779AbRFXVjt>; Sun, 24 Jun 2001 17:39:49 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:52584
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S264772AbRFXVji>; Sun, 24 Jun 2001 17:39:38 -0400
Date: Sun, 24 Jun 2001 23:39:32 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] add create_proc_entry check to videodev.c (245ac16)
Message-ID: <20010624233932.J847@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The patch below adds a check for create_proc_entry return code
in drivers/media/video/videodev.c. It applies against 245-ac16
and 246p6.


--- linux-245-ac16-clean/drivers/media/video/videodev.c	Sun May 27 22:15:23 2001
+++ linux-245-ac16/drivers/media/video/videodev.c	Sun Jun 24 23:33:36 2001
@@ -373,6 +373,8 @@
 		return;
 
 	p = create_proc_entry(name, S_IFREG|S_IRUGO|S_IWUSR, video_dev_proc_entry);
+	if (!p)
+		return;
 	p->data = vfd;
 	p->read_proc = videodev_proc_read;
 
-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

Genius may have its limitations, but stupidity is not thus handicapped. 
  -- Elbert Hubbard 
