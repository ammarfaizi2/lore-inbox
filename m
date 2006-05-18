Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbWERWiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWERWiw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 18:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbWERWiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 18:38:52 -0400
Received: from terminus.zytor.com ([192.83.249.54]:5081 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750982AbWERWiw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 18:38:52 -0400
Message-ID: <446CF763.6020209@zytor.com>
Date: Thu, 18 May 2006 15:38:27 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Ingo Oeser <ioe-lkml@rameria.de>
CC: linux-kernel@vger.kernel.org,
       Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [PATCH] rtc subsystem, use ENOIOCTLCMD where appropriate
References: <20060517013033.10d08a8f@inspiron> <20060517232742.2ac4ccaa@inspiron> <e4ilgb$f10$1@terminus.zytor.com> <200605190032.25796.ioe-lkml@rameria.de>
In-Reply-To: <200605190032.25796.ioe-lkml@rameria.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> Hi Hans Peter,
> 
> H. Peter Anvin wrote
>> ENOIOCTLCMD is right here, *except* in the very last hunk, because
>> it's a request to the upper layers to emulate the operation:
> 
> So would a patch like this be welcome and clear this up?
> 
> diff --git a/include/linux/errno.h b/include/linux/errno.h
> index d90b80f..d33ae4b 100644
> --- a/include/linux/errno.h
> +++ b/include/linux/errno.h
> @@ -9,7 +9,7 @@
>  #define ERESTARTSYS	512
>  #define ERESTARTNOINTR	513
>  #define ERESTARTNOHAND	514	/* restart if no handler.. */
> -#define ENOIOCTLCMD	515	/* No ioctl command */
> +#define ENOIOCTLCMD	515	/* No ioctl command, upper layer please emulate or pass ENOTTY to user space */
>  #define ERESTART_RESTARTBLOCK 516 /* restart by calling sys_restart_syscall */
>  
>  /* Defined for the NFSv3 protocol */
> 

Sure, if people feel it's necessary.

	-hpa
