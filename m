Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbTHYLdS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 07:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbTHYLdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 07:33:17 -0400
Received: from platane.lps.ens.fr ([129.199.121.28]:10391 "EHLO
	platane.lps.ens.fr") by vger.kernel.org with ESMTP id S261352AbTHYLdQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 07:33:16 -0400
Date: Mon, 25 Aug 2003 13:33:13 +0200
From: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       Acpi-devel@lists.sourceforge.net
Subject: 2.6.0-pre4 hangs if acpi enabled
Message-ID: <20030825113313.GA10691@lps.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When booting 2.6.0-pre4 on my intel P4 with a shuttle motherboard, the
computer hangs after printing

	hda: max request size: 128KiB
	hda: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
	 hda: hda1 hda2 hda4 < hda5 hda6 hda7 >
	mice: PS/2 mouse device common for all mice

No scroll from the keyboard, no sys-rq, Caps-lock doesn't lit the led on
the keyboard. The computer is completely frozen.

On a normal boot, the following lines are

	serio: i8042 AUX port at 0x60,0x64 irq 12
	input: AT Set 2 keyboard on isa0060/serio0
	serio: i8042 KBD port at 0x60,0x64 irq 1

2.6.0-pre1 was working nicely. I haven't tried 2.6.0-pre2 or -pre3.
2.6.0-pre4 works if I append acpi=off of pci=noacpi at the boot
commandline.

You will find on <http://perso.nerim.net/~tudia/bug-reports/> the
complete boot messages, the configuration of the kernel, the dsdt, the
output of lspci -vv, etc. Please tell me if some relevant information is
missing.

Regards,

	Éric Brunet

