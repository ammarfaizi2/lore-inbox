Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279955AbRJ3OZu>; Tue, 30 Oct 2001 09:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279956AbRJ3OZk>; Tue, 30 Oct 2001 09:25:40 -0500
Received: from genesis.westend.com ([212.117.67.2]:38280 "EHLO
	genesis.westend.com") by vger.kernel.org with ESMTP
	id <S279955AbRJ3OZV>; Tue, 30 Oct 2001 09:25:21 -0500
Date: Tue, 30 Oct 2001 15:25:49 +0100
From: Christian Hammers <ch@westend.com>
To: linux-kernel@vger.kernel.org
Subject: Re: BUG() in asm/pci.h:142 with 2.4.13 (cause found!)
Message-ID: <20011030152549.A18935@westend.com>
In-Reply-To: <20011025120701.C6557@westend.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011025120701.C6557@westend.com>; from ch@westend.com on Thu, Oct 25, 2001 at 12:07:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

The cause for my problems with crashing kernels when accessing the tape
drive were differences between the original external RAID that belongs
to the machine and a temporarily, nearly equal, RAID that we attached while
the original was send away for repair. 
The temp. RAID was Ultra3 160 and /proc/scsi/aic7xxx/0 showed me a cur.
speed of 160 while the "old" and working one only did Ultra2 with 80Mbit/s.

I don't know if it's a hardware incompatibility or if the Linux kernel 
drivers cannot handle this specific case.

The problem exists in 2.4.11-pre6, 2.4.13, 2.4.12-ac6 and 2.4.13 with
patched from axboa(?) and D. Miller.
 
bye,

 -christian-


On Thu, Oct 25, 2001 at 12:07:01PM +0200, Christian Hammers wrote:
...
> 2.4.13 was the easiest one to reproduce: when starting the tape backup
> to a HP DDS3/DAT Streamer (C1537A) via a Adaptec SCSI Controller 
> (Adaptec 7892A in /proc/pci) on a Gigabyte GA-6VTXD Dual Motherboard with
> two PIII and 2GB of RAM it crashed immediately with the error attached
> below. The machine was under "stresstest-simulation" load at this time.
...
> kernel: kernel BUG at /usr/local/src/kernel/linux-2.4.13/include/asm/pci.h:142!
...
> kernel: scsi0:0:0:0: Attempting to queue an ABORT message
> kernel: (scsi0:A:0:0): Queuing a recovery SCB
> kernel: scsi0:0:0:0: Device is disconnected, re-queuing SCB  
...

-- 
Christian Hammers    WESTEND GmbH - Aachen und Dueren     Tel 0241/701333-0
ch@westend.com     Internet & Security for Professionals    Fax 0241/911879
           WESTEND ist CISCO Systems Partner - Premium Certified

