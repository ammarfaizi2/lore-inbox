Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267460AbUG2H3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267460AbUG2H3o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 03:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267467AbUG2H3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 03:29:43 -0400
Received: from web21122.mail.yahoo.com ([216.136.227.178]:38228 "HELO
	web21122.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267460AbUG2H26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 03:28:58 -0400
Message-ID: <20040729072852.67823.qmail@web21122.mail.yahoo.com>
Date: Thu, 29 Jul 2004 09:28:52 +0200 (CEST)
From: =?iso-8859-1?q?Eva=20Dominguez?= <evadom2002@yahoo.es>
Subject: SOLVED_aditional parallel port problems
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi everybody!

 I attach below, in this mail, what was my problem.
 The solution was that the parallel port of the card
didn't have any ground pin! The card have two serial
ports and they both have a ground pin (pin number 5).
So, we connected the ground pins of parallel port
(from 18 to 25) to the ground pin of one of the serial
ports.
And....everything works!
 I cant believe it! How this parallel port has been
built?

 Eva



 --- Eva Dominguez <evadom2002@yahoo.es> escribió: 
> Fecha:	Thu, 22 Jul 2004 11:01:06 +0200 (CEST)
> De:	Eva Dominguez <evadom2002@yahoo.es>
> Asunto: aditional parallel port problems
> Para:	linux-kernel@vger.kernel.org
> 
> Hi everybody!
> 
>  Firstable, I have to say that my problem is a
> Hardware problem, so, if you think this is not the
> proper forum,tell me please.
> 
>  My situation is like this: I have a "hand-made"
> circuit that works with the orders of a parallel
> port
> from PC. With this orders, the circuit turn on/off
> several devices connected to it. 
> 
>  I work with a PC with Suse9.0 (kernel
> 2.4.21-226-default) with an aditional parallel port
> in
> a PCI Multio I/O card with NM9835CV chip.
> 
>  Besides, I have a C program that send (outb, iopl,
> ioperm...)the orders to the address of the parallel
> port I say.
> 
>  My problem is: when I run this C program with the
> motherboard paralell port (lp0) the circuit works
> properly. But, it doesnt work with the aditional
> parallel port of the card (lp1)
> 
>  I write in this list because I have changed de
> operating system some days ago. I had RedHat6.2
> (kernel 2.2) and everything worked perfectly with
> the
> same card. I have bought other cards but nothing.
> 
>  I have seen some things:
> 
>   1. With de PC TURNED ON and TURNED OFF, if I
> conect
> the circuit with the motherboard parallel port (lp0)
> 
> some devices turn on and other turn off. But when if
> connect the circuit with the parallel port of the
> card
> (lp1) different devices turn on/off. All of this
> happens without executing eny program, only
> connecting
> the ports and the circuit with a bus.
>  It seems to be the internal circuits of eacb port.
>  Could it be the cause that nothing works? in this
> case...how can I change that?
> 
>   2. The card is "Multi-mode (SPP, EPP, ECP, PS2)".
> Is
> possible that the circuit only works with SPP mode.
> I
> can change the motherboard parallel port mode (with
> BIOS) but , how can I change the parallel port mode
> of
> the card?
> 
>   3. Before all this, I have tested the parallel
> port
> address of the card and the irq of the slot and I
> have
> added to /etc/modules.conf the line:
>     "options parport_pc io=0x378,0x8800 irq=7,5"
>      Later, I have connected a printer to the
> pararallel port of the card and it prints right.
>      Could the printer force the parallel port of
> the
> card to change its own mode to ECP or EPP? If I
> connect a SPP device, could it force that port to
> change its mode to SPP and everything works?
> 
>   4. I have changed the slot of the card and nothing
> happens.
> 
>   5. The command "dmesg | grep parport" displays:
> 
>     "parport0: PC-style at 0x378 irq 7 [PCSPP,
> TRISTATE, EPP]" (Is this line telling me the mode of
> the parallel port?? in this case...what does it
> mean?)
>     "parport1: PC-style at 0x8800 irq 5 [PCSPP,
> TRISTATE, EPP]"
>     "lp0: using parport0 (interrupt-driven)"
>     "lp1: using parport1 (polling)"
>     
>   6. I have seen in this mailing list an email about
> two patches (00_parport and 01_netmos) to work with
> this kind of chips. I have never installed patches
> and
> I dont find help about it. I am not so sure that
> this
> patches are the solution of my problem
> 
> 
>   This is the end of my "little" email.
>   Thank you very much!!
> 
>   Eva
> 
> 
> 
> 
> 
> 
> 
> 		
> ______________________________________________
> Yahoo! lanza su nueva tecnología de búsquedas
> ¿te atreves a comparar?
> http://busquedas.yahoo.es
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>  


		
______________________________________________
Yahoo! lanza su nueva tecnología de búsquedas
¿te atreves a comparar?
http://www.viralbusquedas.yahoo.es
