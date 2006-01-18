Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWARMDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWARMDw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 07:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbWARMDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 07:03:52 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:38040 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S964822AbWARMDw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 07:03:52 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Wed, 18 Jan 2006 13:03:37 +0100
Subject: Re: [PATCH] synclink_gt fix size of register value storage
To: Paul Fulghum <paulkf@microgate.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-reply-to: <1137515718.3403.5.camel@amdx2.microgate.com>
Message-Id: <20060118120337.9AB3522B3C4@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum wrote:
> Fix incorrect variable size used to hold
> register value. This bug might wipe out a portion of the
> TCR value when setting the interface options.
> 
> Signed-off-by: Paul Fulghum <paulkf@microgate.com>
> 
> 
> --- linux-2.6.16-rc1/drivers/char/synclink_gt.c	2006-01-17 09:31:20.000000000 -0600
> +++ linux-2.6.16-rc1-mg/drivers/char/synclink_gt.c	2006-01-17 10:22:48.000000000 -0600
> @@ -2630,7 +2630,7 @@ static int get_interface(struct slgt_inf
>  static int set_interface(struct slgt_info *info, int if_mode)
>  {
>   	unsigned long flags;
> -	unsigned char val;
> +	unsigned short val;
Shouldn't be this u16 rather than ushort?

regards,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
