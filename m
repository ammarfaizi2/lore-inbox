Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbUB0Hag (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 02:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbUB0Hag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 02:30:36 -0500
Received: from smtp2.BelWue.de ([129.143.2.15]:2803 "EHLO smtp2.BelWue.DE")
	by vger.kernel.org with ESMTP id S261735AbUB0HaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 02:30:18 -0500
Date: Fri, 27 Feb 2004 08:30:14 +0100 (CET)
From: Oliver Tennert <tennert@science-computing.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.3: Early lockup during boot on Athlon and Opteron Boards
Message-ID: <Pine.LNX.4.44.0402270818380.500-100000@picard.science-computing.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

this happens with a 2.6.3 kernel:

- on an Athlon board (K7V333), immediately after "using anticipatory
scheduler", the system freezes, hard reset necessary.

- on an Athlon board (A7N8X Deluxe with nforce2 chipset), immediately
after the initialization of the IDE subsystem, the system freezes, hard
reset necessary.

- on an Opteron 246 board (Tyan with AMD8111/8131/8151 chipset),
immediately after the initialization of the IDE subsystem, the system
freezes, hard reset necessary.

I have applied the latest ACPI patch posted here some two days ago.

Now, this all did NOT occur with a 2.6.2 kernel or earlier.

I tried all possible boot options I know off:

noapic, acpi=off, ide?=serialize, pci=usepirq,...

it all did not help.

I realized similar problems have already been mentioned on LKML:

http://www.ussg.iu.edu/hypermail/linux/kernel/0402.3/0420.html (and
related)

Now I did not see any of the patches offered there checked in at
Bitkeeper. Also, some did apply when I gave them a try, and moreover, this
happens not only on Nforce2 boards, though the symptoms are the same.

Has anyone ideas?

Can I try something in order to get rid of this deadlock?

Best regards

Olive

__
________________________________________creating IT solutions

Dr. Oliver Tennert			science + computing ag
phone   +49(0)7071 9457-598		Hagellocher Weg 71-75
fax     +49(0)7071 9457-411		D-72070 Tuebingen, Germany
O.Tennert@science-computing.de		www.science-computing.de



