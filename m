Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280133AbRKNFZH>; Wed, 14 Nov 2001 00:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280146AbRKNFY5>; Wed, 14 Nov 2001 00:24:57 -0500
Received: from 66-108-76-7.nyc.rr.com ([66.108.76.7]:7663 "EHLO
	localhost.galis.org") by vger.kernel.org with ESMTP
	id <S280133AbRKNFYl>; Wed, 14 Nov 2001 00:24:41 -0500
Date: Wed, 14 Nov 2001 00:25:13 -0500
From: George Georgalis <george@galis.org>
To: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Buslogic SCSI hangs with cdrecord
Message-ID: <20011114002513.D676@trot>
Reply-To: George Georgalis <george@galis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Haven't posted or been around in a while so I hope this isn't a rehash.
I didn't find anything in a quick goggle search...

I'm having trouble writing CDs. I'll get from 0% to 75% (varies)
through the process and the whole machine locks up, no oops and nothing
in the log after a restart.

I've been running a 2.2.19-6.2.12 kernel (RH 6.2 updated rpm). And today
I tried using a monolithic vmlinuz-2.2.20 with identical results.

Here is a typical record command, I've tried it at 2, 4 and 8 speed.

cdrecord -v speed=8 dev=0,3,0  -data ~ftp/pub/ISOs/enigma-i386-disc1.iso 

I'm running an AMD Athlon Processor at 1200MHz on a Soyo SY-K7VTA PRO   
board with lots of ram and no other responsibilities.                   

below is the scsi details, has anyone heard of similar problems?

Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: YAMAHA   Model: CRW8424S         Rev: 1.0j
  Type:   CD-ROM                           ANSI SCSI revision: 02


***** BusLogic SCSI Driver Version 2.1.15 of 17 August 1998 *****
Copyright 1995-1998 by Leonard N. Zubkoff <lnz@dandelion.com>
Configuring BusLogic Model BT-930 PCI Ultra SCSI Host Adapter
  Firmware Version: 5.02, I/O Address: 0xD800, IRQ Channel: 11/Level
  PCI Bus: 0, Device: 9, Address: 0xD5000000, Host Adapter SCSI ID: 7
  Parity Checking: Enabled, Extended Translation: Enabled
  Synchronous Negotiation: Fast, Wide Negotiation: Disabled
  Disconnect/Reconnect: Enabled, Tagged Queuing: Enabled
  Driver Queue Depth: 255, Scatter/Gather Limit: 128 segments
  Tagged Queue Depth: Automatic, Untagged Queue Depth: 3
  Error Recovery Strategy: Default, SCSI Bus Reset: Enabled
  SCSI Bus Termination: Enabled, SCAM: Disabled
*** BusLogic BT-930 Initialized Successfully ***


// George

(comments on Soyo SY-K7VTA PRO built in sound are also welcome)

-- 
GEORGE GEORGALIS, Principal        http://www.galis.org/george 
System Administration Services      email: george@galis.org 
PGP Key ID: 98311631                  cell: 347-451-8229
