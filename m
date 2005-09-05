Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbVIEH1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbVIEH1H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 03:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbVIEH1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 03:27:06 -0400
Received: from nproxy.gmail.com ([64.233.182.207]:31209 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932268AbVIEH1F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 03:27:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c/IoGaOOr6k2FvTFuopGs2og/j/JwSyr4/kHeSJ8hYjeDUCfcKUgVhpfiqiiaRytodJdBA9IA4q/4CO8Z2aSTgXE/jLlD9T7trkHatWqar1B/uD5Ppgfs5CmOPjPS76+mdrl04fJ0TlHrQQjDzN0uBkrM00mRgc6YloyG17bc7w=
Message-ID: <58cb370e050905002630a0e02e@mail.gmail.com>
Date: Mon, 5 Sep 2005 09:26:57 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: Linux Kernel 2.6.13-rc7 (WORKS) (2.6.13, DRQ/System CRASH)
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, support@promise.com,
       linux-ide@vger.kernel.org, apiszcz@lucidpixels.com
In-Reply-To: <Pine.LNX.4.63.0508311408320.1945@p34>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.63.0508311328230.1945@p34>
	 <Pine.LNX.4.63.0508311408320.1945@p34>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/05, Justin Piszcz <jpiszcz@lucidpixels.com> wrote:
> I do not even have IDE Taskfile Access enabled, so how is the kernel
> printing these error messages before it freezes?
> 
> linux-2.6.13/drivers/ide/ide-taskfile.c:                printk(KERN_ERR
> "%s: no DRQ after issuing %sWRITE%s\n",
> 
> 
>    lqqqqqqqqqqqqqqqqqqqqqqq ATA/ATAPI/MFM/RLL support qqqqqqqqqqqqqqqqqqqqqqqk
>    x x[ ]     IDE Taskfile Access

After DMA timeout driver reverted back to PIO,
ide-taskfile.c also holds PIO code besides IDE Taskfile Access.

Bartlomiej
