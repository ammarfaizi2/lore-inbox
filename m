Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264191AbTKSXxN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 18:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261151AbTKSXxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 18:53:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7329 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264191AbTKSXxL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 18:53:11 -0500
Message-ID: <3FBC0247.1000504@pobox.com>
Date: Wed, 19 Nov 2003 18:52:39 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Radford <adam@nmt.edu>
CC: marcelo.tosatti@cyclades.com, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.23-rc3 fix scsi disk targets over 1TB to not EIO
References: <200311192330.hAJNU0cV005517@speare5-1-13.nmt.edu>
In-Reply-To: <200311192330.hAJNU0cV005517@speare5-1-13.nmt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Radford wrote:
> diff -Naur linux-2.4.23-rc2/drivers/scsi/sd.c linux-2.4.23-rc3/drivers/scsi/sd.c
> --- linux-2.4.23-rc2/drivers/scsi/sd.c	Mon Aug 25 04:44:42 2003
> +++ linux-2.4.23-rc3/drivers/scsi/sd.c	Wed Nov 19 15:15:38 2003
> @@ -294,7 +294,8 @@
>  
>  static int sd_init_command(Scsi_Cmnd * SCpnt)
>  {
> -	int dev, block, this_count;
> +	int dev, this_count;
> +	unsigned long block;
>  	struct hd_struct *ppnt;
>  	Scsi_Disk *dpnt;
>  #if CONFIG_SCSI_LOGGING


What about u64 instead of unsigned long?

	Jeff



