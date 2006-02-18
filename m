Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWBRFKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWBRFKZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 00:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWBRFKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 00:10:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4820 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750807AbWBRFKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 00:10:24 -0500
Date: Fri, 17 Feb 2006 21:09:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: greg@kroah.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-pm@osdl.org
Subject: Re: [PATCH 2/5] [pm] Add state field to pm_message_t (to hold
 actual state device is in)
Message-Id: <20060217210900.514b5f4c.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.50.0602171757360.30811-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0602171757360.30811-100000@monsoon.he.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel <mochel@digitalimplant.org> wrote:
>
> 
> Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
> 
> ---
> 
>  include/linux/pm.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> applies-to: 1ac50ba99ca37c65bdf3643c4056c246e401c18a
> 63b8e7f0896ce93834ac60c15df954b1e6d45e56
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 5be87ba..a7324ea 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -140,6 +140,7 @@ struct device;
> 
>  typedef struct pm_message {
>  	int event;
> +	u32 state;
>  } pm_message_t;

I don't quite understand.  This is a message which is sent to a driver
saying "go into this state", isn't it?

If so, what does the new `state' field tell us?

