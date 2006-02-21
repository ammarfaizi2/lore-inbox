Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932550AbWBUSfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbWBUSfX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 13:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbWBUSeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 13:34:19 -0500
Received: from mail.kroah.org ([69.55.234.183]:50149 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932540AbWBUSeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 13:34:14 -0500
Date: Tue, 21 Feb 2006 09:50:43 -0800
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-pm@osdl.org
Subject: Re: [PATCH 1/4] [pm] Add state filed to pm_message_t (to hold actual state device is in).
Message-ID: <20060221175043.GB23054@kroah.com>
References: <Pine.LNX.4.50.0602201652430.21145-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0602201652430.21145-100000@monsoon.he.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 04:55:37PM -0800, Patrick Mochel wrote:
> 
> Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
> 
> ---
> 
>  include/linux/pm.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> applies-to: 55ce8c6305fc70b1b544ce7365abd6054e9b5f61
> 7af37561812f4599841ade4abee067b808b40054
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 5be87ba..a7324ea 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -140,6 +140,7 @@ struct device;
> 
>  typedef struct pm_message {
>  	int event;
> +	u32 state;

Can we _please_ make this an enumerated type that is able to be
type-checked by sparse?  A "raw" u32 is not a good thing to have here.

thanks,

greg k-h
