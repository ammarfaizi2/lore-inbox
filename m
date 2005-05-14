Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262644AbVENAe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262644AbVENAe6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 20:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbVENAe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 20:34:57 -0400
Received: from mail.dvmed.net ([216.237.124.58]:63119 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262644AbVENAW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 20:22:27 -0400
Message-ID: <428544B5.1080604@pobox.com>
Date: Fri, 13 May 2005 20:22:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: domen@coderock.org
CC: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Christophe Lucas <clucas@rotomalug.org>
Subject: Re: [patch 2/3] drivers/char/hw_random.c: replace direct assignment
 with set_current_state()
References: <20050513222409.165372000@nd47.coderock.org>
In-Reply-To: <20050513222409.165372000@nd47.coderock.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

domen@coderock.org wrote:
> From: Christophe Lucas <clucas@rotomalug.org>
> 
> 
> 
> Use set_current_state() instead of direct assignment of
> current->state.
> 
> Signed-off-by: Christophe Lucas <clucas@rotomalug.org>
> Signed-off-by: Domen Puncer <domen@coderock.org>
> 
> 
> ---
>  hw_random.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> Index: quilt/drivers/char/hw_random.c
> ===================================================================
> --- quilt.orig/drivers/char/hw_random.c
> +++ quilt/drivers/char/hw_random.c
> @@ -514,7 +514,7 @@ static ssize_t rng_dev_read (struct file
>  
>  		if(need_resched())
>  		{
> -			current->state = TASK_INTERRUPTIBLE;
> +			set_current_state(TASK_INTERRUPTIBLE);
>  			schedule_timeout(1);

full barriers and such don't seem needed.

Also, make sure to send driver patches to the driver author (me).

	Jeff



