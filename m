Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132640AbRC2CRn>; Wed, 28 Mar 2001 21:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132644AbRC2CRd>; Wed, 28 Mar 2001 21:17:33 -0500
Received: from Mail.Mankato.MSUS.EDU ([134.29.1.12]:57104 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id <S132640AbRC2CRU>;
	Wed, 28 Mar 2001 21:17:20 -0500
Message-ID: <3AC29B06.16A7C987@mnsu.edu>
Date: Wed, 28 Mar 2001 20:16:38 -0600
From: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
Organization: Minnesota State University, Mankato
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2-ac27 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
   Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Linux-2.4.2-ac27 - read on /proc/bus/pci/devices never finishes after 
 rmmod aic7xxx
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm using Linux-2.4.2-ac27 SMP compiled with gcc version 2.95.2 20000220
(Debian GNU/Linux).

After an "insmod aic7xxx" "cat /proc/bus/pci/devices" works just fine.
After an "rmmod aic7xxx" "cat /proc/bus/pci/devices" fails to produce
any output and never finishes.  Top show the process in R state taking
as much CPU as it can get.

Killing the process doesn't do anything, rebooting is the only way to
get rid of it.  This problem does not happen with aic7xxx_old.

Strace shows a "read" on the fd of /proc/bus/pci/devices that never
finishes.

My aic7xxx devices as reported by "lspci -vvv":

00:12.0 SCSI storage controller: Adaptec AIC-7881U (rev 01)
        Subsystem: Adaptec: Unknown device 7881
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 8 max, 64 set, cache line size 08
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at e800 [size=256]
        Region 1: Memory at febff000 (32-bit, non-prefetchable)
[size=4K]
        Expansion ROM at febe0000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI+ D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

--
jeffrey hundstad
minnesota state university, mankato
mankato, mn
usa


