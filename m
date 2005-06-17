Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261938AbVFQKro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbVFQKro (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 06:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVFQKrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 06:47:43 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:21513 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261938AbVFQKrm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 06:47:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mbg+CKtPzFc8Z1X44j6hZ0pREqSURMbA9DJYF1gZ3j8ugq7JQTxtFDeJ0Pr7dO/MbX+x7vmnJLnoTIglcm2/G79zf4FGRRJRYU1b99YHWtpdLCVmdH+IZeRFrckNJCpRdwct/v7iEKHSMrzyRI2U3HTx/pOpwVx6Lot7ZVM7sh8=
Message-ID: <b6fcc0a05061703472c19b7f2@mail.gmail.com>
Date: Fri, 17 Jun 2005 03:47:39 -0700
From: Alexey Dobriyan <adobriyan@gmail.com>
Reply-To: Alexey Dobriyan <adobriyan@gmail.com>
To: Donald.Huang@ite.com.tw
Subject: Re: iteraid.patch added to -mm tree
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <200506170053.j5H0rB6L009951@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200506170053.j5H0rB6L009951@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/05, akpm@osdl.org <akpm@osdl.org> wrote:
> 
> The patch titled
> 
>      ITE RAID driver
> 
> has been added to the -mm tree.

> +u8 IT8212GetChipStatus(uioctl_t * ioc)
> +{

> +	pPhyDiskInfo = kmalloc(sizeof(PHYSICAL_DISK_STATUS) * 4, GFP_KERNEL);
> +	if (pPhyDiskInfo == NULL) {
> +		printk("IT8212GetChipStatus: error kmalloc for "
> +				"PHYSCIAL_DISK_STATUS.\n");
> +		return -ENOMEM;
> +	}
> +	memset(pPhyDiskInfo, 0, sizeof(PHYSICAL_DISK_STATUS));

kmalloc or memset is right wrt size?

Expect patches to fix sparse warnings, remove useless comments,
typedef horrors and other misc stuff in a day or so.
