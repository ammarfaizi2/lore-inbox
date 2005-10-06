Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbVJFXvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbVJFXvn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 19:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbVJFXvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 19:51:43 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:48785 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1751259AbVJFXvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 19:51:43 -0400
Message-ID: <4345B888.9020405@linuxtv.org>
Date: Thu, 06 Oct 2005 19:51:36 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux and Kernel Video <video4linux-list@redhat.com>
CC: linux-kernel@vger.kernel.org,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] msp3400: check ->kthread correctly
References: <20051006214621.GC2370@mipter.zuzino.mipt.ru>
In-Reply-To: <20051006214621.GC2370@mipter.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:

>Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
>---
>
> drivers/media/video/msp3400.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>--- ./drivers/media/video/msp3400.c
>+++ ./drivers/media/video/msp3400.c
>@@ -1558,7 +1558,7 @@ static int msp_detach(struct i2c_client 
> 	struct msp3400c *msp  = i2c_get_clientdata(client);
> 
> 	/* shutdown control thread */
>-	if (msp->kthread >= 0) {
>+	if (msp->kthread) {
> 		msp->restart = 1;
> 		kthread_stop(msp->kthread);
> 	}
>
>--
>video4linux-list mailing list
>Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
>https://www.redhat.com/mailman/listinfo/video4linux-list
>  
>
Applied to video4linux cvs.  Thank you!

CVSROOT:    /cvs/video4linux
Module name:    video4linux
Changes by:    mkrufky    20051007 01:48:36

Modified files:
    .              : ChangeLog msp3400.c

Log message:
* msp3400.c: (msp_detach):
- check ->kthread correctly

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Ack'd by: Michael Krufky <mkrufky@m1k.net>

-- 
Michael Krufky

