Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLKIVN>; Mon, 11 Dec 2000 03:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbQLKIVD>; Mon, 11 Dec 2000 03:21:03 -0500
Received: from nycsmtp3fb.rdc-nyc.rr.com ([24.29.99.80]:28433 "EHLO nyc.rr.com")
	by vger.kernel.org with ESMTP id <S129345AbQLKIU5>;
	Mon, 11 Dec 2000 03:20:57 -0500
Message-ID: <000b01c06346$f8680100$0ac809c0@hotmail.com>
From: "Anthony Barbachan" <barbacha@Hinako.AMBusiness.com>
To: "Peter Samuelson" <peter@cadcamlab.org>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <001f01c06323$db434d00$0ac809c0@hotmail.com> <20001211001723.Z6567@cadcamlab.org>
Subject: Re: Unable to compile the 2.2.18 kernel
Date: Mon, 11 Dec 2000 02:50:02 -0500
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.  I missed that this time when I modified the Makefile.  I didn't pay
close attention to the new script code in there to check for the kernel
compiler.


----- Original Message -----
From: "Peter Samuelson" <peter@cadcamlab.org>
To: "Anthony Barbachan" <barbacha@hinako.ambusiness.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>; "Linux Kernel Mailing List"
<linux-kernel@vger.kernel.org>
Sent: Monday, December 11, 2000 1:17 AM
Subject: Re: Unable to compile the 2.2.18 kernel


>
> [Anthony Barbachan]
> > I am unable to compile the latest kernel.  I have attached my kernel
> > configuration and a copy of the output of where the compile fails.  I
> > am looking into what is causing the compile failure, but have not
> > been able to figure it out yet.  Still looking though.
>
> It looks like you overrode the 'CC' make variable, either by editing
> the toplevel Makefile or at the command line.  This works fine in 2.4,
> but in 2.2 you need to pass extra flags to the compiler:
>
>   make zImage
CC="/usr/local/gcc-2.7.2.3/bin/gcc -I$(pwd)/include -D__KERNEL__"
>
> ...for example.
>
> Peter
>


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
