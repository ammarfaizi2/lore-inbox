Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132538AbRBEDGq>; Sun, 4 Feb 2001 22:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132588AbRBEDG1>; Sun, 4 Feb 2001 22:06:27 -0500
Received: from d176.focal4.interaccess.com ([207.208.139.176]:20352 "EHLO
	cactus.bheadley.org") by vger.kernel.org with ESMTP
	id <S132538AbRBEDGG>; Sun, 4 Feb 2001 22:06:06 -0500
Message-ID: <3A7E1ADF.669BAAD5@interaccess.com>
Date: Sun, 04 Feb 2001 21:15:43 -0600
From: "Bryan W. Headley" <bheadley@interaccess.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.2-pre1 won't boot on my SMP P-II
In-Reply-To: <200102050254.DAA07310@harpo.it.uu.se>
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by leeloo.zip.com.au id OAA30886

Mikael Pettersson wrote:

> Bryan W. Headley writes:
> > Last kernel that booted was Redhat's build of 2.4.0-pre11. I'm not sure
> > where the issue is at, so I attach a log of the system booting up.
> >
> > It's an ASUS P2B-DS with dual Deschutes PII-450s.
>
> > Linux version 2.4.2-pre1 (bheadley@cactus.bheadley.org) (gcc version 2.96 20000731 (Red Hat Linux 7.0)) #1 SMP Sun Feb 4 15:57:05 CST 2001
>
> gcc 2.96 -- is this the vanilla RH7.0 gcc or the updated one? The vanilla one
> is known to miscompile stuff. Use kgcc, 2.95.2, or the updated RH7.0 gcc.
>

The updated one. On suggestion, I upgraded the BIOS which seems to have fixed the issue.

>
> > md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
> > md.c: sizeof(mdp_super_t) = 4096
> > autodetecting RAID arrays
> > autorun ...
> > ... autorun DONE.
> > ACPI: Core Subsystem version [20010125]
> > LNMI Watchdog detected LOCKUP on CPU0, registers:
> > CPU:    0
> > EIP:    0010:[<c02345dd>]
> > EFLAGS: 00000086
> > eax: 00000000   ebx: 000f8040   ecx: 00000001   edx: c0272b42
> > esi: cfd6ff70   edi: cfd6e331   ebp: 00000000   esp: cfd6ff48
> > ds: 0018   es: 0018   ss: 0018
> > Process kacpid (pid: 7, stackpage=cfd6f000)
> > Stack: 00000286 00070000 00c70000 c01c10c1 000f8040 cfd6ff70 cfd6e331 00000000
> >        c01d47fa c0272b42 0000003c cfd6ffa0 000f8040 00000000 00000000 00000000
> >        00000000 00000000 cfd6e000 00000000 00000001 cfd6e000 20010125 00000003
> > Call Trace: [<c01c10c1>] [<c01d47fa>] [<c0105000>] [<c0108626>] [<c01d46d0>]
> >
> > Code: 80 3d 20 50 29 c0 00 f3 90 7e f5 e9 93 5c ee ff 80 3d 20 50
> > console shuts up ...
>
> The NMI watchdog detected an apparent lockup (interrupts masked
> for too long) during boot. This is fatal. Note that the last message
> before the oops mentioned "ACPI" and the process killed is "kacpid".
> Hmm, I don't know how well ACPI works on SMP (or at all), but you
> should try a new kernel built with ACPI disabled.
>
> /Mikael

--
____               .:.                 ____
Bryan W. Headley - bheadley@interaccess.com


ı:.Ë›±Êâmçë¢kaŠÉb²ßìzwm…ébïîË›±Êâmébìÿ‘êçz_âØ^n‡r¡ö¦zËëh™¨è­Ú&£ûàz¿äz¹Ş—ú+€ù^jÇ«y§m…á@A«a¶Úÿÿü0ÃûnÇú+ƒùd
