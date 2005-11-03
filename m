Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030347AbVKCPew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030347AbVKCPew (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030343AbVKCPem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:34:42 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:54330 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030341AbVKCPel convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:34:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h8GufZ/rYt1NspaB/St8i8WNiPnguxFs0xHTttl0C8cVvNxJsm4gxgRImnVI+g8s3RKXKgYt3vxaaTFNehjntTI8UqV3bxy2HIEbqch8qm1YBJk9bIJPAOiE4e3zqp+fOigYvhnnoHcQU7KHqIb3hlTbZqRPLjmlICb8r5mmjNE=
Message-ID: <58cb370e0511030734w632ca78fu8e46156397457da8@mail.gmail.com>
Date: Thu, 3 Nov 2005 16:34:39 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Parallel ATA with libata status with the patches I'm working on
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1131032974.18848.60.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1131029686.18848.48.camel@localhost.localdomain>
	 <58cb370e0511030658tb23cecds2ed8cc63570a68d5@mail.gmail.com>
	 <1131032974.18848.60.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Iau, 2005-11-03 at 15:58 +0100, Bartlomiej Zolnierkiewicz wrote:
> > On 11/3/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > > Core Features Fixed
> > > - Per drive tuning
> > > - Filter quirk lists
> > > - Single channel support
> >
> > Are these the same changes that have been recently pushed into
> > Linus' tree without any previous public review or some new ones?
>
> Some of the changes have gone to Jeff Garzik others are pending
> improvments/driver fixes for existing drivers and testing before Jeff
> accepts them. Beyond that its up to Jeff what is merged into -mm and on.

Of course it is up to Jeff but still it would be nice to see them on linux-ide
ML before hitting -mm or mainline...

> > > Drivers so far written for the libata parallel work I'm doing
> >
> > Are the patches available somewhere?
>
> Yes. I'll post updated sets at some point soon. The patch I posted
> pointers to before is now well out of date.
>
> > > AMD
> > > Driver written, given basic testing and equivalent to current
> > > drivers/ide
> >
> > Functionality can't be the same as drivers/ide because libata
> > lacks some core features.
>
> Well duh, other than core differences. Functionality is indeed different
> - CRC errors dont crash SMP boxes for example ;)
>
> > > CS5520
> > > Driver written, some debug work to do. Works unlike the drivers/ide one
> >
> > Please fix drivers/ide also if not a big problem.
>
> I started this work in part because it was impossible to work with you.

Yes, I don't ack patches only because name of the submitter... ;)

> I've no interest in fixing drivers/ide and in fact I'm now running as
> much as I can with CONFIG_IDE=n, because the only way to really test
> code is to use it all the time.
>
> The things I've fixed however if you want to go fix them in drivers/ide
> are
>
> CS5520 is totally broken. You want the fixes I sent you over a year ago
> and maybe more. Its probably best left as I doubt anyone else has a 5520
> any more 8)
>
> Serverworks runs the wrong cable detect routine in some cases
> (conditions ordered wrongly)

OK, thanks for the hint.

> I think the HPT366 driver contains several bugs looking at it in
> comparison with hpts driver and the data sheets I can get hold of. It's
> hard to be sure however because at times all three disagree with each
> other. In particular it doesn't know about 302N but think its a 37x and
> the PLL tune code appears to be unrelated to either data sheet or hpt
> code. Can't be sure yet on the PLL until I've got PLL modes working in
> the libata driver.
>
>
> Alan (drivers/ide elimination department)

I see... same goal here but in more peaceful way...

Bartlomiej
