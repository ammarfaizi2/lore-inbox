Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161078AbVKDGPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161078AbVKDGPM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 01:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbVKDGPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 01:15:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11191 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161078AbVKDGPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 01:15:10 -0500
Date: Thu, 3 Nov 2005 22:14:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Filo <krzysztof.gorgolewski@gmail.com>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-pcmcia@lists.infradead.org
Subject: Re: PROBLEM: Paceblade Pacebook no irq for TI yenta PCMCIA - PCI
 related
Message-Id: <20051103221451.2799eb17.akpm@osdl.org>
In-Reply-To: <fda8dbc60510291430w30d8ffdfo80c45595778f938@mail.gmail.com>
References: <fda8dbc60510291430w30d8ffdfo80c45595778f938@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Filo <krzysztof.gorgolewski@gmail.com> wrote:
>
>  I'm trying to get my PCMCIA port running on my pacebook tablet. I'm
>  using 2.6.* kernel (actually 2.6.13-rc4-mm1 but I also tried 2.6.12)
>  and during initialization of yenta_socket I get this message:
> 
>  Yenta: Routing CardBus interrupts to PCI
>  Yenta TI: socket 0000:00:05.0, mfunc 0x01021c02, devctl 0x64
>  Yenta TI: socket 0000:00:05.0 probing PCI interrupt failed, trying to fix
>  Yenta TI: socket 0000:00:05.0 no PCI interrupts. Fish. Please report.
>  Yenta: no PCI IRQ, CardBus support disabled for this socket.
>  Yenta: check your BIOS CardBus, BIOS IRQ or ACPI settings.
>  Yenta: ISA IRQ mask 0x0ad8, PCI irq 0
> 
>  It seam that Yenta cant get information about the irq's from the PCI.
>  It's not an ACPI issue because I did not compile it (it's broken on my
>  tablet). I'm quite confused what to do now. Any help (even a dirty
>  hack) would be appreciated.

Did the machine work OK under any earlier kernels?  2.4?  If so, which?

Did you try enabling ACPI under the 2.6 kernel, because that might be the
fix.  If ACPI fails then please raise a separate report for that
(preferably at bugzilla.kernel.org).

Thanks.

