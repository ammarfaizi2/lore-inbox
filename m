Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129074AbQKAQN1>; Wed, 1 Nov 2000 11:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129102AbQKAQNR>; Wed, 1 Nov 2000 11:13:17 -0500
Received: from fairway.oup.co.uk ([194.80.1.20]:29828 "EHLO fairway.oup.co.uk")
	by vger.kernel.org with ESMTP id <S129074AbQKAQNE>;
	Wed, 1 Nov 2000 11:13:04 -0500
Message-ID: <A528EB7F25A2D111838100A0C9A6E5EF068A1DBC@exc01.oup.co.uk>
From: "CRADOCK, Christopher" <cradockc@oup.co.uk>
To: "'M.H.VanLeeuwen'" <vanl@megsinet.net>, linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: RE: Linux-2.4.0-test10
Date: Wed, 1 Nov 2000 16:12:57 -0000 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a similar hardware list and I don't observe any of these problems on
2.4.0-test10x. Is it possibly a hardware conflict somewhere?

What I do see occasionally is if X was ever heavy on the memory usage (say
I've run GIMP for a couple of hours) then the text console's font set gets
trashed until the next reboot. Console driver failing to reset something?

Chris Cradock

> -----Original Message-----
> From:	M.H.VanLeeuwen [SMTP:vanl@megsinet.net]
> Sent:	Wednesday, November 01, 2000 6:03 AM
> To:	linux-kernel@vger.kernel.org
> Cc:	torvalds@transmeta.com
> Subject:	Re: Linux-2.4.0-test10
> 
> FYI,
> 
> My list of 2.4.0-testX problems
> 
> Further details, .config, etc...available if needed
> 
> Martin
> 
> 2.4.0-test10 and earlier problem list:
>  
> Problem |       UP              UP-APIC         SMP
> --------|------------------------------------------------
> 1       |       OK              OK              HARDLOCK
> 2       |       OK              FAILS           OK
> 3       |       HARDLOCK        HARDLOCK        HARDLOCK
> 4       |       BROKEN          BROKEN          BROKEN
> 
> Problem description:
>  
> 1.  kernel compiled w/o FB support.  When attempting to switch
>     back to X from VC1-6 system locks hard for SMP.  Nada thing
>     fixes this except hard reset... no Alt-SysRq-B, nothing
>     DRI not enabled.  Video card has r128 chipset.
>  
> 2.  System is a NFS root machine, after a period of heavy ntwk
>     activity, eg. "make clean" in /usr/src/linux ETH0 no longer
>     works or sometimes just ntwk activity during system boot is
>     enough to cause the ETH activity to cease.
>     The only recourse is to Alt-SysRq-B the system.
>     NIC = NE2K ISA
>  
> 3. Enabling PIIX4, kernel locks hard when printing the partition
>    tables for hdc.   hdc has no partitions.
>    I think this problem is on Ted's problem list???
>  
> 4. ISAPNP assigns an invalid/unusable IRQ to NE2K NIC card.
>    Previously reported to Linux & Ingo, they asked for an MPTABLE
>    dump, haven't heard back since providing said data.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
