Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132830AbRDDOp1>; Wed, 4 Apr 2001 10:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132831AbRDDOpI>; Wed, 4 Apr 2001 10:45:08 -0400
Received: from mail.inup.com ([194.250.46.226]:19211 "EHLO mailhost.lineo.fr")
	by vger.kernel.org with ESMTP id <S132830AbRDDOow>;
	Wed, 4 Apr 2001 10:44:52 -0400
Date: Wed, 4 Apr 2001 16:48:58 +0200
From: christophe barbe <christophe.barbe@lineo.fr>
To: Paul Jakma <paulj@itg.ie>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: uninteruptable sleep (D state => load_avrg++)
Message-ID: <20010404164858.A14009@pc8.inup.com>
In-Reply-To: <20010404141349.A6702@pc8.inup.com> <Pine.LNX.4.33.0104041518300.1150-100000@rossi.itg.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.33.0104041518300.1150-100000@rossi.itg.ie>; from paulj@itg.ie on mer, avr 04, 2001 at 16:20:04 +0200
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<skip>
I've unfortunately no significant Unix culture. 
I'm certainly young enough to be excused and by luck Linux shows me the road to the hacker heaven.
So now I move forward the good direction, trying to understand the POSIX stuff ....
</skip>

>From me, a POV without technical reasons is not a philosical one but more certainly an historical one.

Process that will be runnable are not participating to the load so why incrementing the load average.
Moreover if a process should be in state D only for a short time, the influence of the incrementation should be near null for an AVERAGE value.
So why doing that (I mean load++) if there's an influence only when a process stay in a D state for a long time (= when the only effect is to distort the load measure) ?

What's the technical reason behind this load_avrg++ ???

Christophe


On mer, 04 avr 2001 16:20:04 Paul Jakma wrote:
> On Wed, 4 Apr 2001, christophe barbe wrote:
> 
> > The sleep should certainly be interruptible and I that's what I
> > said to the GFS guy. But what the reason to increment the load
> > average for each D process ?
> 
> from a philosical POV: they are processes that will be runnable as
> soon as the kernel returns to them.
> 
> no idea if there are technical reasons for it.
> 
> >
> > Thanks,
> > Christophe
> 
> --paulj
> 
-- 
Christophe Barbé
Software Engineer
Lineo High Availability Group
42-46, rue Médéric
92110 Clichy - France
phone (33).1.41.40.02.12
fax (33).1.41.40.02.01
www.lineo.com
