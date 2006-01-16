Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWAPJZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWAPJZI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWAPJYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:24:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:59115 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932266AbWAPJYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:24:19 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Hans Verkuil <hverkuil@xs4all.nl>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 20/25] Return -EINVAL for unknown commands in msp3400
	module.
Date: Mon, 16 Jan 2006 07:11:24 -0200
Message-id: <20060116091124.PS62024100020@infradead.org>
In-Reply-To: <20060116091105.PS83611600000@infradead.org>
References: <20060116091105.PS83611600000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Hans Verkuil <hverkuil@xs4all.nl>

- Return -EINVAL for unknown commands.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/msp3400-driver.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/video/msp3400-driver.c b/drivers/media/video/msp3400-driver.c
index 09ff25b..69ed369 100644
--- a/drivers/media/video/msp3400-driver.c
+++ b/drivers/media/video/msp3400-driver.c
@@ -1031,8 +1031,8 @@ static int msp_command(struct i2c_client
 	}
 
 	default:
-		/* nothing */
-		break;
+		/* unknown */
+		return -EINVAL;
 	}
 	return 0;
 }

