Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbVKNLyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbVKNLyx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 06:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbVKNLyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 06:54:52 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:5325 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751094AbVKNLym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 06:54:42 -0500
Date: Mon, 14 Nov 2005 09:54:40 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, kraxel@bytesex.org
Subject: [PATCH] - Fixes sparse warning in bttv-driver.
Message-Id: <20051114095440.5fb13e00.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-conectiva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patch below fixes the following sparse warning:

drivers/media/video/bttv-driver.c

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 drivers/media/video/bttv-driver.c |    2 +-
 drivers/media/video/bttv-i2c.c    |    0 
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/video/bttv-driver.c b/drivers/media/video/bttv-driver.c
--- a/drivers/media/video/bttv-driver.c
+++ b/drivers/media/video/bttv-driver.c
@@ -1853,7 +1853,7 @@ static int bttv_common_ioctls(struct btt
 	}
 	case VIDIOC_LOG_STATUS:
 	{
-		bttv_call_i2c_clients(btv, VIDIOC_LOG_STATUS, 0);
+		bttv_call_i2c_clients(btv, VIDIOC_LOG_STATUS, NULL);
 		return 0;
 	}
 
diff --git a/drivers/media/video/bttv-i2c.c b/drivers/media/video/bttv-i2c.c

-- 
Luiz Fernando N. Capitulino
