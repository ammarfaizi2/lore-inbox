Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbVKJWVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbVKJWVF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 17:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbVKJWVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 17:21:05 -0500
Received: from kirby.webscope.com ([204.141.84.57]:32228 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S932206AbVKJWVE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 17:21:04 -0500
Message-ID: <4373C7B4.2000509@linuxtv.org>
Date: Thu, 10 Nov 2005 17:20:36 -0500
From: Mike Krufky <mkrufky@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       Andrew Morton <akpm@osdl.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>
Subject: Re: saa711x driver doesn't need segment.h
References: <20051110221411.GA26539@redhat.com>
In-Reply-To: <20051110221411.GA26539@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>This breaks compilation on non-x86 architectures,
>and isn't even used.
>
>Signed-off-by: Dave Jones <davej@redhat.com>
>
>--- linux-2.6.14/drivers/media/video/saa711x.c~	2005-11-10 15:27:05.000000000 -0500
>+++ linux-2.6.14/drivers/media/video/saa711x.c	2005-11-10 15:27:33.000000000 -0500
>@@ -36,7 +36,6 @@
> #include <asm/pgtable.h>
> #include <asm/page.h>
> #include <linux/sched.h>
>-#include <asm/segment.h>
> #include <linux/types.h>
> #include <asm/uaccess.h>
> #include <linux/videodev.h>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>
Acked-by: Michael Krufky <mkrufky@m1k.net>

Andrew-

Due to the above fix, please revert:

saa711x-is-busted-on-ppc64.patch

Thank you.

-- 
Michael Krufky


