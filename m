Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264373AbUD0Vxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbUD0Vxy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 17:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264374AbUD0Vxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 17:53:54 -0400
Received: from pD9E0990B.dip.t-dialin.net ([217.224.153.11]:19586 "EHLO
	router.zodiac.dnsalias.org") by vger.kernel.org with ESMTP
	id S264373AbUD0Vx3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 17:53:29 -0400
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: linux-kernel@vger.kernel.org
Subject: e1000 EEPROM wrong after suspending.
Date: Tue, 27 Apr 2004 23:53:23 +0200
User-Agent: KMail/1.6.2
X-Ignorant-User: yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200404272353.27989@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,


I've got an e1000 Mobile in an IBM t40p. after a suspend/resume cycle the card 
isn't working any longer. I'm unloading the module before the suspending, 
realoding it afterwards.
Kernel is 2.6.6-rc2-mm2, ACPI enabled, APIC disabled (didn't boot, last time I 
tried)

System details:
lspci:
0000:02:01.0 Ethernet controller: Intel Corp. 82540EP Gigabit Ethernet 
Controller (Mobile) (rev 03)
        Subsystem: IBM PRO/1000 MT Mobile Connection
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 9
        Memory at c0220000 (32-bit, non-prefetchable)
        Memory at c0200000 (32-bit, non-prefetchable) [size=64K]
        I/O ports at 8000 [size=64]
        Capabilities: [dc] Power Management version 2
        Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 
Enable-

dmesg:
Intel(R) PRO/1000 Network Driver - version 5.2.39-k2
Copyright (c) 1999-2004 Intel Corporation.
eth0: Intel(R) PRO/1000 Network Connection
e1000: eth0 NIC Link is Up 100 Mbps Full Duplex

after resuming:
Intel(R) PRO/1000 Network Driver - version 5.2.39-k2
Copyright (c) 1999-2004 Intel Corporation.
PCI: Enabling device 0000:02:01.0 (0000 -> 0003)
PCI: Setting latency timer of device 0000:02:01.0 to 64
The EEPROM Checksum Is Not Valid
e1000: probe of 0000:02:01.0 failed with error -5

kernel config:
http://zodiac.dnsalias.org/misc/current.config
complete dmesg:
http://zodiac.dnsalias.org/misc/current.dmesg

regards
Alex

- -- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAjtZW/aHb+2190pERAreDAJ4guCUTK914AeRI8Cx5dBafVPvO9wCfbYin
GYLL6zlc4sBN8BWoaPyySiw=
=705v
-----END PGP SIGNATURE-----
