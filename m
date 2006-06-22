Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030308AbWFVO2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030308AbWFVO2L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 10:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbWFVO2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 10:28:11 -0400
Received: from kurby.webscope.com ([204.141.84.54]:59573 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S1030296AbWFVO2J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 10:28:09 -0400
Message-ID: <449AA8A5.8070903@linuxtv.org>
Date: Thu, 22 Jun 2006 10:26:45 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: predivan@ptt.yu
CC: v4l-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: [v4l-dvb-maintainer]  [PATCH][2.6.17]drivers/media/video/bt8xx/bttvp.h
 has wrong include line
References: <20060622145850.0cf87d8a.predivan@ptt.yu>
In-Reply-To: <20060622145850.0cf87d8a.predivan@ptt.yu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Predrag Ivanovic wrote:
> Hi.
> Trivial patch, really.
> Fixes include line in bttvp.h(btcx-risc.h is in parent dir).
> ------
> --- bttvp.h	2006-06-19 16:48:46.000000000 +0200
> +++ bttvp.h.new	2006-06-19 16:49:54.000000000 +0200
> @@ -48,7 +48,7 @@
>  
>  #include "bt848.h"
>  #include "bttv.h"
> -#include "btcx-risc.h"
> +#include "../btcx-risc.h"
>  
>  #ifdef __KERNEL__
>  
> -----------
> Pedja 
>   
NACK.

Please see drivers/media/video/bt8xx/Makefile

You will notice the following line:

EXTRA_CFLAGS += -Idrivers/media/video

This instructs the compiler to find some other required headers in 
drivers/media/video (such as btcx-risc.h)

Your patch is unnecessary, and it is bad practice to use ".." inside a 
header includes path, IMHO at least.

In addition, please see the guidelines in 
Documentation/SubmittingPatches before you send any future patches.  We 
cannot accept patches into the linux kernel without a proper developer's 
certificate of origin.

Thank you for the effort, though :-)

Regards,

Michael Krufky


