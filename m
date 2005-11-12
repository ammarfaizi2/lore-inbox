Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbVKLRwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbVKLRwr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 12:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbVKLRwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 12:52:47 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:10603 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932437AbVKLRwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 12:52:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=iQ1byQ94/3WHALB2jli2Yt7Ht5pN/in9SH0yO9pqVJuRzE47ZABfCPwRDQLJ4bEYnUsSpOg/CU+W0eN4npqqEdvgdO7bl5YU0AkzCMb6j4E/SB6TcCRMFovwXdUOtbnoemJ3wg3x4m3VrfPIP1llWbPtjp/7g23TWl8BdwsEGwg=
Message-ID: <43762BE6.3070601@gmail.com>
Date: Sat, 12 Nov 2005 18:52:38 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       adaplas@gmail.com
Subject: Re: Linuv 2.6.15-rc1
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Linus Torvalds wrote:

>Ok,
> there it is, go wild. Get the git trees, the tar-balls and the patches 
>(some or all of tghe above may still be mirroring out but should show up 
>shortly).
>  
>
Please apply that patch. It's from Antonino Daplas and it fixes nvidia 
frame buffer problems.

Regards,
Michal Piotrowski

Signed-off-by: Antonino Daplas <adaplas@pol.net>


diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c

index 0b40a2a..bee09c6 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -1301,7 +1301,7 @@ static int nvidiafb_pan_display(struct f
 	struct nvidia_par *par = info->par;
 	u32 total;
 
-	total = info->var.yoffset * info->fix.line_length + info->var.xoffset;
+	total = var->yoffset * info->fix.line_length + var->xoffset;
 
 	NVSetStartAddress(par, total);

