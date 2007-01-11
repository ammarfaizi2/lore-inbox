Return-Path: <linux-kernel-owner+w=401wt.eu-S1030189AbXAKCAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbXAKCAw (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 21:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030198AbXAKCAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 21:00:52 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:12208 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030189AbXAKCAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 21:00:51 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ggGwwR/dehH3cR2AFPVVvrc7M7mM/AUXpNg0OVJBagw7aM8rzhWAwBt7QkP/wSmlyO2+6N5z9K1prqSEUT8++IPwF6GveLe7ee+MZCW1q41sDSGS/u9dj+u8Jgzt5H3PmkQA3Hq0se7rVkZF1zzuibb/FbQ4s6Ot4eD80628wDk=
Message-ID: <58cb370e0701101800v19496013w9fa2e496949d4e40@mail.gmail.com>
Date: Thu, 11 Jan 2007 03:00:49 +0100
From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
To: "meaty biscuit" <meatybiscuit@gmail.com>
Subject: Re: DMA problems in ide-scsi
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <948ae28c0701101653n572d0c63n2145e9b4208a6e5b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <948ae28c0701101559j1e750d61g1f810feb04c1c4fb@mail.gmail.com>
	 <948ae28c0701101653n572d0c63n2145e9b4208a6e5b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/11/07, meaty biscuit <meatybiscuit@gmail.com> wrote:
> I know there are lots of people that are glad to be done with
> ide-scsi, but I'm hoping there is someone out there that has some
> experience with this driver that my be able to help.  I would happily
> switch modules and start using ide-cd, but I have a few pieces of
> software that rely on ide-scsi to work properly and I don't have
> enough time to change my software to work with ide-cd before my
> product release deadline.
>
> I am working with a mainline kernel, version 2.6.15.7 (I cannot change
> kernel versions either).  If DMA is enabled and I try to write to a
> CD, I get a kernel panic.  However, reading from a CD with DMA enabled
> works fine.  If DMA is disabled and programmed IO is used, I can both
> read and write CDs but the fact that PIO uses so much of the CPU
> causes my application to have some problems and again, I don't have
> time to go through several application release cycles to make them
> work with PIO.
>
> I have noticed that writing to CD (with DMA enabled) in 2.6.9 works
> fine, it seems as though the breakage of ide-scsi occured in 2.6.10.
> Also, burning a CD using DMA with ide-scsi in 2.6.19 seems to work as

If it works fine in the current kernels it seems like the problem
is not kernel bug but the fact that you are stuck on 2.6.15.7.

> well.  I have looked through the ide-scsi code for hours, and I have
> also done a fair amount of debugging looking for the problem but I
> have had no success.  I tried contacting Bartlomiej and have been
> unsuccessful in getting a hold of him.  Does anyone know of a patch

I've just read your mail from Jan 4 (was on TODO).
[ sorry but ide-scsi problems are (very) low priority ]

> floating around that may fix this problem?  Does anyone that is more
> familiar with the ide, scsi, or dma subsystems have any suggestions
> for me?  I am willing to put in the time and effort to fix this
> problem and I would be more than happy to submit a fix back into the
> open source world, but I am stuck and need any help I can get.

If you send me the log/photo of the kernel panic I might be able to help you.

Bart
