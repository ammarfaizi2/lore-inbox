Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271412AbTHDHmK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 03:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270524AbTHDHmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 03:42:10 -0400
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:11533 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S271412AbTHDHl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 03:41:58 -0400
X-Envelope-From: roubm9am@barbora.ms.mff.cuni.cz
Message-ID: <001201c35a5b$da224a70$401a71c3@izidor>
From: "Milan Roubal" <roubm9am@barbora.ms.mff.cuni.cz>
To: "Matias Alejo Garcia" <linux@matiu.com.ar>,
       "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: "Kernel" <linux-kernel@vger.kernel.org>
References: <Pine.SOL.4.30.0308012107270.9493-100000@mion.elka.pw.edu.pl> <1059942870.991.10.camel@runner>
Subject: Re: Badness in IDE with hda and CompactFlash
Date: Mon, 4 Aug 2003 09:41:43 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-15"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have got similar problem, the Call trace looks the same in my notebook,
with standart 2,5 Toshiba 30 GB harddrive. But I am not able to boot,
so no way for me to get this call trace to file.
    Milan Roubal


----- Original Message ----- 
From: "Matias Alejo Garcia" <linux@matiu.com.ar>
To: "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: "Kernel" <linux-kernel@vger.kernel.org>
Sent: Sunday, August 03, 2003 10:34 PM
Subject: Badness in IDE with hda and CompactFlash


Bartlomiej,
I did what you requested. Below is the log files when I insert the
CampactFlash in the PCMCIA adapter. I am using 2.6.0.test2. After the I
insert WARN_ON(1) in check.c, when my hda is detected I get a 'Badness',
same as with the CF... I am sending the logs during the detection with
the hda and during the insertiong with the CF.

Thanks! Let me know if I can do more testing.
matías
PS: I am using ACPI, I try acpi=nopci and acpi=off, but the problem
pesist.



******When booting, detecing the HDA
-------------------------------- 
Aug  3 16:22:15 runner kernel: ide: Assuming 33MHz system bus speed for
PIO modes; override with idebus=xx
Aug  3 16:22:15 runner kernel: ICH3M: IDE controller at PCI slot
0000:00:1f.1
Aug  3 16:22:15 runner kernel: PCI: Enabling device 0000:00:1f.1 (0005
-> 0007)
Aug  3 16:22:15 runner kernel: ICH3M: chipset revision 2
Aug  3 16:22:15 runner kernel: ICH3M: not 100%% native mode: will probe
irqs later
Aug  3 16:22:15 runner kernel:     ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS
settings: hda:DMA, hdb:DMA
Aug  3 16:22:15 runner kernel:     ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS
settings: hdc:pio, hdd:pio
Aug  3 16:22:15 runner kernel: hda: IC25N040ATCS04-0, ATA DISK drive
Aug  3 16:22:15 runner kernel: hdb: HL-DT-STCD-RW/DVD-ROM GCC-4240N,
ATAPI CD/DVD-ROM drive
Aug  3 16:22:15 runner kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug  3 16:22:15 runner kernel: hda: max request size: 128KiB
Aug  3 16:22:15 runner kernel: hda: host protected area => 1
Aug  3 16:22:15 runner kernel: hda: 78140160 sectors (40008 MB)
w/1768KiB Cache, CHS=77520/16/63, UDMA(100)
Aug  3 16:22:15 runner kernel: hda: only one drive on a channel
supported for tcq
Aug  3 16:22:15 runner kernel: Badness in register_disk at
fs/partitions/check.c:361
Aug  3 16:22:15 runner kernel: Call Trace:
Aug  3 16:22:15 runner kernel:  [<c018905e>] register_disk+0xee/0x168
Aug  3 16:22:15 runner kernel:  [<c0233818>] add_disk+0x4e/0x5e
Aug  3 16:22:15 runner kernel:  [<c02337a4>] exact_match+0x0/0x8
Aug  3 16:22:15 runner kernel:  [<c02337ac>] exact_lock+0x0/0x1e
Aug  3 16:22:15 runner kernel:  [<c024e320>] idedisk_attach+0x12c/0x1ac
Aug  3 16:22:15 runner kernel:  [<c0249c1e>] ata_attach+0x96/0x1b2
Aug  3 16:22:15 runner kernel:  [<c024ad91>]
ide_register_driver+0x103/0x116
Aug  3 16:22:15 runner kernel:  [<c024e3af>] idedisk_init+0xf/0x14
Aug  3 16:22:15 runner kernel:  [<c03c4717>] do_initcalls+0x27/0x94
Aug  3 16:22:15 runner kernel:  [<c013125d>] init_workqueues+0xf/0x26
Aug  3 16:22:15 runner kernel:  [<c010509a>] init+0x36/0x194
Aug  3 16:22:15 runner kernel:  [<c0105064>] init+0x0/0x194
Aug  3 16:22:15 runner kernel:  [<c0109219>]
kernel_thread_helper+0x5/0xc
Aug  3 16:22:15 runner kernel:
Aug  3 16:22:15 runner kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6
hda7 hda8 >


