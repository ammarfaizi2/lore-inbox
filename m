Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265670AbTBKBft>; Mon, 10 Feb 2003 20:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265736AbTBKBft>; Mon, 10 Feb 2003 20:35:49 -0500
Received: from kim.it.uu.se ([130.238.12.178]:62339 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S265670AbTBKBfs>;
	Mon, 10 Feb 2003 20:35:48 -0500
Date: Tue, 11 Feb 2003 02:45:33 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200302110145.CAA15207@kim.it.uu.se>
To: nicolas.baradakis@prologin.org
Subject: Re: Incompatibility between 'Local APIC' and '8139too'
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2003 00:47:12 +0100, Nicolas Baradakis wrote:
>Activating the option 'Local APIC support on uniprocessors' prevents
>the network device '8139too' from transmitting any packet.
>...
>The  workaround is  to boot  the kernel  with the  option  'noapic' or
>recompile it  without the  option 'Local APIC',  and then  the network
>device works perfectly.
...
>>From the debian package 'kernel-source-2.4.20_2.4.20-5_all.deb'

I strongly believe your problems are related to the I/O APIC,
not the local APIC:

- the local APIC has minimal impact on system-level IRQ handling,
  whereas the impact from the I/O APIC by definition is major

- the 'noapic' option disables the I/O APIC, NOT the local APIC
  (at least in all standard kernels, Debian may have broken this)

- disabling the local APIC kernel option also disables I/O
  APIC on uniprocessor support
