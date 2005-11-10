Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbVKJXPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbVKJXPz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 18:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbVKJXPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 18:15:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40608 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932248AbVKJXPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 18:15:55 -0500
Date: Thu, 10 Nov 2005 15:15:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: mchehab@brturbo.com.br
Cc: linux-kernel@vger.kernel.org, video4linux-list@redhat.com,
       mark-clist@npsl.co.uk
Subject: Re: [Patch 07/20] V4L (939) Support for nebula rc5 based gpio
 remote
Message-Id: <20051110151559.1ccd1a98.akpm@osdl.org>
In-Reply-To: <1131656168.6478.49.camel@localhost>
References: <1131656168.6478.49.camel@localhost>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mchehab@brturbo.com.br wrote:
>
> @@ -454,6 +725,15 @@ static int ir_remove(struct device *dev)
>  		del_timer(&ir->timer);
>  		flush_scheduled_work();
>  	}
> +	if (ir->rc5_gpio) {
> +		u32 gpio;
> +
> +		del_timer(&ir->timer_end);
> +		flush_scheduled_work();

You might need del_timer_sync() here.
