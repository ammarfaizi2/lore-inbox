Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbTLWRoo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 12:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbTLWRoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 12:44:44 -0500
Received: from beta.fastwebnet.it ([213.140.2.43]:12456 "EHLO
	beta.fastwebnet.it") by vger.kernel.org with ESMTP id S261931AbTLWRog
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 12:44:36 -0500
Subject: Re: Ooops with kernel 2.4.22 and reiserfs
From: Carlo <devel@integra-sc.it>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10312230224280.7373-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10312230224280.7373-100000@master.linux-ide.org>
Content-Type: text/plain
Message-Id: <1072201502.21200.74.camel@atena>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 23 Dec 2003 18:45:02 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il mar, 2003-12-23 alle 11:39, Andre Hedrick ha scritto: 
> What hardware base are you using?
> 
> Mainboard vendor
> Chipset (north/south bridges) vendor
> Any and all revisions of bios'.
> Addon card lists.
> UP, SMP, Local-APIC

- Biostar M7VIP-PRO Socket A ATX MB w/the KT333 Chipset
- AMD Athlon(tm) XP 2700+
- Socket A Motherboard
- VIA KT333 North Bridge
- VIA 8235 South Bridge
- 200/266/333MHz FSB
- Integrated AC'97 audio
- Integrated 10/100 Ethernet
- 10/100 Ethernet (RealTek)
- 2 Videograbber (bttv)
- VGA ATI RADEON 7000
- Maxtor 6Y120L0, ATA DISK drive

The numbers from boot are (no bios upgrade are made):
Phoenix-AwardBIOS v.6.00PG

01/17/2003-kt333cf-8235-6A6LYB09C-00

I hope this data are useful form you.
Saluti Carlo!

PS: The same script run with no problems on another PC with different
MainBoard (DFI with VIA KT400 and VT8235CD) and other hardware is the
same.

> Anything to put something around the issue.
> 
> I also have some hardware which now shows all kinds of data corruption and
> is appears to waste the last page/bh in the transfer on writes.
> 
> Well that is all for now, this appears to be filesystem independent.
> The strange part is that both raw and o_direct do not appear to suffer
> this corruption.
> 
> Regards,
> 
> Andre Hedrick
> LAD Storage Consulting Group
> 
> On Mon, 22 Dec 2003, Carlo wrote:
> 
> > Hi all,
> > i receive the follow message error when i delete file from a large
> > partition (100GB) of an IDE drive (120GB) with reiserfs filesystem and
> > kernel 2.4.22. Other partitions are EXT3.
> >  
> > I received this message several time in my test that erase jpeg files in
> > nested directories.
> > May i increase the verbose of this error?
> > 
> > 
> > hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete
> > DataRequest }
> > ide0: Drive 0 didn't accept speed setting. Oh, well.
> > hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
> >  
> > hda: CHECK for good STATUS
> > Unable to handle kernel paging request at virtual address ffffffe0
> >  printing eip:
> > c0146553
> > *pde = 00002063
> > *pte = 00000000
> > Oops: 0000
> > CPU:    0
> > EIP:    0010:[<c0146553>]    Not tainted
> > EFLAGS: 00010213
> > eax: cded5f68   ebx: ffffffe0   ecx: cded5000   edx: 00000010
> > esi: 00000000   edi: cded5e40   ebp: cded5e68   esp: cb18bf24
> > ds: 0018   es: 0018   ss: 0018
> > Process rmdir (pid: 21907, stackpage=cb18b000)
> > Stack: 00000000 cded5e40 cded5e40 c2dfc340 cded5e40 bffffae8 c01465dd
> > cded5e40
> >        cded5e40 c013fa0f cded5e40 000001fe cb7d9040 c2dfc340 cded5e40
> > c018d840
> >        c013fb69 cded5e40 cded5d40 cb18bf9c 00000000 fffffff0 cded5e40
> > cded5e40
> > Call Trace:    [<c01465dd>] [<c013fa0f>] [<c018d840>] [<c013fb69>]
> > [<c013fc84>]
> >   [<c0114d00>] [<c01088a3>]
> >  
> > Code: 8b 03 8b 36 85 c0 75 32 8d 4b 18 8b 51 04 8b 43 18 89 50 04
> > 
> > []$ cat /proc/cpuinfo
> > processor       : 0
> > vendor_id       : AuthenticAMD
> > cpu family      : 6
> > model           : 8
> > model name      : AMD Athlon(tm) XP 2700+
> > stepping        : 1
> > cpu MHz         : 2158.060
> > cache size      : 256 KB
> > fdiv_bug        : no
> > hlt_bug         : no
> > f00f_bug        : no
> > coma_bug        : no
> > fpu             : yes
> > fpu_exception   : yes
> > cpuid level     : 1
> > wp              : yes
> > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> > mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
> > bogomips        : 4299.16


