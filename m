Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129166AbQKTSla>; Mon, 20 Nov 2000 13:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129205AbQKTSlU>; Mon, 20 Nov 2000 13:41:20 -0500
Received: from ext.lri.fr ([129.175.15.4]:37585 "EHLO ext.lri.fr")
	by vger.kernel.org with ESMTP id <S129166AbQKTSlI>;
	Mon, 20 Nov 2000 13:41:08 -0500
From: "Benjamin Monate <Benjamin Monate" <Benjamin.Monate@lri.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <14873.26936.500547.975636@sun-demons>
Date: Mon, 20 Nov 2000 19:11:04 +0100 (MET)
To: linux-kernel@vger.kernel.org
Subject: Re: Strange lockup of the timer with 2.4.0-test10 SMP (and older)
In-Reply-To: <3A196CD9.AB946AD3@onetelnet.fr>
In-Reply-To: <14868.3329.775330.576681@sun-demons>
	<3A15CE34.EF2FE3CC@uow.edu.au>
	<14873.17358.536711.2282@sun-demons>
	<3A196CD9.AB946AD3@onetelnet.fr>
X-Mailer: VM 6.62 under Emacs 20.7.1
Reply-To: Benjamin.Monate@lri.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dans son message du Mon 20 November, Fort David ecrit : 
> > Further investigations showed that the problem will occur only when
> > Xfree 4.0.1 is running with an smp kenel . Xfree 3.3.6 is ok. Could this
> > be a bug in X ?  I thought that the kernel should prevent such a bug
> > from locking the computer.
> What 's your video card ? Not something running with closed source drivers ?
> (namely G-force)
> The kernel cannot prevent drivers from locking PCI/AGP bus.

My video card is a matrox G200SD, source is open. I will try another
video card tomorow.  I do understand that the kernel cannot prevent a
driver from locking then PCI bus : the timer lockup does not look like
a lock of the PCI bus (as SCSI and NIC are still working). Only the
timer interrupts and NMI seem to be stuck : can a driver cause
something so "lowlevel" ?

By the way, the processors are not overclocked.
I don't know how to check if something is overheating. Both fans seem okay
to me.

Do you any way to somehow "restart" (is it unmask ?) the timer IRQ
work and the NMI ? This would at least avoid some long fsck on
reboot...

Many thanks

-- 
| Benjamin Monate         | mailto:Benjamin.Monate@lri.fr |
| LRI - Bât. 490
| Université de Paris-Sud
| F-91405 ORSAY Cedex    

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