******When starting cardmgr and Inserting a CF flash, detecing the HDA
--------------------------------
Aug  3 16:19:01 runner kernel: Linux Kernel Card Services 3.1.22
Aug  3 16:19:01 runner kernel:   options:  [pci] [cardbus] [pm]
Aug  3 16:19:01 runner kernel: PCI: Enabling device 0000:02:01.0 (0000
-> 0002)
Aug  3 16:19:01 runner kernel: ti113x: Routing card interrupts to PCI
Aug  3 16:19:01 runner kernel: Yenta IRQ list 0000, PCI irq11
Aug  3 16:19:01 runner kernel: Socket status: 30000006
Aug  3 16:19:01 runner kernel: PCI: Enabling device 0000:02:01.1 (0000
-> 0002)
Aug  3 16:19:01 runner kernel: ti113x: Routing card interrupts to PCI
Aug  3 16:19:01 runner kernel: Yenta IRQ list 0000, PCI irq11
Aug  3 16:19:01 runner kernel: Socket status: 30000006
Aug  3 16:19:02 runner cardmgr[737]: starting, version is 3.1.31
Aug  3 16:19:02 runner cardmgr[737]: watching 2 sockets
Aug  3 16:19:02 runner cardmgr[737]: Card Services release does not
match
Aug  3 16:19:02 runner kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Aug  3 16:19:02 runner kernel: cs: IO port probe 0x0100-0x04ff:
excluding 0x170-0x177 0x280-0x287 0x2f8-0x2ff 0x370-0x37f 0x3c0-0x3df
0x3f8-0x3ff 0x4d0-0x4d7
Aug  3 16:19:02 runner kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Aug  3 16:19:10 runner kernel: cs: memory probe 0xa0000000-0xa0ffffff:
clean.
Aug  3 16:19:10 runner cardmgr[737]: socket 1: ATA/IDE Fixed Disk
Aug  3 16:19:10 runner cardmgr[737]: executing: 'modprobe ide-cs'
Aug  3 16:19:13 runner kernel: hde: SanDisk SDCFB-32, CFA DISK drive
Aug  3 16:19:13 runner kernel: ide2 at 0x100-0x107,0x10e on irq 11
Aug  3 16:19:13 runner kernel: hde: max request size: 128KiB
Aug  3 16:19:13 runner kernel: hde: task_no_data_intr: status=0x51 {
DriveReady SeekComplete Error }
Aug  3 16:19:13 runner kernel: hde: task_no_data_intr: error=0x04 {
DriveStatusError }
Aug  3 16:19:13 runner kernel: hde: 62720 sectors (32 MB) w/1KiB Cache,
CHS=490/4/32
Aug  3 16:19:13 runner kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Aug  3 16:19:13 runner kernel:  printing eip:
Aug  3 16:19:13 runner kernel: 00000000
Aug  3 16:19:13 runner kernel: *pde = 00000000
Aug  3 16:19:13 runner kernel: Oops: 0000 [#1]
Aug  3 16:19:13 runner kernel: CPU:    0
Aug  3 16:19:13 runner kernel: EIP:    0060:[<00000000>]    Not
tainted                          Aug  3 16:19:13 runner kernel: EFLAGS:
00010246
Aug  3 16:19:13 runner kernel: EIP is at 0x0
Aug  3 16:19:13 runner kernel: eax: c03faa20   ebx: 0000f49c   ecx:
00000001   edx: 00000000
Aug  3 16:19:13 runner kernel: esi: c03faacc   edi: deb58800   ebp:
00000004   esp: ddeb55ac     Aug  3 16:19:13 runner kernel: ds: 007b
es: 007b   ss: 0068
Aug  3 16:19:13 runner kernel: Process cardmgr (pid: 737,
threadinfo=ddeb4000 task=ddf6e180)
Aug  3 16:19:13 runner kernel: Stack: c024ded7 c03faacc 000001ea
00000004 00000020 00000020 2038ca40 c03faacc
Aug  3 16:19:13 runner kernel:        c038cb64 ddeb4000 ddf5f180
c024e2a5 c03faacc c038caa0 00000001 00000001
Aug  3 16:19:13 runner kernel:        c038cb64 ddeb4000 c038caa0
c0249c1e c03faacc ddeb4000 ddeb4000 c03faa20
Aug  3 16:19:13 runner kernel: Call Trace:
Aug  3 16:19:13 runner kernel:  [<c024ded7>] idedisk_setup+0x299/0x338
Aug  3 16:19:13 runner kernel:  [<c024e2a5>] idedisk_attach+0xb1/0x1ac
Aug  3 16:19:13 runner kernel:  [<c0249c1e>] ata_attach+0x96/0x1b2
Aug  3 16:19:13 runner kernel:  [<c024371f>] ideprobe_init+0xdf/0xfb
Aug  3 16:19:13 runner kernel:  [<c02481a9>] ide_probe_module+0xd/0x10
Aug  3 16:19:13 runner kernel:  [<c0248e82>] ide_register_hw+0x154/0x186
Aug  3 16:19:13 runner kernel:  [<e08e7260>] idecs_register+0x5e/0x70
[ide_cs]
Aug  3 16:19:13 runner kernel:  [<e095dace>] CardServices+0x208/0x351
[pcmcia_core]
Aug  3 16:19:13 runner kernel:  [<e09560b4>] set_cis_map+0x40/0x10c
[pcmcia_core]
Aug  3 16:19:13 runner kernel:  [<e08e777e>] ide_config+0x50c/0x854
[ide_cs]
Aug  3 16:19:13 runner kernel:  [<e09562a1>] read_cis_mem+0x121/0x18c
[pcmcia_core]
Aug  3 16:19:13 runner kernel:  [<e09560b4>] set_cis_map+0x40/0x10c
[pcmcia_core]
Aug  3 16:19:13 runner kernel:  [<e09562a1>] read_cis_mem+0x121/0x18c
[pcmcia_core]
Aug  3 16:19:13 runner kernel:  [<e0956545>] read_cis_cache+0xdf/0x16a
[pcmcia_core]
Aug  3 16:19:13 runner kernel:  [<e0956e45>]
pcmcia_get_tuple_data+0x91/0x96 [pcmcia_core]
Aug  3 16:19:13 runner kernel:  [<e0958065>]
pcmcia_parse_tuple+0x109/0x16e [pcmcia_core]
Aug  3 16:19:13 runner kernel:  [<e095816c>] read_tuple+0xa2/0xa4
[pcmcia_core]
Aug  3 16:19:13 runner kernel:  [<e08da7e2>]
yenta_set_mem_map+0x1e0/0x232 [yenta_socket]
Aug  3 16:19:13 runner kernel:  [<e08da7e2>]
yenta_set_mem_map+0x1e0/0x232 [yenta_socket]
Aug  3 16:19:13 runner kernel:  [<e0956d63>]
pcmcia_get_next_tuple+0x231/0x282 [pcmcia_core]
Aug  3 16:19:13 runner kernel:  [<e09568b4>]
pcmcia_get_first_tuple+0xa0/0x138 [pcmcia_core]
Aug  3 16:19:13 runner kernel:  [<e08da7e2>]
yenta_set_mem_map+0x1e0/0x232 [yenta_socket]
Aug  3 16:19:13 runner kernel:  [<e08da7e2>]
yenta_set_mem_map+0x1e0/0x232 [yenta_socket]
Aug  3 16:19:13 runner kernel:  [<e09560b4>] set_cis_map+0x40/0x10c
[pcmcia_core]
Aug  3 16:19:13 runner kernel:  [<e09562a1>] read_cis_mem+0x121/0x18c
[pcmcia_core]
Aug  3 16:19:13 runner kernel:  [<e0956545>] read_cis_cache+0xdf/0x16a
[pcmcia_core]
Aug  3 16:19:13 runner kernel:  [<e0956e45>]
pcmcia_get_tuple_data+0x91/0x96 [pcmcia_core]
Aug  3 16:19:13 runner kernel:  [<e0958065>]
pcmcia_parse_tuple+0x109/0x16e [pcmcia_core]
Aug  3 16:19:13 runner kernel:  [<e095816c>] read_tuple+0xa2/0xa4
[pcmcia_core]
Aug  3 16:19:13 runner kernel:  [<e08da7e2>]
yenta_set_mem_map+0x1e0/0x232 [yenta_socket]
Aug  3 16:19:13 runner kernel:  [<e08da7e2>]
yenta_set_mem_map+0x1e0/0x232 [yenta_socket]
Aug  3 16:19:13 runner kernel:  [<e0956d63>]
pcmcia_get_next_tuple+0x231/0x282 [pcmcia_core]
Aug  3 16:19:13 runner kernel:  [<e09568b4>]
pcmcia_get_first_tuple+0xa0/0x138 [pcmcia_core]
Aug  3 16:19:13 runner kernel:  [<e0956545>] read_cis_cache+0xdf/0x16a
[pcmcia_core]
Aug  3 16:19:13 runner kernel:  [<e0956d63>]
pcmcia_get_next_tuple+0x231/0x282 [pcmcia_core]
Aug  3 16:19:13 runner kernel:  [<e095828c>]
pcmcia_validate_cis+0x11e/0x1ea [pcmcia_core]
Aug  3 16:19:14 runner kernel:  [<c0159f7b>] wake_up_buffer+0xf/0x26
Aug  3 16:19:14 runner kernel:  [<c019a8b3>]
do_get_write_access+0x2cb/0x5e8
Aug  3 16:19:14 runner kernel:  [<e08e7c55>] ide_event+0x67/0xea
[ide_cs]
Aug  3 16:19:14 runner kernel:  [<e095c676>]
pcmcia_register_client+0x1c8/0x1fe [pcmcia_core]
Aug  3 16:19:14 runner kernel:  [<c01927b4>]
ext3_mark_iloc_dirty+0x28/0x36
Aug  3 16:19:14 runner kernel:  [<e08da7e2>]
yenta_set_mem_map+0x1e0/0x232 [yenta_socket]
Aug  3 16:19:14 runner kernel:  [<c018f7eb>]
ext3_splice_branch+0x121/0x1d8
Aug  3 16:19:14 runner kernel:  [<e095da67>] CardServices+0x1a1/0x351
[pcmcia_core]
Aug  3 16:19:14 runner kernel:  [<e08e7110>] ide_attach+0x110/0x150
[ide_cs]
Aug  3 16:19:14 runner kernel:  [<e08e7bee>] ide_event+0x0/0xea [ide_cs]
Aug  3 16:19:14 runner kernel:  [<e09173bf>] get_pcmcia_driver+0x3f/0x5a
[ds]
Aug  3 16:19:14 runner kernel:  [<e09164b0>] bind_request+0x180/0x214
[ds]
Aug  3 16:19:14 runner kernel:  [<e09568b4>]
pcmcia_get_first_tuple+0xa0/0x138 [pcmcia_core]
Aug  3 16:19:14 runner kernel:  [<e0917069>] ds_ioctl+0x5eb/0x6ec [ds]
Aug  3 16:19:14 runner kernel:  [<c011ed9a>] preempt_schedule+0x36/0x50
Aug  3 16:19:14 runner kernel:  [<c02e5771>]
unix_dgram_sendmsg+0x36b/0x56c
Aug  3 16:19:14 runner kernel:  [<c027dd8e>] sock_sendmsg+0x9e/0xca
Aug  3 16:19:14 runner kernel:  [<c0170cd0>] alloc_inode+0x1c/0x148
Aug  3 16:19:14 runner kernel:  [<c0171c96>] iget_locked+0x96/0xc0
Aug  3 16:19:14 runner kernel:  [<c0183049>] proc_read_inode+0x17/0x3c
Aug  3 16:19:14 runner kernel:  [<c013d4b1>] find_get_page+0x29/0x64
Aug  3 16:19:14 runner kernel:  [<c013e856>] filemap_nopage+0x26c/0x384
Aug  3 16:19:14 runner kernel:  [<c01859d4>] proc_lookup+0xba/0x124
Aug  3 16:19:14 runner kernel:  [<c01415f1>] buffered_rmqueue+0xd1/0x192
Aug  3 16:19:14 runner kernel:  [<c014971a>] zap_pmd_range+0x48/0x64
Aug  3 16:19:14 runner kernel:  [<c014977f>] unmap_page_range+0x49/0x88
Aug  3 16:19:14 runner kernel:  [<c0149880>] unmap_vmas+0xc2/0x22e
Aug  3 16:19:14 runner kernel:  [<c014d289>] unmap_region+0x9b/0xde
Aug  3 16:19:14 runner kernel:  [<c014d188>] unmap_vma+0x40/0x7e
Aug  3 16:19:14 runner kernel:  [<c014d1e2>] unmap_vma_list+0x1c/0x28
Aug  3 16:19:14 runner kernel:  [<c014d5b8>] do_munmap+0x166/0x1ce
Aug  3 16:19:14 runner kernel:  [<c016a689>] sys_ioctl+0xf3/0x27a
Aug  3 16:19:14 runner kernel:  [<c010b22b>] syscall_call+0x7/0xb
Aug  3 16:19:14 runner kernel:
Aug  3 16:19:14 runner kernel: Code:  Bad EIP value.


******** Ejecting the CF
-----------------------
Aug  3 16:20:56 runner kernel:  <4>Trying to free nonexistent resource
<00000100-0000010f>






On Fri, 2003-08-01 at 15:10, Bartlomiej Zolnierkiewicz wrote:
> Can you apply this patch and reproduce bug (please don't eject the
> CF card), it will give some more info about whats going on.
>
> --
> Bartlomiej
>
> --- linux/fs/partitions/check.c.orig 2003-07-28 21:42:06.000000000 +0200
> +++ linux/fs/partitions/check.c 2003-08-01 21:04:15.175952424 +0200
> @@ -357,6 +357,7 @@
>  bdev = bdget_disk(disk, 0);
>  if (blkdev_get(bdev, FMODE_READ, 0, BDEV_RAW) < 0)
>  return;
> + WARN_ON(1);
>  state = check_partition(disk, bdev);
>  if (state) {
>  for (j = 1; j < state->limit; j++) {
>
> On Fri, 1 Aug 2003, Russell King wrote:
>
> > On Fri, Jul 25, 2003 at 06:58:25AM -0400, Matias Alejo Garcia wrote:
> > > Hi,
> > > When I insert a SanDisk o Ridata CompactFlash card to the PCMCIA
adapter
> > > (this used to work OK in 2.4.20), the load of the module ide-cs dumps
a
> > > Call Trace, then, if I eject the CF card, the system crash. (see
below)
> > >
> > > Is there a patch for this? I am sure the problem is in ide-cs, others
> > > pcmcia cards are working OK.
> > >
> > > Thanks. Matias
> > > Logs:(starting when I load cardctl and ds/yenta_socket/pcmcia_core,
> > > the problem is at 6:33:13, when I insert the CF card)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

