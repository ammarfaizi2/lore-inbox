Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318897AbSHEVpB>; Mon, 5 Aug 2002 17:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318898AbSHEVpB>; Mon, 5 Aug 2002 17:45:01 -0400
Received: from mail.zmailer.org ([62.240.94.4]:11992 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S318897AbSHEVpA>;
	Mon, 5 Aug 2002 17:45:00 -0400
Date: Tue, 6 Aug 2002 00:48:35 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Paul Larson <plars@austin.ibm.com>
Cc: davej@suse.de, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.30-dj1
Message-ID: <20020805214835.GP32427@mea-ext.zmailer.org>
References: <Pine.NEB.4.44.0208051638340.27501-100000@mimas.fachschaften.tu-muenchen.de> <1028579086.19435.31.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1028579086.19435.31.camel@plars.austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2002 at 03:24:43PM -0500, Paul Larson wrote:
> Trivial fix for sym53c8xx driver breakage when 
> CONFIG_BROKEN_SCSI_ERROR_HANDLING is turned off.

  Wrong.   You are trying to place your "fix" within
  a  #define  statement.  No can do.

> Thanks,
> Paul Larson
> 
> --- linux-dj/drivers/scsi/sym53c8xx.h	Mon Aug  5 15:42:11 2002
> +++ linux-dj-symfix/drivers/scsi/sym53c8xx.h	Mon Aug  5 15:41:43 2002
> @@ -89,8 +89,10 @@
>  			release:        sym53c8xx_release,	\
>  			info:           sym53c8xx_info, 	\
>  			queuecommand:   sym53c8xx_queue_command,\
> +#ifdef CONFIG_BROKEN_SCSI_ERROR_HANDLING
>  			abort:          sym53c8xx_abort,	\
>  			reset:          sym53c8xx_reset,	\
> +#endif
>  			bios_param:     scsicam_bios_param,	\
>  			can_queue:      SCSI_NCR_CAN_QUEUE,	\
>  			this_id:        7,			\
> 
