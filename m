Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129610AbRANAYO>; Sat, 13 Jan 2001 19:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130466AbRANAYE>; Sat, 13 Jan 2001 19:24:04 -0500
Received: from jalon.able.es ([212.97.163.2]:56780 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129610AbRANAXx>;
	Sat, 13 Jan 2001 19:23:53 -0500
Date: Sun, 14 Jan 2001 01:23:44 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Call for testers: ne2k-pci and io apic (was: Re: QUESTION: Network hangs with BP6...)
Message-ID: <20010114012344.C11015@werewolf.able.es>
In-Reply-To: <200101131237.f0DCb8g15518@flint.arm.linux.org.uk> <3A6071C2.47E8418A@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3A6071C2.47E8418A@colorfullife.com>; from manfred@colorfullife.com on Sat, Jan 13, 2001 at 16:18:26 +0100
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.01.13 Manfred Spraul wrote:
> 
> Please:
> * apply the attached patch.
> --
> 	Manfred
> --- linux/arch/i386/kernel/apic.c	Tue Dec  5 21:43:48 2000
> +++ linux/arch/i386/kernel/apic.c.new	Sat Jan 13 15:54:56 2001
> @@ -270,7 +270,7 @@
>  	 *   PCI Ne2000 networking cards and PII/PIII processors, dual
>  	 *   BX chipset. ]
>  	 */
> -#if 0
> +#if 1
>  	/* Enable focus processor (bit==0) */
>  	value &= ~(1<<9);
>  #else
> 

In my 2.4.0-ac9, that code goes to line 315 and looks like:

     *   BX chipset. ]
     */
#if 0
    /* Enable focus processor (bit==0) */
    value &= ~APIC_SPIV_FOCUS_DISABLED;
#else
    /* Disable focus processor (bit==1) */
    value |= APIC_SPIV_FOCUS_DISABLED;
#endif
    /*
     * Set spurious IRQ vector

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.0-ac8 #1 SMP Fri Jan 12 18:02:50 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
