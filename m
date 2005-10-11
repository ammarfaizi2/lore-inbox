Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbVJKWS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbVJKWS0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 18:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbVJKWS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 18:18:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54747 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751014AbVJKWS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 18:18:26 -0400
Date: Tue, 11 Oct 2005 15:18:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: dsaxena@plexity.net
Cc: torvalds@osdl.org, marcel@holtmann.org, maxk@qualcomm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [BLUETOOTH] kmalloc + memset -> kzalloc conversion
Message-Id: <20051011151805.0d32c840.akpm@osdl.org>
In-Reply-To: <20051001065121.GC25424@plexity.net>
References: <20051001065121.GC25424@plexity.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Deepak Saxena <dsaxena@plexity.net> wrote:
>

Confused.  This patch changes lots of block code, not bluetooth.

> diff --git a/drivers/block/DAC960.c b/drivers/block/DAC960.c
> --- a/drivers/block/DAC960.c
> +++ b/drivers/block/DAC960.c
> @@ -4665,7 +4663,6 @@ static void DAC960_V2_ProcessCompletedCo
>  	   */
>  	   DAC960_queue_partial_rw(Command);
>  	   return;
> -	}
>        else
>  	{
>  	  if (Command->V2.RequestSense->SenseKey != DAC960_SenseKey_NotReady)
> @@ -4799,10 +4796,10 @@ static void DAC960_V2_ProcessCompletedCo

And that looks rather wrong.
