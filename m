Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129426AbQKUQ6E>; Tue, 21 Nov 2000 11:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129942AbQKUQ5y>; Tue, 21 Nov 2000 11:57:54 -0500
Received: from ext.lri.fr ([129.175.15.4]:58504 "EHLO ext.lri.fr")
	by vger.kernel.org with ESMTP id <S129426AbQKUQ5k>;
	Tue, 21 Nov 2000 11:57:40 -0500
From: "Benjamin Monate <Benjamin Monate" <Benjamin.Monate@lri.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <14874.41589.359267.717984@sun-demons>
Date: Tue, 21 Nov 2000 17:27:33 +0100 (MET)
To: linux-kernel@vger.kernel.org
Subject: Re: Strange lockup of the timer with 2.4.0-test10 SMP (and older)
In-Reply-To: <Pine.GSO.3.96.1001121151759.19886A-100000@delta.ds2.pg.gda.pl>
In-Reply-To: <E13xvRr-0003u9-00@the-village.bc.nu>
	<Pine.GSO.3.96.1001121151759.19886A-100000@delta.ds2.pg.gda.pl>
X-Mailer: VM 6.62 under Emacs 20.7.1
Reply-To: Benjamin.Monate@lri.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  I guess not -- the timer interrupt and the NMI use different I/O APIC
> inputs.  If both are stuck, it's probably 8254 that gets reprogrammed.  I
> suppose XFree86 might be at fault -- does it happen with the NMI watchdog
> disabled, either? 
Yes. I just enabled the nmi watchdog to try to debug the problem. It did 
not change anything.

About the 8254, the kernel log contains :

Nov 20 17:15:15 pc8-118 kernel: MP-BIOS bug: 8254 timer 
				not connected to IO-AP
IC
Nov 20 17:15:15 pc8-118 kernel: ...trying to set up timer (IRQ0)
						 through the 8259A ...  
Nov 20 17:15:15 pc8-118 kernel: ..... (found pin 0) ...works.

But this does not seem to annoy the kernel.

Is there anyway to restore the 8254 to a valid state without rebooting ?


-- 
| Benjamin Monate         | mailto:Benjamin.Monate@lri.fr |
| LRI - Bât. 490
| Université de Paris-Sud
| F-91405 ORSAY Cedex    

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
