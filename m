Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQKGIJu>; Tue, 7 Nov 2000 03:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129352AbQKGIJk>; Tue, 7 Nov 2000 03:09:40 -0500
Received: from oe28.law4.hotmail.com ([216.33.148.21]:27141 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S129345AbQKGIJ2>;
	Tue, 7 Nov 2000 03:09:28 -0500
X-Originating-IP: [63.197.4.216]
From: "Lyle Coder" <x_coder@hotmail.com>
To: "David Schwartz" <davids@webmaster.com>,
        "RAJESH BALAN" <atmproj@yahoo.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKEEAJLMAA.davids@webmaster.com>
Subject: Re: malloc(1/0) ??
Date: Tue, 7 Nov 2000 00:09:09 -0800
MIME-Version: 1.0
Content-Type: text/plain;	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Message-ID: <OE28zGnClQwSaY2lsLR00001672@hotmail.com>
X-OriginalArrivalTime: 07 Nov 2000 08:09:22.0699 (UTC) FILETIME=[096DCDB0:01C04892]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When a program does a malloc... the glibc gets atleast on page (brk)
[actually, glibs determins of it needs to brk more memory from the kernel...
because it maintains it;s own pool].. so if you malloc 4 byts, you can copy
to that pointer more than 4 bytes (upto a page size, ex 4K)... hope that
answers one of your questions... as far as why malloc(0) works... I dunno

Best Wishes,
Lyle
----- Original Message -----
From: "David Schwartz" <davids@webmaster.com>
To: "RAJESH BALAN" <atmproj@yahoo.com>; <linux-kernel@vger.kernel.org>
Sent: Monday, November 06, 2000 11:54 PM
Subject: RE: malloc(1/0) ??


> > hi,
> > why does this program works. when executed, it doesnt
> > give a segmentation fault. when the program requests
> > memory, is a standard chunk is allocated irrespective
> > of the what the user specifies. please explain.
> >
> > main()
> > {
> >    char *s;
> >    s = (char*)malloc(0);
> >    strcpy(s,"fffff");
> >    printf("%s\n",s);
> > }
> >
> > NOTE:
> >   i know its a 'C' problem. but i wanted to know how
> > this works
>
> The program does not work. A program works if it does what it's supposed
to
> do. If you want to argue that this program is supposed to print "ffffff"
> then explain to me why the 'malloc' contains a zero in parenthesis.
>
> The program can't possibly work because it invokes undefined behavior. It
> is impossible to determine what a program that invokes undefined behavior
is
> 'supposed to do'.
>
> DS
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
