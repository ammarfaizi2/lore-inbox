Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271978AbRIDPie>; Tue, 4 Sep 2001 11:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271981AbRIDPiY>; Tue, 4 Sep 2001 11:38:24 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:27285 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S271978AbRIDPiS>; Tue, 4 Sep 2001 11:38:18 -0400
Date: Tue, 4 Sep 2001 08:40:48 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: <joelja@twin.uoregon.edu>
To: Fred <fred@arkansaswebs.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <rastos@woctni.sk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Should I use Linux to develop driver for specialized ISA card?
In-Reply-To: <01090410264000.14864@bits.linuxball>
Message-ID: <Pine.LNX.4.33.0109040834440.25739-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fred, I'd check out the faq on rtlinux...

           "Worst-case times are
           about 15microseconds between the assertion of an interrupt
           and the starting of the realtime handler on a generic x86
           PC"

there where patches in the 2.2 era (some kind of midi related flamefest
occured at that time) that would take the average in a 2.2 kenel down to
25Us but the worst case was still fairly large...

what a rtos buys is not generally performance but a much higher
level determinism than what we can arrive at.

joelja

On Tue, 4 Sep 2001, Fred wrote:

> I'm  curious, Alan, Why? I'm a hardware developer, and I would have assumed
> that linux would have been ideal for real time / embedded projects? (routers
> / controllers / etc.) Is there, for instance, a reason to suspect that linux
> would not be able to respond to interrupts at say 8Khz?
> of course I know nothing of rtlinux so I'll read.
>
> TIA
> Fred
>
>
>  _________________________________________________
> On Tuesday 04 September 2001 10:15 am, Alan Cox wrote:
> > > The moving parts of the plotter are controlled by ISA card that generates
> > > (and responds to) interrupts on each movement or printing event.
> > > The interrupts can be generated quite fast; up to frequency of 4kHz.
> >
> > Thats fine. The issue you might need to consider is how long you can wait
> > between an irq and actually excuting the handler. If that is very tight
> > then you may want Victor Yodaiken's rtlinux
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
--------------------------------------------------------------------------
Joel Jaeggli				       joelja@darkwing.uoregon.edu
Academic User Services			     consult@gladstone.uoregon.edu
     PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E
--------------------------------------------------------------------------
It is clear that the arm of criticism cannot replace the criticism of
arms.  Karl Marx -- Introduction to the critique of Hegel's Philosophy of
the right, 1843.



