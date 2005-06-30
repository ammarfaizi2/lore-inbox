Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262996AbVF3QST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262996AbVF3QST (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 12:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262995AbVF3QSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 12:18:18 -0400
Received: from kirby.webscope.com ([204.141.84.57]:61600 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S262994AbVF3QRw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 12:17:52 -0400
Message-ID: <42C41B0B.2080708@m1k.net>
Date: Thu, 30 Jun 2005 12:17:15 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Mauro Carvalho Chehab <mchehab@brturbo.com.br>, trivial@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: [TRIVIAL 2.6.12 / 2.6.13 PATCH] v4l cx88 hue offset fix
References: <42C35C65.8030900@m1k.net> <42C3F871.7060008@brturbo.com.br>
In-Reply-To: <42C3F871.7060008@brturbo.com.br>
Content-Type: multipart/mixed;
 boundary="------------030400080406000603090201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030400080406000603090201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Mauro Carvalho Chehab wrote:

>Acked-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
>
>This small patch fixes top complaint about CX88 cards, which had a
>different behavior than other V4L cards for hue setting.
>
>It can also be applied also at 2.6.13 mainstream.
>
I must add:  Not only does this apply to 2.6.13, but it also applies to 
2.6.12 ... Can we have this put into the patch queue for 2.6.12.3 ?  
This IS a bug fix, and makes a HUGE improvement for cx88 boards.

I'd really like to see this in the mainstream kernel before the livecd 
distros make their next releases.

I would send this to Greg Kroah-Hartman / Chris Wright myself, but I 
don't know if that is proper protocol for doing this.  Andrew, please 
send this to the correct person.

Thank you.

Attached is a diff against 2.6.12.2

-- 
Michael Krufky


--------------030400080406000603090201
Content-Type: text/plain;
 name="2.6.12-trivial-v4l-cx88-video-hue-offset-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.12-trivial-v4l-cx88-video-hue-offset-fix.patch"

Changed hue offset to 128 to correct behavior in cx88 cards.  Previously, 
setting 0% or 100% hue was required to avoid blue/green people on screen.  
Now, 50% Hue means no offset, just like bt878 stuff.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 cx88-video.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -upr linux-2.6.12.2/drivers/media/video/cx88/cx88-video.c linux/drivers/media/video/cx88/cx88-video.c
--- linux-2.6.12.2/drivers/media/video/cx88/cx88-video.c	2005-06-17 15:48:29.000000000 -0400
+++ linux/drivers/media/video/cx88/cx88-video.c	2005-06-30 11:47:49.000000000 -0400
@@ -261,7 +261,7 @@ static struct cx88_ctrl cx8800_ctls[] = 
 			.default_value = 0,
 			.type          = V4L2_CTRL_TYPE_INTEGER,
 		},
-		.off                   = 0,
+		.off                   = 128,
 		.reg                   = MO_HUE,
 		.mask                  = 0x00ff,
 		.shift                 = 0,

--------------030400080406000603090201--

