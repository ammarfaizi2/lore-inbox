Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279553AbRKGKAS>; Wed, 7 Nov 2001 05:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279556AbRKGKAH>; Wed, 7 Nov 2001 05:00:07 -0500
Received: from t2.redhat.com ([199.183.24.243]:53501 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S279553AbRKGJ7w>; Wed, 7 Nov 2001 04:59:52 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20011107104044.C11351@hazard.jcu.cz> 
In-Reply-To: <20011107104044.C11351@hazard.jcu.cz>  <20011106123427.A11351@hazard.jcu.cz> <3BE2D37A.D32C6DB1@zip.com.au> <20011105112900.C5919@hazard.jcu.cz> <23001.1005086449@redhat.com> 
To: Jan Marek <linux@hazard.jcu.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Cannot unlock spinlock... Was: Problem in yenta.c, 2nd edition 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 07 Nov 2001 09:59:49 +0000
Message-ID: <11670.1005127189@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


linux@hazard.jcu.cz said:
>  Your hack is working for me. I got message: "IRQ storm detected on
> IRQ 11. Disabling"

> and everythink works OK. Spinlock was unlocked, procedure setup_irq()
> ended and PCMCIA package works fine...

> It is possible to add your patch to the kernel? 

Absolutely not. In 2.5, we may have some code to deal with IRQ storms, but 
certainly not like that. 

> But I don't know, what device asserted IRQ 11 to start the IRQ storm..

What other PCI devices claim to be on IRQ 11? Do you have ACPI enabled (in 
the BIOS and/or in Linux)?

--
dwmw2


