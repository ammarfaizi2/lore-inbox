Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129566AbRBBAib>; Thu, 1 Feb 2001 19:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131564AbRBBAiV>; Thu, 1 Feb 2001 19:38:21 -0500
Received: from chiara.elte.hu ([157.181.150.200]:63494 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129566AbRBBAiG>;
	Thu, 1 Feb 2001 19:38:06 -0500
Date: Fri, 2 Feb 2001 01:37:28 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: [PATCH] 2.4.1-ac1 UP-APIC/NMI watchdog fixes
In-Reply-To: <200102011928.UAA03188@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.30.0102020135421.4852-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 1 Feb 2001, Mikael Pettersson wrote:

> This patch (against 2.4.1-ac1) contains the following fixes:
> * UP-APIC linkage fix: nr_ioapics must be moved from io_apic.c to
>   mpparse.c to permit linking the kernel in pure UP-APIC configs.
> * NMI watchdog cleanups: mark setup_apic_nmi_watchdog() as __init,
>   fix the K7 init code to not leave any perfctr MSR uninitialised,
>   avoid having to check CPU type in NMI handler.
>   (Yes, the merged wrmsr(,,-1) is safe for P6.)

thanks Mikael! Did you have a chance to test this on a K7? Does
UP-APIC-NMI-watchdog code truly 'just work' now on the K7?

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
