Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266118AbRGLMpC>; Thu, 12 Jul 2001 08:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266123AbRGLMow>; Thu, 12 Jul 2001 08:44:52 -0400
Received: from [62.58.73.254] ([62.58.73.254]:9466 "EHLO
	ats-core-0.atos-group.nl") by vger.kernel.org with ESMTP
	id <S266118AbRGLMor>; Thu, 12 Jul 2001 08:44:47 -0400
Date: Thu, 12 Jul 2001 14:44:36 +0200 (MEST)
From: <ryan.sweet@atosorigin.com>
X-X-Sender: <rsweet@ats-dhcp-01.atos-group.nl>
To: <linux-kernel@vger.kernel.org>
Subject: apic, and spontaneous reboots with smp diskless clients on 2.4.x
Message-ID: <Pine.LNX.4.33.0107121355180.1047-100000@ats-dhcp-01.atos-group.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a cluster of diskless clients with the following spec:

ASUS CUR_DLS FC-PGA Motherboard with dual 1Ghz PIII /768MB Registered
SDRAM, on board eepro100.

They boot nfsroot from a PIII 1Ghz running 2.4.6-xfs with nfsv3.  The
diskless client root is on an ext2 filesystem.  The master is stable.

one or more of the clients will always either lock up or reboot under
moderate load (kernel compile across all of them, cfdrc software run...).
I started with 2.4.6, tried 2.4.5, and am now running 2.4.3-12 (redhat
sources).  The 2.4.3-12 seems to be more stable, but now some nodes simply
lockup instead of rebooting, while other times they reboot.  The only
thing I can find to give any information about the problem is occasionally
on the console (but not in syslog -and I'm logging *.*) are APIC error in
CPUx blah(blah) messages, where blah, blah is replaced by various APIC
error codes (I haven't been able to determine the frequency or pattern).

I have just rebooted them all with "noapic" and am testing again, also
collecting tcpdump output.

When the machines lock, the sysreq key doesn't do anything.  lkcd also of
course doesn't help.

In the meantime, searching the archives, I can see a few mentions of
similar problems, but I haven't been able to see any threads that reached
a useful conclusion (except for going back to 2.2.x).  Is there a previous
discussion that is  applicable and I just haven't understood it?

Can anyone suggest what additional information I can gather/provide in
order to debug the problem?

For what it is worth, I have another cluster running the same motherboard
with 2.4.1 with local disks (symbios onboard scsi controller) and slower
(866Mhz) cpus that doesn't show this problem.



