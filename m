Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318643AbSHWHyc>; Fri, 23 Aug 2002 03:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318649AbSHWHyc>; Fri, 23 Aug 2002 03:54:32 -0400
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:62618 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP
	id <S318643AbSHWHyb>; Fri, 23 Aug 2002 03:54:31 -0400
Mime-Version: 1.0
Message-Id: <a05111608b98b96373cce@[129.98.90.227]>
Date: Fri, 23 Aug 2002 03:58:39 -0400
To: linux-kernel@vger.kernel.org
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: SMP Netfinity 340 hangs under 2.4.19
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A single processor Netfinity 340 running RedHat 7.1 and kernel 2.4.18 
was recently upgraded to

1) 1 GB RAM
2) second processor (1 Ghz Xeon)
3) 2.4.19 for SMP with bigmem and added NFS server patches and 
ext3-related patches.

Heavily used processes are netatalk, samba, and NFS.

The box is now hard locking periodically (every several days).

Lore elsewhere on the Internet says Netfinity SMP boxes have had 
trouble with the nmi-watchdog and the  screen blanker. The former was 
turning off via LILO and the latter turned off in script (for both 
terminal and for X).

It seemed that box was OK (for about 2 weeks) when it was not 
attached to external RAID hardware (via Adaptec 29160LP card). At 
least one hang occurred during fsck of the hardware RAID and another 
during what was probably heavy disk activity on the RAID.

The memory was reverted back to the original but it still hung. 
Presumably, this rules out #1.

In the latest hang, the keyboard is locked up, but the Ethernet card 
(e1000) has link and ssh and https and ping respond on scan but 
that's it.Also, heartbeat runs on the box and it stopped reporting to 
the motherboard Ethernet and serial port being watched by failover 
node's heartbeat.

Note that another box configured virtually identically except for the 
e1000 and the Adaptec card (no external RAID) has not hung.


Is there significance to the fact that keyboard and mouse are frozen 
but apparently some processes are still up?

Does anyone one think this could be an issue with the patched SMP kernel?

More keywords: crash, freeze, hung, frozen, locked up.
-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
