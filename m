Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129219AbQKXKwe>; Fri, 24 Nov 2000 05:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129153AbQKXKwY>; Fri, 24 Nov 2000 05:52:24 -0500
Received: from oe21.law11.hotmail.com ([64.4.16.125]:14094 "EHLO hotmail.com")
        by vger.kernel.org with ESMTP id <S129219AbQKXKwK>;
        Fri, 24 Nov 2000 05:52:10 -0500
X-Originating-IP: [24.164.154.68]
From: "Linux Kernel Developer" <linux_developer@hotmail.com>
To: "Ion Badulescu" <ionut@moisil.cs.columbia.edu>, <Andries.Brouwer@cwi.nl>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <200011240937.eAO9bo102035@moisil.dev.hydraweb.com>
Subject: Re: gcc-2.95.2-51 is buggy
Date: Fri, 24 Nov 2000 05:18:23 -0500
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Message-ID: <OE21fKcWrNgKx17x6MA00001b40@hotmail.com>
X-OriginalArrivalTime: 24 Nov 2000 10:22:04.0789 (UTC) FILETIME=[643A1250:01C05600]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Reading specs from /usr/lib/gcc-lib/i486-suse-linux/2.95.2/specs
> > gcc version 2.95.2 19991024 (release)
> > % /usr/bin/gcc -Wall -O2 -o bug bug.c; ./bug
> > 0x84800000
> > % /usr/gcc/aeb/bin/gcc -v
> > Reading specs from
/usr/gcc/aeb/lib/gcc-lib/i686-pc-linux-gnu/2.95.2/specs
> > gcc version 2.95.2 19991024 (release)
> > % /usr/gcc/aeb/bin/gcc -Wall -O2 -o nobug bug.c; ./nobug
> > 0x0
> >
> > So, not all versions of gcc 2.95.2 are equal.
>
> Interesting. Plain vanilla 2.95.2 from ftp.gnu.org exhibits the same
> bug on an BSDI2.1 i386 system.
>
> defiant ~/tmp$ gcc -v
> Reading specs from /usr/local/gnu/lib/gcc-lib/i386-pc-bsdi2.1/2.95.2/specs
> gcc version 2.95.2 19991024 (release)
> defiant ~/tmp$ gcc -O2 -o bug bug.c; ./bug
> 0x4800000
>
> Ion
>

    Don't know if anyone else has noticed this but from what I've seen
posted it appears, unless I missed something, the gcc 2.95.2s that have
exibited the bug were compiled for a 386 or a 486 while the one on which it
worked was a 686.  Perhaps the bug only appears on certain gcc
configurations.  Either the build configuration or the default optimization
method(s), if I remember correctly gcc optimizes for the platform (i.e.
i386, i486, i586, etc) it was configured for by default.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
