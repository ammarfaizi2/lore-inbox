Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265317AbUAPHp7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 02:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265319AbUAPHp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 02:45:59 -0500
Received: from s4.uklinux.net ([80.84.72.14]:48596 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id S265317AbUAPHps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 02:45:48 -0500
Date: Fri, 16 Jan 2004 07:44:45 +0000
To: linux-kernel@vger.kernel.org
Subject: 2.6.1 Bugs?
Message-ID: <20040116074445.GA30209@titan.home.hindley.uklinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Mark Hindley <mark@hindley.uklinux.net>
X-MailScanner-Titan: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have just taken the plunge and built 2.6.1 for my desktop K6-200, 430TX.

With the preempt, it is certainly faster than 2.4 and the memory/swap
usage is much less. Great!

However, I have noticed a couple of problems:

I have a 3com NIC. But the module usage count for 3c59x  stays at 0 even
when eth0 is up. 

Secondly, I cannot run lilo under 2.6.1. I get

Device 0x0300: Invalid partition table, 2nd entry
  3D address:     1/0/773 (779184)
  Linear address: 1/0/6184 (6233472)

Runs  fin under 2.4. There is a difference in the way the disk geometries
are reported on boot.

2.4 reports:

Jan 15 08:00:17 titan kernel: hda: 6835952 sectors (3500 MB), CHS=847/128/63, UDMA(33)
Jan 15 08:00:17 titan kernel: hdb: 40031712 sectors (20496 MB) w/512KiB Cache, CHS=2491/255/63, UDMA(33)

and 2.6.1:

Jan 15 08:19:56 titan kernel: hda: 6835952 sectors (3500 MB), CHS=6781/16/63, UDMA(33)
Jan 15 08:19:56 titan kernel: hdb: 40031712 sectors (20496 MB) w/512KiB Cache, CHS=39714/16/63, UDMA(33)

I have 

# CONFIG_IDEDISK_STROKE is not set

but according to the help, I shouldn't need it as the disk is less than
32MB. 

Award BIOS.

Do let me know if you need any other info on this.

Mark
