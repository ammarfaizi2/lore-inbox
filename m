Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbWBRQBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWBRQBE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 11:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWBRQAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 11:00:42 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:17836 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751434AbWBRQAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 11:00:33 -0500
Date: Sat, 18 Feb 2006 16:51:04 +0100
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: greg@kroah.com, torvalds@osdl.org, akpm@osdl.org, linux-pm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] [PATCH 2/5] [pm] Add state field to pm_message_t (to hold actual state device is in)
Message-ID: <20060218155104.GD5658@openzaurus.ucw.cz>
References: <Pine.LNX.4.50.0602171757360.30811-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0602171757360.30811-100000@monsoon.he.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


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

We have had enough problems with u32s before... What about
char *, and pass real state names?
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

