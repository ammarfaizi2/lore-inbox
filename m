Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129469AbRBYSBb>; Sun, 25 Feb 2001 13:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129451AbRBYSBV>; Sun, 25 Feb 2001 13:01:21 -0500
Received: from venus.cs.uml.edu ([129.63.8.51]:14347 "EHLO venus.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129449AbRBYSBO>;
	Sun, 25 Feb 2001 13:01:14 -0500
Date: Sun, 25 Feb 2001 12:58:26 -0500 (EST)
From: Mike Brown <mbrown@cs.uml.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: A E Lawrence <adrian.lawrence@computing-services.oxford.ac.uk>,
        ian@wehrman.com, mhaque@haque.net, adilger@turbolinux.com,
        linux-kernel@vger.kernel.org
Subject: Re: EXT2-fs error
In-Reply-To: <E14Wi2k-00009c-00@the-village.bc.nu>
Message-ID: <Pine.OSF.3.96.1010225124937.212957B-100000@venus.cs.uml.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Feb 2001, Alan Cox wrote:

>> I have seen similar problems on stock 2.4.2 a machine which has not run
>> 2.4.1.
>
>What disk controllers ? We really need that sort of info in order to see the
>pattern in the odd reports of corruption we get
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>

I also just ran into the ext2 bug:

Feb 25 06:27:05 morpheus kernel: EXT2-fs error (device ide0(3,1)):
ext2_readdir:
 directory #881700 contains a hole at offset 0
Feb 25 06:27:05 morpheus kernel: Remounting filesystem read-only

I had been running 2.4.1 before upgrading to 2.4.2.  My machine had been
up with 2.4.1 for 13 days, then i added a system fan, then it was up for
another 8 days after that with no problems.

Up with 2.4.2 for about a day and I ran into the above ext2 error.  I also
have the VIA Apollo chipset:

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set
        Region 4: I/O ports at d000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Also, during boot phase I had been manually running:

/sbin/hdparm -d1 /dev/hda

To turn on DMA on my primary disk since the 2.2.x series didn't turn this
on by default.  /dev/hda is a Western Digital:

Feb 25 12:35:37 morpheus kernel: hda: WDC WD273BA, ATA DISK drive
Feb 25 12:35:37 morpheus kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb 25 12:35:37 morpheus kernel: hda: 53464320 sectors (27374 MB) w/1961KiB Cache, CHS=3328/255/63


Let me know if there is any other information I can provide.  I also have
a notebook which as been running 2.4.2 without trouble for a few days.
This notebook has an Intel IDE controller.  Seems to me like this is a VIA
Apollo bug......  Thanks.


-Michael F. Brown, UMass Lowell Computer Science

phone:  (978) 934-5354
email:  mbrown@cs.uml.edu

int *x; while (1) { x = (int *) malloc (sizeof (int)); }

