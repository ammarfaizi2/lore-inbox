Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263137AbTAEFjs>; Sun, 5 Jan 2003 00:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbTAEFjs>; Sun, 5 Jan 2003 00:39:48 -0500
Received: from enchanter.real-time.com ([208.20.202.11]:28676 "EHLO
	enchanter.real-time.com") by vger.kernel.org with ESMTP
	id <S263137AbTAEFjr>; Sun, 5 Jan 2003 00:39:47 -0500
Date: Sat, 4 Jan 2003 23:48:19 -0600
From: Carl Wilhelm Soderstrom <chrome@real-time.com>
To: linux-kernel@vger.kernel.org
Subject: Re: fs corruption with 2.4.20 IDE+md+LVM
Message-ID: <20030104234814.B18611@real-time.com>
References: <20030104224455.A18362@real-time.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030104224455.A18362@real-time.com>; from chrome@real-time.com on Sat, Jan 04, 2003 at 10:45:00PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 04, 2003 at 10:45:00PM -0600, Carl Wilhelm Soderstrom wrote:
> I observed filesystem corruption on my home workstation recently. I was
> running kernel 2.4.20 (built myself with gcc 2.95.4), and ext3 with the
> default journaling mode (ordered?).

I should probably include some details about my IDE devices.

here's the controller for the devices in question. it's the second
controller on the mobo. (first controller is only ATA-66)

00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev
02)
        Subsystem: Promise Technology, Inc. Ultra100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at 9400 [size=8]
        Region 1: I/O ports at 9000 [size=4]
        Region 2: I/O ports at 8800 [size=8]
        Region 3: I/O ports at 8400 [size=4]
        Region 4: I/O ports at 8000 [size=64]
        Region 5: Memory at de800000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: <available only to root>

and here's the output of hdparm. (yes, I know it could probably get tweaked
a bit for performance. this is a brand-new drive arrangement, and I was
trying to run it in a 'safe' setting for a while to see if anything would go
wrong. well, it did).

~# hdparm /dev/hde

/dev/hde:
 multcount    =  0 (off)
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 155061/16/63, sectors = 156301488, start = 0
~# hdparm /dev/hdf

/dev/hdf:
 multcount    =  0 (off)
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 155061/16/63, sectors = 156301488, start = 0

Carl Soderstrom.
-- 
Systems Administrator
Real-Time Enterprises
www.real-time.com
