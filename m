Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbTKYC4L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 21:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbTKYC4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 21:56:10 -0500
Received: from palrel11.hp.com ([156.153.255.246]:34966 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261950AbTKYC4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 21:56:06 -0500
Date: Mon, 24 Nov 2003 18:56:05 -0800
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-pcmcia@lists.infradead.org,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       David Hinds <dahinds@users.sourceforge.net>
Subject: Re: [BUG] Ricoh Cardbus -> Can't get interrupts
Message-ID: <20031125025605.GA4059@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20031124235727.GA2467@bougret.hpl.hp.com> <Pine.LNX.4.58.0311241759470.1599@home.osdl.org> <Pine.LNX.4.58.0311241819030.1599@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0311241819030.1599@home.osdl.org>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 24, 2003 at 06:24:54PM -0800, Linus Torvalds wrote:
> 
> But it's _very_ rare to see it fail. The 2.4.x cardbus driver does the
> same thing, and I don't know of any consistent failure patterns. What kind
> of strange machine is this, Jean? Prototype with a broken BIOS?

	Standard HP Kayak XU300, standard BIOS. Dual P550.
------------------------------------
00:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 02)
00:08.0 SCSI storage controller: Adaptec AIC-7880U (rev 01)
00:10.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
00:11.0 USB Controller: OPTi Inc. 82C861 (rev 10)
00:12.0 Ethernet controller: Hewlett-Packard Company J2585B
00:13.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G100 [Productiva] AGP (rev 01)
02:04.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 53c875 (rev 26)
02:05.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] (rev 36)
------------------------------------

	Don't get me wrong, PCI-CardBus add-on cards seem to always be
a pain, whereas laptop seems to always have the right magic. I already
tried unsuccessfully to add a TI PCI-Pcmcia on another box, and this
was similar, whereas my laptops are always working out of the box.
	If you wonder why I'm doing that, well, there is not many SMP
laptops to try wireless driver on ;-)

> 		Linus

	Thanks.

	Jean
