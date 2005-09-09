Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbVIILPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbVIILPX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 07:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbVIILPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 07:15:23 -0400
Received: from styx.suse.cz ([82.119.242.94]:61406 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1030240AbVIILPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 07:15:21 -0400
Date: Fri, 9 Sep 2005 13:15:19 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix misspelled i8259 typo in io_apic.c
Message-ID: <20050909111519.GA1476@ucw.cz>
References: <200509091259.05017.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509091259.05017.annabellesgarden@yahoo.de>
X-Bounce-Cookie: It's a lemmon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 12:59:04PM +0200, Karsten Wiese wrote:
> The legacy PIC's name is "i8259".
> 
> Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>

Indeed, i82559 is an Ethernet NIC.

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

> diff -upr linux-2.6.13-rc6/arch/i386/kernel/io_apic.c linux-2.6.13/arch/i386/kernel/io_apic.c
> --- linux-2.6.13-rc6/arch/i386/kernel/io_apic.c	2005-08-08 11:46:00.000000000 +0200
> +++ linux-2.6.13/arch/i386/kernel/io_apic.c	2005-08-08 13:24:52.000000000 +0200
> @@ -1641,9 +1641,9 @@ void disable_IO_APIC(void)
>  	clear_IO_APIC();
>  
>  	/*
> -	 * If the i82559 is routed through an IOAPIC
> +	 * If the i8259 is routed through an IOAPIC
>  	 * Put that IOAPIC in virtual wire mode
> -	 * so legacy interrups can be delivered.
> +	 * so legacy interrupts can be delivered.
>  	 */
>  	pin = find_isa_irq_pin(0, mp_ExtINT);
>  	if (pin != -1) {
> diff -upr linux-2.6.13-rc6/arch/x86_64/kernel/io_apic.c linux-2.6.13/arch/x86_64/kernel/io_apic.c
> --- linux-2.6.13-rc6/arch/x86_64/kernel/io_apic.c	2005-08-08 11:46:01.000000000 +0200
> +++ linux-2.6.13/arch/x86_64/kernel/io_apic.c	2005-08-08 13:25:09.000000000 +0200
> @@ -1138,9 +1138,9 @@ void disable_IO_APIC(void)
>  	clear_IO_APIC();
>  
>  	/*
> -	 * If the i82559 is routed through an IOAPIC
> +	 * If the i8259 is routed through an IOAPIC
>  	 * Put that IOAPIC in virtual wire mode
> -	 * so legacy interrups can be delivered.
> +	 * so legacy interrupts can be delivered.
>  	 */
>  	pin = find_isa_irq_pin(0, mp_ExtINT);
>  	if (pin != -1) {
> _
> 
> 	
> 
> 	
> 		
> ___________________________________________________________ 
> Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
