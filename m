Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129091AbQKWUJZ>; Thu, 23 Nov 2000 15:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130113AbQKWUJP>; Thu, 23 Nov 2000 15:09:15 -0500
Received: from ext.lri.fr ([129.175.15.4]:11908 "EHLO ext.lri.fr")
        by vger.kernel.org with ESMTP id <S129091AbQKWUJG>;
        Thu, 23 Nov 2000 15:09:06 -0500
From: "Benjamin Monate <Benjamin Monate" <Benjamin.Monate@lri.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <14877.29271.211561.467359@sun-demons>
Date: Thu, 23 Nov 2000 20:39:03 +0100 (MET)
To: linux-kernel@vger.kernel.org
Subject: Re: Strange lockup of the timer with 2.4.0-test10 SMP (and older)
In-Reply-To: <Pine.GSO.3.96.1001123183522.6381H-100000@delta.ds2.pg.gda.pl>
In-Reply-To: <14875.38318.5084.502248@sun-demons>
        <Pine.GSO.3.96.1001123183522.6381H-100000@delta.ds2.pg.gda.pl>
X-Mailer: VM 6.62 under Emacs 20.7.1
Reply-To: Benjamin.Monate@lri.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dans son message du Thu 23 November, Maciej W. Rozycki ecrit : 
>  Hmm, your BIOS reports the timer IRQ is directly connected...
> > Int: type 0, pol 3, trig 3, bus 2, IRQ 09, APIC ID 2, APIC INT 09
>  This is weird for an ISA IRQ.

Remember that I have TWO PCI buses and one ISA Bus.

>
> > ENABLING IO-APIC IRQs
> > ...changing IO-APIC physical APIC ID to 2 ... ok.
> > BIOS bug, IO-APIC#1 ID 3 is already used!...
> > ... fixing up to 1. (tell your hw vendor)
> > ...changing IO-APIC physical APIC ID to 1 ... ok.
>  This is annoying but Linux recovers from it...

Yes. I had to patch 2.4.0pre2 to be able to boot, but now it boots
unpatched. 
Why do you mean by "annoying" ? I thought this was just an
initialization problem.
By the way, my BIOS has an option to choose between MP 1.4 or older 
specifications. Changing it has not changed anything to the problem.

 
> > ..TIMER: vector=49 pin1=2 pin2=0
> > ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> > ...trying to set up timer (IRQ0) through the 8259A ... 
> > ..... (found pin 0) ...works.
> 
>  At the moment I can't see any reason of this failure apart from pin1
> being unconnected.  But why would it be?  I'll prepare a debugging patch
> which might help finding the real cause and I'll send it to you soon.

Okay. Thank you very much.

>  BTW, have you checked if there is a BIOS update for your system?

I will check that with Asus. At this time I have BIOS 1002.

-- 
| Benjamin Monate         | mailto:Benjamin.Monate@lri.fr |
| LRI - Bât. 490
| Université de Paris-Sud
| F-91405 ORSAY Cedex    

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
