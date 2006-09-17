Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbWIQNpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbWIQNpU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 09:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbWIQNpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 09:45:20 -0400
Received: from sun.schedom-europe.net ([193.109.184.70]:25038 "HELO
	sun.schedom-europe.net") by vger.kernel.org with SMTP
	id S964972AbWIQNpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 09:45:19 -0400
From: Jan De Luyck <ml_linuxkernel_20060528@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6.17.13] nforce 57 MP-BIOS bug: 8254 timer not connected to IO-APIC
Date: Sun, 17 Sep 2006 15:45:14 +0200
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609171545.14701.ml_linuxkernel_20060528@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

Using kernel 2.6.17.13 on an AMD M2 64x2, motherboard ABIT KN9-SLI. Chipset
on this board is an nForce 570 SLI MCP.

Today I bumped into this, after upgrading my BIOS to fix a boot issue that I
was having (sometimes it wouldn't go past the POST screen):

---
MP-BIOS Bug: 8254 timer not connected to IO-APIC
Kernel panic - not syncing: IO-APIC + timer doesn't work! Try using the 'noapic' 
 kernel parameter
---

Prior to the BIOS upgrade I didn't have this problem - the system booted 
fine with the IO-APIC enabled. 

Using apic=debug, I see this:
--- SNIP ---
ENABLING IO-APIC IRQs
Synchronizing Arb IDs.
..TIMER: vector=0x31 apic1=0 pin1=- apic2=-1 pin2=-1
..MP-BIOS bug: 8245 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ ... failed.
...trying to set up tijmer as ExtINT IRQ... failed :(.
Kernel panic - not syncing: IO-APIC + timer doesn't work! try using the 'noapic' 
 kernel parameter
--- SNIP ---

Using noapic, the system boots. Is there any performance impact that might be
occurring when using noapic? Anything else I can try?

Thanks,

Jan
-- 
The brotherhood of man is not a mere poet's dream; it is a most depressing
and humiliating reality.
		-- Oscar Wilde
