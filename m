Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263329AbVGANBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263329AbVGANBk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 09:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263330AbVGANBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 09:01:34 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:61028 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263329AbVGANB0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 09:01:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=emtTCguRCZoyrAvvWZ78Gw3l28dBLm64Gi0VMYAm/iDpvhe6ywYf98ZLDBVWZ8gpLmURCBTO2GJucTmlPp/kjAFEuSV4TY/EEHwXmZrthoeM36AaA75k4H9yNJ/xxnoSJB2FaYsDYOaWTcrTl9XRY2bMTKgyVqppTvdtfOW3pT4=
Message-ID: <f0cc385605070106017d05c0ff@mail.gmail.com>
Date: Fri, 1 Jul 2005 15:01:26 +0200
From: "M." <vo.sinh@gmail.com>
Reply-To: "M." <vo.sinh@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: reiser4 plugins
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/05, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> Markus   Törnqvist <mjt@nysv.org> wrote:
> > On Thu, Jun 23, 2005 at 11:34:50PM -0400, Horst von Brand wrote:
> > >David Masover <ninja@slaphack.com> wrote:
> > >> I think Hans (or someone) decided that when hardware stops working, it's
> > >> not the job of the FS to compensate, it's the job of lower layers, or
> > >> better, the job of the admin to replace the disk and restore from
> > >> backups.
>
> > >Handling other people's data this way is just reckless irresponsibility.
> > >Sure, you can get high performance if you just forego some of your basic
> > >responsibilities.
>
> > Your honest-to-bog opinion is that the FS vendor is responsible for
> > the admin not taking backups or the hardware vendor shipping crap?
>
> No. But just relying on perfect hardware and concientious sysadmins is
> reckless. Hardware /is/ flaky, sysadmins /are/ (sometimes) lazy (and
> besides, today they are increasingly just plain Joe Sixpack users). Also,
> backing up a few hundred GiB is /not/ fun, and then keeping track of all
> the backups is messy.
>
> Also, I'm not claiming that they are /solely/ responsible, but not having
> the filesystem fall apart utterly every time some bug breaths on it /is/ a
> requirement.
>
Bug ? We're speaking about bad blocks NOT bugs...

When your hard disk get a bad block you can't keep using it and rely
on the "badblocks-proof filesystem structure that prevents you to do
backups"..even with FAT, the simpler filesystem structure around, if
you keep using you disk you are likely going to loose some data (yes,
maybe not entire files). But, even with the metadata's richer
filesystem, if you detect the first badblock you can save almost
everything.

Does it really makes sense to design a filesystem in a way that gives
users some more time to use their filesystem from the first happened
badblock or it's better to focus on new features that give better
everyday use in terms of performance, functionalities, etc ?

And, are you sure that users who dont do and dont know they have to do
backups of sensitive data are able to recover a corrupted filesystem ?

> > *still trying to understand how that can be*
>
> You haven't been around too much yet, do you?
> --
> Dr. Horst H. von Brand                   User #22616 counter.li.org
> Departamento de Informatica                     Fono: +56 32 654431
> Universidad Tecnica Federico Santa Maria              +56 32 654239
> Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Michele
--
"Share your knowledge. It is a way to achieve immortality."
