Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965202AbWEaWQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965202AbWEaWQM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 18:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965208AbWEaWQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 18:16:11 -0400
Received: from mail.tmr.com ([64.65.253.246]:63686 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S965202AbWEaWQK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 18:16:10 -0400
Message-ID: <447E161B.6060206@tmr.com>
Date: Wed, 31 May 2006 18:18:03 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.2) Gecko/20060405 SeaMonkey/1.0.1
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>,
       Linux Kernel M/L <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Make procfs obligatory except under CONFIG_EMBEDDED
References: <200605292207.k4TM722M027624@terminus.zytor.com>
In-Reply-To: <200605292207.k4TM722M027624@terminus.zytor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> From: H. Peter Anvin <hpa@zytor.com>
> 
> This patch makes procfs non-optional unless EMBEDDED is set, just like
> sysfs.  procfs is already de facto required for a large subset of
> Linux functionality.

I have no objection, but I'm curious why this wasn't done long ago.
> 
> Signed-off-by: H. Peter Anvin <hpa@zytor.com>
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 71d6b30..2c3a733 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -764,7 +764,8 @@ endmenu
>  menu "Pseudo filesystems"
>  
>  config PROC_FS
> -	bool "/proc file system support"
> +	bool "/proc file system support" if EMBEDDED
> +	default y
>  	help
>  	  This is a virtual file system providing information about the status
>  	  of the system. "Virtual" means that it doesn't take up any space on

