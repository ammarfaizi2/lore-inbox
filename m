Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVDDPci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVDDPci (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 11:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVDDPci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 11:32:38 -0400
Received: from aun.it.uu.se ([130.238.12.36]:17562 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261257AbVDDPcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 11:32:36 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16977.24079.564977.842269@alkaid.it.uu.se>
Date: Mon, 4 Apr 2005 17:32:31 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Christopher Allen Wing <wingc@engin.umich.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: clock runs at double speed on x86_64 system w/ATI RS200 chipset
In-Reply-To: <Pine.LNX.4.58.0504041050250.32159@hammer.engin.umich.edu>
References: <200504031231.j33CVtHp021214@harpo.it.uu.se>
	<Pine.LNX.4.58.0504041050250.32159@hammer.engin.umich.edu>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Allen Wing writes:
 > 
 > 
 > On Sun, 3 Apr 2005, Mikael Pettersson wrote:
 > 
 > > Well, first step is to try w/o ACPI. ACPI is inherently fragile
 > > and bugs there can easily explain your timer problems. Either
 > > recompile with CONFIG_ACPI=n, or boot with "acpi=off pci=noacpi".
 > 
 > 
 > When I boot without ACPI (I used 'acpi=off pci=noacpi') the system fails
 > to come up all the way; it hangs after loading the SATA driver. (but
 > before the SATA driver finishes probing the disks)
 > 
 > I'm guessing that the interrupt from the SATA controller is not getting
 > through? Anyway, I assumed that ACPI was basically required for x86_64
 > systems to work, is this not really the case?

In principle ACPI shouldn't be needed, but in its absence the
BIOS must provide an MP table and the x86-64 kernel must still
have code to parse it -- otherwise I/O APIC mode won't work.
I don't know if that's the case or not.

I suggest you boot normally (with ACPI fully enabled) and send a
bug report to LKML and the ACPI list with the interrupt routing
info from the kernel log.
