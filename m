Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263505AbTHXMII (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 08:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263529AbTHXMIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 08:08:07 -0400
Received: from 205-158-62-67.outblaze.com ([205.158.62.67]:51840 "EHLO
	spf13.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S263505AbTHXMIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 08:08:05 -0400
Message-ID: <20030824120605.23981.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
To: "Vojtech Pavlik" <vojtech@ucw.cz>
Cc: "LKML" <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Date: Sun, 24 Aug 2003 13:06:05 +0100
Subject: Re: 2.6.0-test3-bk6: hang at i8042.c when booting with no PS/2
    mouse attached
X-Originating-Ip: 213.4.13.153
X-Originating-Server: ws5-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: Vojtech Pavlik <vojtech@ucw.cz> 
Date: Sun, 24 Aug 2003 12:46:15 +0200 
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> 
Subject: Re: 2.6.0-test3-bk6: hang at i8042.c when booting with no PS/2 mouse attached 
 
> On Mon, Aug 18, 2003 at 09:09:16PM +0200, Felipe Alfaro Solana wrote: 
>  
> > If I try to boot my P4 box (i845DE motherboard) with no PS/2 mouse 
> > plugged into the PS/2 port, the kernel hangs while checking the AUX 
> > ports in function i8042_check_aux(). The i8042_check_aux() function is 
> > trying to request IRQ #12, but the call to request_irq() causes the 
> > hang. The kernel hangs exactly at: 
> >  
> >         if (request_irq(values->irq, i8042_interrupt, SA_SHIRQ, 
> >                                 "i8042", i8042_request_irq_cookie)) 
>  
> What happens if you remove the SA_SHIRQ and replace with 0? 
 
It does nothing: the kernel still hangs there. It seems to be a problem with the new ACPI code 
changes cause the kernel boots fine with "pci=noacpi". 
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
