Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310224AbSCFWas>; Wed, 6 Mar 2002 17:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310227AbSCFWaj>; Wed, 6 Mar 2002 17:30:39 -0500
Received: from mail.starbak.net ([63.144.91.12]:32531 "EHLO mail.starbak.net")
	by vger.kernel.org with ESMTP id <S310224AbSCFWaV>;
	Wed, 6 Mar 2002 17:30:21 -0500
Message-ID: <005e01c1c55d$d73b4260$5a5b903f@h90>
From: "Joseph Malicki" <jmalicki@starbak.net>
To: "David Woodhouse" <dwmw2@infradead.org>, "Jeff Dike" <jdike@karaya.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
        "Benjamin LaHaise" <bcrl@redhat.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <200203062025.PAA03727@ccure.karaya.com>  <6920.1015450061@redhat.com>
Subject: Re: [RFC] Arch option to touch newly allocated pages 
Date: Wed, 6 Mar 2002 17:25:37 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> jdike@karaya.com said:
> >  Yeah, MADV_DONTNEED looks right.  UML and Linux/s390 (assuming VM has
> > the equivalent of MADV_DONTNEED) would need a hook in free_pages to
> > make that happen.
>
>        MADV_DONTNEED
>               Do  not expect access in the near future.  (For the
>               time being, the application is  finished  with  the
>               given range, so the kernel can free resources asso­
>               ciated with it.)
>
> It's not clear from that that the host kernel is actually permitted to
> discard the data.

Solaris has MADV_FREE to say that the data can be discarded...

-joe

