Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262796AbVF3CoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbVF3CoI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 22:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262798AbVF3CoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 22:44:07 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:23775 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S262796AbVF3CoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 22:44:04 -0400
Message-ID: <42C35C65.8030900@m1k.net>
Date: Wed, 29 Jun 2005 22:43:49 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH] v4l cx88 hue offset fix
Content-Type: multipart/mixed;
 boundary="------------080007060906070007090700"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080007060906070007090700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------080007060906070007090700
Content-Type: text/plain;
 name="trivial-v4l-cx88-video-hue-offset-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="trivial-v4l-cx88-video-hue-offset-fix.patch"

  Changed hue offset to 128 to correct behavior in cx88 cards.
  Previously, setting 0% or 100% hue was required to avoid blue/green
  people on screen.  Now, 50% Hue means no offset, just like bt878 stuff.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 cx88-video.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -upr a/drivers/media/video/cx88/cx88-video.c b/drivers/media/video/cx88/cx88-video.c
--- a/drivers/media/video/cx88/cx88-video.c	2005-06-29 21:59:40.000000000 -0400
+++ b/drivers/media/video/cx88/cx88-video.c	2005-06-29 21:54:27.000000000 -0400
@@ -268,7 +268,7 @@ static struct cx88_ctrl cx8800_ctls[] = 
 			.default_value = 0,
 			.type          = V4L2_CTRL_TYPE_INTEGER,
 		},
-		.off                   = 0,
+		.off                   = 128,
 		.reg                   = MO_HUE,
 		.mask                  = 0x00ff,
 		.shift                 = 0,

--------------080007060906070007090700--
