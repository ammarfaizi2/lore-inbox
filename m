Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130491AbQKJRLV>; Fri, 10 Nov 2000 12:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131034AbQKJRLL>; Fri, 10 Nov 2000 12:11:11 -0500
Received: from maho3msx2.isus.emc.com ([168.159.208.81]:48910 "EHLO
	maho3msx2.isus.emc.com") by vger.kernel.org with ESMTP
	id <S130491AbQKJRK4>; Fri, 10 Nov 2000 12:10:56 -0500
Message-ID: <51FA50304EBCD2119EEC00A0C9F2C9D0B1C446@ITMI1MX1>
From: Ballabio_Dario@emc.com
To: jgarzik@mandrakesoft.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: PATCH:  Pcmcia/Cardbus/xircom_tulip in 2.4.0-test10.
Date: Fri, 10 Nov 2000 12:10:38 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tested test11-pre2 and there is no improvement. I still need to issue
the
ifconfig eth0 -multicast
and just after it the xircom_tulip card begins to work.
-db

-----Original Message-----
From: Jeff Garzik [mailto:jgarzik@mandrakesoft.com]
Sent: Friday, November 10, 2000 5:19 PM
To: Ballabio_Dario@emc.com
Subject: Re: PATCH: Pcmcia/Cardbus/xircom_tulip in 2.4.0-test10.


Ballabio_Dario@emc.com wrote:
> 
> I could not compile test11-pre2 so far because of the unresolved symbol
> bust_spinlocks,
> but I'll give it a try as soon as the compile problem get cleared.

edit linux/arch/i386/kernel/traps.c.  move the bust_spinlocks function,
AND the 'extern ...timer_list' line near it above the CONFIG_X86_IO_APIC
ifdef.

-- 
Jeff Garzik             |
Building 1024           | Would you like a Twinkie?
MandrakeSoft            |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
