Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287471AbSALU7W>; Sat, 12 Jan 2002 15:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287450AbSALU7N>; Sat, 12 Jan 2002 15:59:13 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:14856 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S287003AbSALU65>;
	Sat, 12 Jan 2002 15:58:57 -0500
Date: Sat, 12 Jan 2002 12:56:04 -0800
From: Greg KH <greg@kroah.com>
To: Sebastian Krause <krause@sdbk.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't compile 2.5.2-pre11: error in fbdev
Message-ID: <20020112205604.GB5808@kroah.com>
In-Reply-To: <krause.87lmf3pbm9.fsf@sdbk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <krause.87lmf3pbm9.fsf@sdbk.de>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sat, 15 Dec 2001 18:23:56 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 09:17:50PM +0100, Sebastian Krause wrote:
> When I try to compile 2.5.2-pre11, I get the following error:

This patch fixes it for me:


diff -Nru a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
--- a/drivers/video/riva/fbdev.c	Sat Jan 12 13:06:34 2002
+++ b/drivers/video/riva/fbdev.c	Sat Jan 12 13:06:34 2002
@@ -1811,7 +1811,7 @@
 	info = &rinfo->info;
 
 	strcpy(info->modename, rinfo->drvr_name);
-	info->node = -1;
+	info->node = NODEV;
 	info->flags = FBINFO_FLAG_DEFAULT;
 	info->fbops = &riva_fb_ops;
 
