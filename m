Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVADLQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVADLQr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 06:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVADLQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 06:16:47 -0500
Received: from gprs214-29.eurotel.cz ([160.218.214.29]:42673 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261160AbVADLQc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 06:16:32 -0500
Date: Tue, 4 Jan 2005 12:15:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Miguelanxo Otero Salgueiro <miguelanxo@telefonica.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 resuming laptop from suspension f*cks usb subsystem
Message-ID: <20050104111518.GG18777@elf.ucw.cz>
References: <41D2C4FA.7010806@telefonica.net> <20050103220704.GB25250@elf.ucw.cz> <41DA79EB.20102@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DA79EB.20102@telefonica.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>In 2.6.10, resuming from suspend mode just (randomly) crashes the USB 
> >>subsystem, and I get the same messages (not sure about the whole message 
> >>but the "-84" part really is there) over and over again until I reboot.
> >>   
> >>
> >
> >Does it still happen with noapic? 2.6.10 has some interrupt related
> >problems with APIC...

> I have just rebooted 2.6.10 with this LILO command line
> 
>    LILO Boot: Linux-2.6.10 noapic
> 
> and if that disables APIC, then I've got the same problem. After 
> suspending the laptop
> two times, I get the same lines (described below) and the usb system 
> goes nuts. After
> removing & inserting uhci_hcd everything works fine again.
> 
> The lines are (endless loop):
> drivers/usb/input/hid-core.c: input irq status -84 received

I guess you need to ask on usb lists. If removing/inserting uhci_hcd
helps, it is likely that uhci_hcd needs to do a bit more in its
suspend/resume callbacks.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
