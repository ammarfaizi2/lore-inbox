Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315486AbSECARL>; Thu, 2 May 2002 20:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315487AbSECARK>; Thu, 2 May 2002 20:17:10 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12563 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315486AbSECARK>; Thu, 2 May 2002 20:17:10 -0400
Subject: Re: Re[4]: Support of AMD 762?
To: ekuznetsov@divxnetworks.com
Date: Fri, 3 May 2002 01:36:16 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <46328234.20020502145748@divxnetworks.com> from "Eugene Kuznetsov" at May 02, 2002 02:57:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E173R3Y-0005GN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ENABLING IO-APIC IRQs
> Setting 2 in the phys_id_present_map
> ...changing IO-APIC physical APIC ID to 2 ... ok.

You are using APIC mode - the $PIR router isnt even involved. The AMD 762
BIOS and Software writers guide discusses the MP mode behaviour if you want
to look into it further but it looks as if your BIOS is simply horked

PCI cards are mapped to IRQ 16->19 in APIC mode with the ISA lines on
0-15. The only question there is which of INTA/INTB/INTC/INTD is ultimately
wired to the INTA on that slot. That is what the MP table should say but
is not

Do you see this with both MP 1.1 and MP 1.4 ?
