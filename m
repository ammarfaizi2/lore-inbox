Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbVKCJ5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbVKCJ5R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 04:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbVKCJ5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 04:57:17 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:58929 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932337AbVKCJ5R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 04:57:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sLUkKmx2LdgnUUVFxl5lwDMh+Euv1GZJrbJJNYqjmjITGKwIAYmnRKS6q5Nc1rDbO1kLZfR8E8MI/pBy5SPcnxlsNWAHlU9EDJ8XendLLkWNWflaNx4DbSBL0knHK9B1YrD6WMnAgH2+w3eiipjc9zhXDEH4XUnqUF3dOgNqfHw=
Message-ID: <58cb370e0511030157l5e47a15h25832fb98e46173a@mail.gmail.com>
Date: Thu, 3 Nov 2005 10:57:15 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] Incorrect device link for ide-cs
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
In-Reply-To: <4369D693.4040500@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4369D693.4040500@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>      hw_regs_t hw;
>      memset(&hw, 0, sizeof(hw));
> -    ide_init_hwif_ports(&hw, io, ctl, NULL);
> +    ide_std_init_ports(&hw, io, ctl);

Could you separate this into another patch?

This change fixes ide-cs for some archs but OTOH we should verify that
there are no ide-cs specific hacks in ide_init_hwif_ports() on other archs.

Otherwise patch looks fine.

Thanks,
Bartlomiej
