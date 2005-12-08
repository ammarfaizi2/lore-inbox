Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbVLHTFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbVLHTFl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 14:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbVLHTFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 14:05:40 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:43525 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932253AbVLHTFk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 14:05:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QuAgmjrBwv+ewVEAHYTrFCw5dkBlC62fxucSLmMspqRJ0ZYAhR/W1urI026Isvni4sZho4oM6VUUxACz73q2I9V5BdrTRg0ejCe0uvdU/3J3sGHQl6g0GuucKhADUKsRFmyvenDL96UMElf21OyWlr6bu/czjZICj6K8aEAVMNE=
Message-ID: <58cb370e0512081105x68e855e4n98312b1f3a25abab@mail.gmail.com>
Date: Thu, 8 Dec 2005 20:05:37 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: =?ISO-8859-1?Q?Sebastian_K=E4rgel?= <mailing@wodkahexe.de>
Subject: Re: 2.6.{14,15-rc4} harddrive cache not detected
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051208194408.77e17f64.mailing@wodkahexe.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20051208194408.77e17f64.mailing@wodkahexe.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/05, Sebastian Kärgel <mailing@wodkahexe.de> wrote:
> Hello,
>
> after installing a new harddrive, the kernel does no longer detect the
> harddrives cache.
>
> Old one:
> ide0: BM-DMA at 0x1100-0x1107, BIOS settings: hda:DMA, hdb:pio
> hda: ST94019A, ATA DISK drive
> hda: 78140160 sectors (40007 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA
> (33)
>
> New one:
> ide0: BM-DMA at 0x1100-0x1107, BIOS settings: hda:DMA, hdb:pio
> hda: TOSHIBA MK4025GAS, ATA DISK drive
> hda: 78140160 sectors (40007 MB), CHS=65535/16/63, UDMA(33)
>
> Note, that there is nothing printed about the cache size.
> According to the manufactor the new harddrive should have 8mb cache.
> /proc/ide/ide0/hda/cache also show "0"
>
> hdparm gives the following:
> ...
> BuffType=unknown, BuffSize=0kB
> ...
>
> I verified this problem with 2.6.14 and 2.6.15-rc4.

I think that I've seen before some other Toshiba
disks that incorrectly report cache size.

Could you send /proc/ide/hda/identify?

Bartlomiej
