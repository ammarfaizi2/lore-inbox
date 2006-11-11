Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947224AbWKKNQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947224AbWKKNQU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 08:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947226AbWKKNQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 08:16:20 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:595 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1947225AbWKKNQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 08:16:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=ScpHMNfN0ErzmmXYYOFyHOOufcMfmBkf54kW/tt+afNN5AVsNxOJ5EIBilwz2jGvTZRhLsZ5M8Zd1zLkjgRV9lhEipROwNGApMPD4g2vrhxHXtSeeRmfbXThuICYIgPJl5PeX+btg6xD1mlNfiVeFt8ajJ7FAVcJkFOo3arZQZ8=
Date: Sat, 11 Nov 2006 16:16:12 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Nicolas Kaiser <nikai@nikai.net>
Cc: linux-ide@vger.kernel.org, trivial@kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][TRIVIAL] drivers/ide: stray bracket
Message-ID: <20061111131612.GA4974@martell.zuzino.mipt.ru>
References: <20061111014756.3467d7ee@lucky.kitzblitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061111014756.3467d7ee@lucky.kitzblitz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2006 at 01:47:56AM +0100, Nicolas Kaiser wrote:
> Stray bracket in debug code.

> --- a/drivers/ide/legacy/hd.c	2006-09-20 05:42:06.000000000 +0200
> +++ b/drivers/ide/legacy/hd.c	2006-11-10 21:52:20.000000000 +0100
> @@ -459,7 +459,7 @@ ok_to_read:
>  #ifdef DEBUG
>  	printk("%s: read: sector %ld, remaining = %ld, buffer=%p\n",
>  		req->rq_disk->disk_name, req->sector, req->nr_sectors,
> -		req->buffer+512));
> +		req->buffer+512);
>  #endif

Just remove whole printk. It was broken for a looong time.

