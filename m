Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270155AbRHMMc0>; Mon, 13 Aug 2001 08:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270158AbRHMMcQ>; Mon, 13 Aug 2001 08:32:16 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26116 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270155AbRHMMcB>; Mon, 13 Aug 2001 08:32:01 -0400
Subject: Re: S2464 (K7 Thunder) hangs -- some lessons learned
To: esr@thyrsus.com
Date: Mon, 13 Aug 2001 13:34:30 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <20010812212430.A9300@thyrsus.com> from "Eric S. Raymond" at Aug 12, 2001 09:24:30 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15WGvO-0007Ig-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alas, the 2.4.8+ emu10k1 driver does not completely banish the K7 Thunder
> lockups problem.  It makes them a lot rarer, though, and enabled us to get to
> the next level of diagnosis.

What version of the chipset do you have. The current ones can hang the PCI bus
during IDE transfers if you have IDE read/write prefetch enabled in the bios
setup.

It also has problems with the APIC implementation where an IRQ masked in
the APIC re-occurs which can hang the system. Worrying this one is marked
'nofix'. You might want to trying running "noapic"

Alan
