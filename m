Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264355AbUE2TzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264355AbUE2TzK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 15:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264358AbUE2TzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 15:55:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35287 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264355AbUE2TzG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 15:55:06 -0400
Message-ID: <40B8EA88.6030607@pobox.com>
Date: Sat, 29 May 2004 15:54:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: benh@kernel.crashing.org
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] use new msleep() in ADT746x driver
References: <200405291908.i4TJ8Acm011281@hera.kernel.org>
In-Reply-To: <200405291908.i4TJ8Acm011281@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> diff -Nru a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
> --- a/drivers/macintosh/therm_adt746x.c	2004-05-29 12:08:19 -07:00
> +++ b/drivers/macintosh/therm_adt746x.c	2004-05-29 12:08:19 -07:00
> @@ -246,8 +246,7 @@
>  
>  	while(monitor_running)
>  	{
> -		set_task_state(current, TASK_UNINTERRUPTIBLE);
> -		schedule_timeout(2*HZ);
> +		msleep(2000);


IMO this is moving the code away from what the coder appeared to intend.

A "sleep(2)" would be preferred, and more clear.

	Jeff


