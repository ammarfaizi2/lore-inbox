Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbVLTDcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbVLTDcG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 22:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbVLTDcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 22:32:06 -0500
Received: from animx.eu.org ([216.98.75.249]:48556 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S1750771AbVLTDcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 22:32:05 -0500
Date: Mon, 19 Dec 2005 22:51:22 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Let non-root users eject their ipods?
Message-ID: <20051220035122.GA7233@animx.eu.org>
Mail-Followup-To: john stultz <johnstul@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <1135047119.8407.24.camel@leatherman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135047119.8407.24.camel@leatherman>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> All,
> 	I'm getting a little tired of my roommates not knowing how to safely
> eject their usb-flash disks from my system and I'd personally like it if

What exactly is ejecting flash media?

I have USB hard disks, USB Flash sticks, USB DVD-RAM, and an Ipod.  The only
one that even needs eject is the DVDRam.  IIRC, ALLOW_MEDIUM_MREMOVAL is for
CD-Rom (and possibly tape).  If the device is not in use, there's no reason
it cannot be unplugged then.  (Not in use as in not mounted, and noone's
accessing the raw device).

> diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
> --- a/block/scsi_ioctl.c
> +++ b/block/scsi_ioctl.c
> @@ -188,6 +188,9 @@ static int verify_command(struct file *f
>  		safe_for_write(GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL),
>  		safe_for_write(GPCMD_LOAD_UNLOAD),
>  		safe_for_write(GPCMD_SET_STREAMING),
> +
> +		/* let me eject my damn ipod */
> +		safe_for_read(ALLOW_MEDIUM_REMOVAL),
>  	};
>  	unsigned char type = cmd_type[cmd[0]];
>  
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
 Got Gas???
