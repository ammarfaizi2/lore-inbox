Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261978AbREPPPA>; Wed, 16 May 2001 11:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261984AbREPPOu>; Wed, 16 May 2001 11:14:50 -0400
Received: from comverse-in.com ([38.150.222.2]:57342 "EHLO
	eagle.comverse-in.com") by vger.kernel.org with ESMTP
	id <S261978AbREPPOd>; Wed, 16 May 2001 11:14:33 -0400
Message-ID: <6B1DF6EEBA51D31182F200902740436802678ED2@mail-in.comverse-in.com>
From: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
To: "'Joachim Backes'" <backes@rhrk.uni-kl.de>
Cc: LINUX Kernel <linux-kernel@vger.kernel.org>
Subject: RE: IRQ usage for PCI devices, Kernel 2.4.4
Date: Wed, 16 May 2001 11:13:40 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If your PCI devices advertised they don't mind sharing the IRQs with each
other, ignore it if they're really capable of it. Otherwise, you'll probably
have to force one of the drivers and/or the bios to make them use separate
ones.

> -----Original Message-----
> From: Joachim Backes [mailto:backes@rhrk.uni-kl.de]
> Sent: Wednesday, May 16, 2001 1:46 AM
> To: LINUX Kernel
> Subject: IRQ usage for PCI devices, Kernel 2.4.4
> 
> 
> Hi,
> 
> sometimes the following messages appear in /var/log/messages:
> 
>         May 13 14:24:41 sunny kernel: PCI: Found IRQ 10 for 
> device 00:0e.0
>         May 13 14:24:41 sunny kernel: PCI: The same IRQ used 
> for device 00:0a.0
> 
> "0e" is my PCI sound card, and "0a" is my PCI ethernet card. 
> The messages apppear in
> the following environment: I send from another linux machine 
> (per ssh) a command
> wich plays some sound on my sound card, therefore the eth0 
> event and the sound
> event occur at almost the same time.
> 
> Question: Can I ignore these messages, or is there any buggy 
> behaviour?
> 
> Regards
> 
> 
> Joachim Backes
> 
> --
> 
> Joachim Backes <backes@rhrk.uni-kl.de>       | Univ. of Kaiserslautern
> Computer Center, High Performance Computing  | Phone: 
> +49-631-205-2438 
> D-67653 Kaiserslautern, PO Box 3049, Germany | Fax:   
> +49-631-205-3056 
> ---------------------------------------------+------------------------
> WWW: http://hlrwm.rhrk.uni-kl.de/home/staff/backes.html  
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
