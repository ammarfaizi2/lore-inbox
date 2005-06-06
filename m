Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbVFFPpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVFFPpr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 11:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVFFPpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 11:45:46 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:4253 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261504AbVFFPpj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 11:45:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lyTrLcBg1DWjuJ8k4xkwYKnowQJN7elzLutpfEXTcefpqPfwU6jrpFDKUS4zsF3JKEAFwypDjImrkorRJoJW8NysFXz+WJM3ojTDc5c9KbqMVPx2fw2f8wLG26i/lvmv20RWl//l7wKLJxzlUXcvc8pggQqBUtmn3phHIe2W/Ik=
Message-ID: <58cb370e05060608452a6a1ce0@mail.gmail.com>
Date: Mon, 6 Jun 2005 17:45:38 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: THESNIERES Sylvain <tmsec@free.fr>
Subject: Re: [2.6.11.10][Ali15x3] Crash at startup after disks detection in DMA66 mode
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1117806619.42a0601b371b8@imp5-q.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1117806619.42a0601b371b8@imp5-q.free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/05, THESNIERES Sylvain <tmsec@free.fr> wrote:
> Hello. I used the kernel 2.6.10-gentoo-rc9 with my notebook (Pentium 4-M, no
> trademark), it worked fine and I updated to 2.6.11.10 with fbsplash patch, and
> now DMA causes the system to crash at boot time. I can't dump any message,

Could you elaborate on "DMA causes the system to crash"?

Does 2.6.10-rc5 work for you?

> because my screen get flooded with the folowing one:
> 
> Free on bad allocation ressource <0000042>-<0000042>
> 
> It justs occurs after detection of the hard drive, and only if I activate
> idebus=66 or ata0=66 parameters on command line. I have enabled Ali15x3 support

You shouldn't be using "idebus=66" parameter unless your PCI bus is 66MHz.
There is no "ata0=66" parameter, maybe you've meant "ide0=66" ?

> on the kernel and DMA support. The problem disappears if I disable the 66 mode,
> but It worked before on the 2.6.10 kernel, so I don't think it is the same

dmesg output for 2.6.10 please

> problem as the one related to the last patch I saw for this driver:
> 
> [quote]
>     [PATCH] ide-disk: Fix LBA8 DMA
> 
>     This is from Gentoo's 2.6.11 patchset. A problem was introduced in 2.6.10
>     where some users could not enable DMA on their disks (particularly ALi15x3
>     users). This was a small mistake with the no_lba48_dma flag.
> [/quote]

Yep, this shouldn't be related.

Thanks,
Bartlomiej
