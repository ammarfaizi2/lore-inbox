Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbTEZSY4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 14:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbTEZSY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 14:24:56 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:26793 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261998AbTEZSYy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 14:24:54 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16082.24332.881881.965677@gargle.gargle.HOWL>
Date: Mon, 26 May 2003 20:38:04 +0200
From: mikpe@csd.uu.se
To: Disconnect <lkml@sigkill.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: APIC on Dell Laptops - WAS: Re: [RFC] Fix NMI watchdog
	documentation
In-Reply-To: <1053967225.5948.12.camel@slappy>
References: <200305260921.h4Q9LcNr022536@harpo.it.uu.se>
	<1053967225.5948.12.camel@slappy>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Disconnect writes:
 > Local APIC disabled by BIOS -- reenabling.
 > Found and enabled local APIC!
 > 
 > And now /proc/cpuinfo and cpuid both show APIC support.
 > 
 > Removed/replaced power, triggered lid-switch/battery-status/etc with no
 > issues.  (The only thing that caused trouble was Fn-F10, the "eject cd"
 > button.  Never tried it under Linux before, and the cd isn't in it at
 > the moment anyway, so I'm betting thats unrelated. But it did cause a
 > lockup that even sysrq couldn't recover.)

Nice.

 > Not 100% clear on what the APIC does, but I'm not sure its doing it ;) 
 > 
 > PCI: Using ACPI for IRQ routing <-- shouldn't this be missing if the
 > APIC is in use?

Nope. local APIC != I/O APIC. Disable ACPI, or enable IO_APIC (and hope it's there).

 > (Full dmesg attached, for those who are curious - the unknown-scancode
 > is for the various laptop buttons - bright/dim, vol, media, battery,
 > etc.  Except for the volume buttons the only ones that work are the ones
 > that directly hit the hardware, ala bright/dim.)
 > 
 > Also, for others with an I8500 who might read the dmesg log, don't get

dmidecode data would be nice, for the whitelist rules.
