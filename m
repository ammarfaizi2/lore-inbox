Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932547AbVHSJC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbVHSJC4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 05:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbVHSJC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 05:02:56 -0400
Received: from nproxy.gmail.com ([64.233.182.205]:2271 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932547AbVHSJCz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 05:02:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=liyAVzufXbNtMTkpmveQJT4+3c7tvXv6qsIFW8hPw/dlCV7CYKmyIdowvPvU1rcOHkwFpvddwBUTbd8jxM5iQiYGDSTx9GUY9GaTjqoe0rTV2ls6M36V0BkntZJe66wi8Ukw0tsZtC/xyCR93tkw9cZOi6poyAsKgXcqeeT66EM=
Message-ID: <58cb370e0508190202b0c5a5a@mail.gmail.com>
Date: Fri, 19 Aug 2005 11:02:53 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [git patches] ide update
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1124406535.20755.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.GSO.4.62.0508182332470.22579@mion.elka.pw.edu.pl>
	 <1124406535.20755.12.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Iau, 2005-08-18 at 23:37 +0200, Bartlomiej Zolnierkiewicz wrote:
> > +     },{     /* 14 */
> > +             .name           = "Revolution",
> > +             .init_hwif      = init_hwif_generic,
> > +             .channels       = 2,
> > +             .autodma        = AUTODMA,
> > +             .bootable       = OFF_BOARD,
> >       }
> 
> This seems rather odd - the driver asks for AUTODMA yet because its IDE
> generic contains no code to retune the device interface for DMA ?

It is fine, grep drivers/ide/setup-pci.c for "d->autodma".
You are confusing 'autodma' fields in ide_hwif_t and ide_pci_device_t.

> BTW whats the status on the CS5535 driver that someone submitted a while
> back ?

lkml.org/lkml/2005/1/27/20

AFAIK CS5535 driver was never ported to 2.6.x.  Somebody needs to
port it to 2.6.x kernel, cleanup to match kernel coding standards and test.

Bartlomiej
