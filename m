Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263477AbTHXMP3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 08:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263485AbTHXMP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 08:15:29 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:64940 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263477AbTHXMPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 08:15:23 -0400
Date: Sun, 24 Aug 2003 14:10:09 +0200
From: Vojtech Pavlik <vojtech@ucw.cz>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: LKML <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: 2.6.0-test3-bk6: hang at i8042.c when booting with no PS/2 mouse attached
Message-ID: <20030824121009.GB30316@ucw.cz>
References: <20030824120605.23981.qmail@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030824120605.23981.qmail@linuxmail.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 24, 2003 at 01:06:05PM +0100, Felipe Alfaro Solana wrote:
> ----- Original Message ----- 
> From: Vojtech Pavlik <vojtech@ucw.cz> 
> Date: Sun, 24 Aug 2003 12:46:15 +0200 
> To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> 
> Subject: Re: 2.6.0-test3-bk6: hang at i8042.c when booting with no PS/2 mouse attached 
>  
> > On Mon, Aug 18, 2003 at 09:09:16PM +0200, Felipe Alfaro Solana wrote: 
> >  
> > > If I try to boot my P4 box (i845DE motherboard) with no PS/2 mouse 
> > > plugged into the PS/2 port, the kernel hangs while checking the AUX 
> > > ports in function i8042_check_aux(). The i8042_check_aux() function is 
> > > trying to request IRQ #12, but the call to request_irq() causes the 
> > > hang. The kernel hangs exactly at: 
> > >  
> > >         if (request_irq(values->irq, i8042_interrupt, SA_SHIRQ, 
> > >                                 "i8042", i8042_request_irq_cookie)) 
> >  
> > What happens if you remove the SA_SHIRQ and replace with 0? 
>  
> It does nothing: the kernel still hangs there. It seems to be a problem with the new ACPI code 
> changes cause the kernel boots fine with "pci=noacpi". 

Most likely something with the polarity of interrupts.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
