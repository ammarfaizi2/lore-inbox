Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWBJPOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWBJPOG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 10:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWBJPOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 10:14:05 -0500
Received: from pproxy.gmail.com ([64.233.166.182]:54776 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932128AbWBJPOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 10:14:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=fEjks0Brec2QterrR32+S55+PGGEmOQJV7rXj5B810T298Fw092ppkr+6jBUZygVKUnRT4RKr3azwMrMDdgix4d2E1f+nJsGF9dge/VkCL8lscT/wHnqAJnkDgE+EZechodHnOVNv45jjJZ2PFVKTNy9BtUF//BdOhNOa9or3lw=
Message-ID: <43ECADBC.2080107@gmail.com>
Date: Fri, 10 Feb 2006 23:14:04 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
CC: malattia@linux.it
Subject: [PATCH] fbdev: Fix typo in fbmem.c
References: <20060207220627.345107c3.akpm@osdl.org> <20060210145243.GA3581@inferi.kami.home>
In-Reply-To: <20060210145243.GA3581@inferi.kami.home>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A typo in fbmem.c prevents recognition of video= parameter.

Signed-off-by: Antonino Daplas <adaplas@pol.net>

---
Mattia Dongili wrote:

> On Tue, Feb 07, 2006 at 10:06:27PM -0800, Andrew Morton wrote:
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc2/2.6.16-rc2-mm1/
> 
> Hello,
> 
> radeonfb ignores the video= parameter and always run at 1400x1050 (the
> highest available). Things where fine with .16-rc1-mm5.
> I also tried booting with 640x480-32@60 without success.

Try this patch.

Tony

PS: Andrew, maybe this patch should go into your hotfixes?

 fbmem.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 6454a37..3ff1a54 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1569,7 +1569,7 @@ int fb_get_options(char *name, char **op
 	return retval;
 }
 
-#ifdef MODULE
+#ifndef MODULE
 /**
  *	video_setup - process command line options
  *	@options: string of options
