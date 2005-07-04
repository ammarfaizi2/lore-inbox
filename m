Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbVGDViY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbVGDViY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 17:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVGDViY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 17:38:24 -0400
Received: from colin.muc.de ([193.149.48.1]:7176 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261690AbVGDVhQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 17:37:16 -0400
Date: 4 Jul 2005 23:37:15 +0200
Date: Mon, 4 Jul 2005 23:37:15 +0200
From: Andi Kleen <ak@muc.de>
To: Sean Bruno <sean.bruno@dsl-only.net>
Cc: Alexander Nyberg <alexn@telia.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       "Hodle, Brian" <BHodle@harcroschem.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'ipsoa@posiden.hopto.org'" <ipsoa@posiden.hopto.org>
Subject: Re: ASUS K8N-DL Beta BIOS
Message-ID: <20050704213715.GC40830@muc.de>
References: <D9A1161581BD7541BC59D143B4A06294021FAAAF@KCDC1> <1120246927.2764.26.camel@home-lap> <200507021843.45450.s0348365@sms.ed.ac.uk> <20050702194455.GA80118@muc.de> <1120365125.4107.4.camel@home-lap> <1120376236.1175.1.camel@localhost.localdomain> <1120507617.5304.1.camel@home-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120507617.5304.1.camel@home-lap>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Bootdata ok (command line is ro root=/dev/VolGroup00/LogVol00 rhgb apic=debug acpi=verbose acpi_skip_timer_override)
> Linux version 2.6.12 (root@home-desk) (gcc version 4.0.0 20050519 (Red Hat 4.0.0-8)) #1 SMP Sat Jun 18 10:21:14 PDT 2005
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009e400 (usable)
>  BIOS-e820: 000000000009e400 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 00000000bfff0000 (usable)
>  BIOS-e820: 00000000bfff0000 - 00000000bfff3000 (ACPI NVS)
>  BIOS-e820: 00000000bfff3000 - 00000000c0000000 (ACPI data)
>  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
>  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
>  BIOS-e820: 0000000100000000 - 00000001c0000000 (usable)
> ACPI: RSDP (v000 Nvidia                                ) @ 0x00000000000f7650
> ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff3040

Hrm, we definitely have code to force acpi_skip_timer_override 
on Nvidia. But it does not seem to trigger on your board.
I wonder if it has the Nvidia bridges behind other bridges
which might be too much for the simple minded scan in check_ioapic.

Can you perhaps send me lspci -v output? 

-Andi
