Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292876AbSB0UNU>; Wed, 27 Feb 2002 15:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292926AbSB0UNC>; Wed, 27 Feb 2002 15:13:02 -0500
Received: from e4e.oac.uci.edu ([128.200.222.10]:27368 "EHLO e4e.oac.uci.edu")
	by vger.kernel.org with ESMTP id <S292925AbSB0UMo>;
	Wed, 27 Feb 2002 15:12:44 -0500
Date: Wed, 27 Feb 2002 12:12:37 -0800 (PST)
From: Sean DETTRICK <dettrick@uci.edu>
X-X-Sender: dettrick@e4e.oac.uci.edu
To: linux-kernel@vger.kernel.org
cc: dettrick@uci.edu, <support@asus.com>, <euro.cpu@amd.com>
Subject: A7M266-D, dual athlon 1800+ kernel-smp APIC boot problem workaround
Message-ID: <Pine.GSO.4.44.0202271124590.22391-100000@e4e.oac.uci.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am writing to advertise a linux-smp boot-problem workaround.

We have an Asus A7M266-D motherboard with dual Athlon MP 1800+.
We found the linux kernel-smp would seize shortly after or during booting
the second CPU, at around the time it was testing APIC.

We found that booting with the "noapic" option in grub or lilo was
sufficient to solve the problem.
e.g. in /etc/grub.conf the kernel line is:
	kernel /vmlinuz-2.4.17-0.18smp ro root=/dev/hda3 noapic
In lilo.conf I guess one would add the line:
	append="noapic"

That's it.  If you have interest in such things read on.

There was no boot problem with non-SMP linux kernels, but
we tried:
kernel-smp-2.4.9-21.athlon.rpm
kernel-smp-2.4.17-0.18.athlon.rpm
and the default RedHat 7.2 smp kernel.  They all seized at
about the same phase of the boot process, and they would all
boot successfully when the noapic option was included.

AMD and ASUS tech support had never heard of this problem.
ASUS suggested it "might" be the BIOS.

BTW the Athlons, clearly marked in the boxes as MP, identified
themselves as Athlon XP 1800+'s.   We thought this might be the
problem at first but now we guess not.

Note we have a different result to a related earlier posting:
http://www.van-dijk.net/linuxkernel/200204/0054.html

I am not a developer so have not subscribed to the list.
I would appreciate a CC or direct reply (my apologies for this
breach of protocol) if anyone has clarifying comments
e.g. what the heck is APIC anyway, will noapic effect performance,
and is there a more elegant solution.

Regards,

Sean Dettrick,
University of California, Irvine.

