Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278714AbRJTBoe>; Fri, 19 Oct 2001 21:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278715AbRJTBoZ>; Fri, 19 Oct 2001 21:44:25 -0400
Received: from smtp2.orcon.net.nz ([210.55.12.15]:20235 "EHLO
	smtp2.orcon.net.nz") by vger.kernel.org with ESMTP
	id <S278714AbRJTBoN>; Fri, 19 Oct 2001 21:44:13 -0400
Message-ID: <00e401c15908$cacf05a0$0400000a@LENNON>
From: "Craig Whitmore" <lennon@orcon.net.nz>
To: "Richard Garand" <krogoth2@softhome.net>, <linux-kernel@vger.kernel.org>
In-Reply-To: <courier.3BD0CFF2.00002135@softhome.net>
Subject: Re: Promise FastTrak boot freeze on 2.4.12/+ac3
Date: Sat, 20 Oct 2001 14:44:42 +1300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a promise Lite controller running in Raid1 mode using reiserfs
booting with lilo and it seems to work really well
Raid1 support was added in in 2.4.11 and 2.4.12 gives quite a few errors
with the fs, but the 2.4.12-ac2 works fine

Where did it get up to with you????


PDC20265: IDE controller on PCI bus 00 dev 80
PDC20265: chipset revision 2
ide: Found promise 20265 in RAID mode.
PDC20265: not 100% native mode: will probe irqs later
PDC20265: ROM enabled at 0xdffd0000
PDC20265: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
Mode.
    ide2: BM-DMA at 0xcc00-0xcc07, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xcc08-0xcc0f, BIOS settings: hdg:pio, hdh:pio
hdd: ATAPI CDROM 48X, ATAPI CD/DVD-ROM drive
hde: IC35L040AVER07-0, ATA DISK drive
hdg: IC35L040AVER07-0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xdc00-0xdc07,0xd802 on irq 10
ide3 at 0xd400-0xd407,0xd002 on irq 10
hde: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63, UDMA(100)
hdg: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63, UDMA(100)
....
 ataraid/d0: ataraid/d0p1 ataraid/d0p2
Drive 0 is 39266 Mb (33 / 0)
Drive 1 is 39266 Mb (34 / 0)
Raid1 array consists of 2 drives.
Promise Fasttrak(tm) Softwareraid driver for linux version 0.03beta

----------------------------------------------------------------------------
--
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/ataraid/d0p2     39936364  38069196   1867168  96% /
----------------------------------------------------------------------------
--
           Device Boot    Start       End    Blocks   Id  System
/dev/ataraid/d0p1             1        33    265041   82  Linux swap
/dev/ataraid/d0p2            34      5005  39937590   83  Linux native
----------------------------------------------------------------------------
--
boot=/dev/ataraid/d0
root=/dev/ataraid/d0p2
disk=/dev/ataraid/d0
    bios=0x80
lba32
install=/boot/boot-menu.b
ignore-table
timeout=300
prompt
map=/boot/map
image=/vmlinuz
    label=Linux
    read-only
-----------------------------------------------------------------------

Thanks
Craig Whitmore
Orcon Internet
http://www.orcon.net.nz

----- Original Message -----
From: "Richard Garand" <krogoth2@softhome.net>
To: <linux-kernel@vger.kernel.org>
Sent: Saturday, October 20, 2001 2:18 PM
Subject: Promise FastTrak boot freeze on 2.4.12/+ac3


> I'm using a Promise FastTrak 66 controller with a custom slackware 8
> bootdisk, and every time I try to boot it freezes after detecting hde,
hdg,
> ide10 ide2, and ide3 (I have one drive on each port on the controller in
> RAID0 and a CD on the main IDE bus). I tried with kernel 2.4.12 and
> 2.4.12-ac3, enabling both Promise FastTrak options (one for the
controller,
> one for IDE RAID) and software RAID. I've done searches on google and
their
> newsgroup archives and haven't found anything describing a solution to
this
> problem.
>
> I will do my best to provide any additional information that could help if
> this is a new problem, but it can be a bit slow since I can only transfer
it
> by swapping the video cable and using BioLink (TM of RealLife, INC).
> --
> Richard Garand
> krogoth2@softhome.net, r.garand@sk.sympatico.ca
> (L)ICQ: 12190132
> Then: I have discovered a truly remarkable proof which this margin is too
> small to contain.
> Now: Microsoft has released an unremarkable product which your hard drive
is
> too small to contain.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

