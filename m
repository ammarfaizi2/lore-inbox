Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129150AbQKUPGx>; Tue, 21 Nov 2000 10:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129752AbQKUPGo>; Tue, 21 Nov 2000 10:06:44 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:42131 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129150AbQKUPG0>; Tue, 21 Nov 2000 10:06:26 -0500
Date: Tue, 21 Nov 2000 15:31:36 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Benjamin.Monate@lri.fr, linux-kernel@vger.kernel.org
Subject: Re: Strange lockup of the timer with 2.4.0-test10 SMP (and older)
In-Reply-To: <E13xvRr-0003u9-00@the-village.bc.nu>
Message-ID: <Pine.GSO.3.96.1001121151759.19886A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2000, Alan Cox wrote:

> > a lock of the PCI bus (as SCSI and NIC are still working). Only the
> > timer interrupts and NMI seem to be stuck : can a driver cause
> > something so "lowlevel" ?
> 
> Something stopping the timers on the APIC I guess. But quite what or how I
> don't know

 I guess not -- the timer interrupt and the NMI use different I/O APIC
inputs.  If both are stuck, it's probably 8254 that gets reprogrammed.  I
suppose XFree86 might be at fault -- does it happen with the NMI watchdog
disabled, either? 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
