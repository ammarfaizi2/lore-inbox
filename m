Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751649AbWCUNDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbWCUNDi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 08:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbWCUNDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 08:03:38 -0500
Received: from thing.hostingexpert.com ([67.15.235.34]:41187 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1751646AbWCUNDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 08:03:37 -0500
Message-ID: <441FF9A2.30107@linuxtv.org>
Date: Tue, 21 Mar 2006 08:03:30 -0500
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: stable@kernel.org
CC: lkml <linux-kernel@vger.kernel.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [2.6.16 STABLE PATCH] Kconfig: VIDEO_DECODER must select FW_LOADER
References: <441F7462.4040707@linuxtv.org>
In-Reply-To: <441F7462.4040707@linuxtv.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for queuing this for 2.6.16.1 ... I was just looking at the 
2.6.15 sources, and I realized that this should also go to 2.6.15.y, if 
there are any more yet to come.

Please also add this to the 2.6.15.y queue, if there are any more 
releases planned.

Thank you,

Michael Krufky

Michael Krufky wrote:
> This patch has been backported for 2.6.16.1 from the following patch,
> which is queued for 2.6.17:
> 
> V4L/DVB (3495): Kconfig: select VIDEO_CX25840 to build cx25840 a/v 
> decoder module
> http://www.kernel.org/git/?p=linux/kernel/git/mchehab/v4l-dvb.git;a=commitdiff;h=4f767be057d0173eae7ef116de32a3f4f12888a8 
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> From: Michael Krufky <mkrufky@linuxtv.org>
> Date: Mon, 20 Mar 2006 22:17:00 +0000 (-0500)
> Subject: Kconfig: VIDEO_DECODER must select FW_LOADER
> 
> The cx25840 module requires external firmware in order to function,
> so it must select FW_LOADER, but saa7115 and saa7129 do not require it.
> 
> Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
> Cc: Mauro Carvalho Chehab <mchehab@infradead.org>
> ---
> 
> --- 
> linux-2.6.16.orig/drivers/media/video/Kconfig
> +++ linux-2.6.16/drivers/media/video/Kconfig
> @@ -349,6 +349,7 @@
>  config VIDEO_DECODER
>  	tristate "Add support for additional video chipsets"
>  	depends on VIDEO_DEV && I2C && EXPERIMENTAL
> +	select FW_LOADER
>  	---help---
>  	  Say Y here to compile drivers for SAA7115, SAA7127 and CX25840
>  	  video decoders.

