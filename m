Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWC0Ok3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWC0Ok3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 09:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbWC0Ok3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 09:40:29 -0500
Received: from pproxy.gmail.com ([64.233.166.179]:46891 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751045AbWC0Ok2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 09:40:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aOB8djEptMHyP8ttx2HQWaG0VbgZVyFES8IaEbO0Hvc96+dTM/LAx/Af/vx9pOQOHVzwpULXUWriw516VnQj4VRveWw+uFsfD8xCi5nq/rxM0e2N/jAxZelSNV3gYxeXVjoMHvD2VgL3XTRy296qsEExVWJhiIsj2bGM/U5bUiM=
Message-ID: <58cb370e0603270640v7c6070a9gb7dbd2aa5fcbbf98@mail.gmail.com>
Date: Mon, 27 Mar 2006 16:40:20 +0200
From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
To: "Sergei Shtylylov" <sshtylyov@ru.mvista.com>
Subject: Re: [2.6 patch] always enable CONFIG_PDC202XX_FORCE
Cc: "Adrian Bunk" <bunk@stusta.de>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <4427F5E7.1000108@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060122171239.GD10003@stusta.de> <4427F5E7.1000108@ru.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/06, Sergei Shtylylov <sshtylyov@ru.mvista.com> wrote:
> Hello.
>
> Adrian Bunk wrote:
>
> > This patch removes the CONFIG_PDC202XX_FORCE=n case.
>
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> > ---
> >
> > This patch was already sent on:
> > - 14 Jan 2006
> >
> >  drivers/ide/Kconfig            |    7 -------
> >  drivers/ide/pci/pdc202xx_new.c |    6 ------
> >  drivers/ide/pci/pdc202xx_old.c |   15 ---------------
> >  3 files changed, 28 deletions(-)
>
> [skipped]
>
> > --- linux-2.6.15-mm4-full/drivers/ide/pci/pdc202xx_old.c.old  2006-01-14 20:44:01.000000000 +0100
> > +++ linux-2.6.15-mm4-full/drivers/ide/pci/pdc202xx_old.c      2006-01-14 20:44:21.000000000 +0100
> > @@ -786,9 +786,6 @@
> >               .init_dma       = init_dma_pdc202xx,
> >               .channels       = 2,
> >               .autodma        = AUTODMA,
> > -#ifndef CONFIG_PDC202XX_FORCE
> > -             .enablebits     = {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
> > -#endif
> >               .bootable       = OFF_BOARD,
> >               .extra          = 16,
> >       },{     /* 1 */
> > @@ -799,9 +796,6 @@
> >               .init_dma       = init_dma_pdc202xx,
> >               .channels       = 2,
> >               .autodma        = AUTODMA,
> > -#ifndef CONFIG_PDC202XX_FORCE
> > -             .enablebits     = {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
> > -#endif
> >               .bootable       = OFF_BOARD,
> >               .extra          = 48,
> >               .flags          = IDEPCI_FLAG_FORCE_PDC,
>
>     A late question: wasn't that IDEPCI_FLAG_FORCE_PDC flag there for the same
> purpose -- to bypass enablebits check? Wasn't it enough?

It was for the same purpose but it wasn't enough,
now this flag can die...

Bartlomiej
