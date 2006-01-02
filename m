Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbWABREt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWABREt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 12:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbWABREs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 12:04:48 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:5340 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1750894AbWABREr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 12:04:47 -0500
Date: Mon, 2 Jan 2006 10:04:47 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: dax@gurulabs.com, erich@areca.com.tw, akpm@osdl.org, arjan@infradead.org,
       oliver@neukum.org, rlrevell@joe-job.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2/2] Areca RAID driver (arcmsr) cleanups
Message-ID: <20060102170447.GG19769@parisc-linux.org>
References: <1135228831.4122.15.camel@mentorng.gurulabs.com> <1135229681.439.23.camel@mindpipe> <200512220917.41494.oliver@neukum.org> <1135239601.2940.5.camel@laptopd505.fenrus.org> <20051222052443.57ffe6f9.akpm@osdl.org> <1135279895.19320.24.camel@mentorng.gurulabs.com> <20051230113227.2b787d43.rdunlap@xenotime.net> <20051230212158.4b97edfe.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051230212158.4b97edfe.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2005 at 09:21:58PM -0800, Randy.Dunlap wrote:
>  /*
> -**********************************************************************************
> -**********************************************************************************
> +***************************************************************************
> +***************************************************************************
>  */

I'd be inclined to remove these useless comment blocks altogether ...

> -	/* allocate scsi host information (includes out adapter) scsi_host_alloc==scsi_register */
> +	/* allocate scsi host information (includes our adapter)
> +	 * scsi_host_alloc==scsi_register */
>  	if ((host =
>  	     scsi_host_alloc(&arcmsr_scsi_host_template,
>  			     sizeof(struct ACB))) == 0) {

host = scsi_host_alloc(...)
if (!host) { ...

>  	 ************************************************************
> -	 ** We do not allow muti ioctls to the driver at the same duration.
> +	 ** We do not allow multi ioctls to the driver at the same duration.

s/duration/time/.  And how do they prevent that?

