Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbTINDVn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 23:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTINDVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 23:21:43 -0400
Received: from dat.etsit.upm.es ([138.100.17.73]:23254 "HELO dat.etsit.upm.es")
	by vger.kernel.org with SMTP id S262282AbTINDVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 23:21:38 -0400
Date: Sun, 14 Sep 2003 05:21:37 +0200
From: Carlos Valdivia =?iso-8859-15?Q?Yag=FCe?= 
	<valyag@dat.etsit.upm.es>
To: linux-kernel@vger.kernel.org
Subject: atp870u oops while loading
Message-ID: <20030914032136.GA21652@dat.etsit.upm.es>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

I get the following oops trying to load atp870u on 2.6.0-test5:

<--->

irq 5: nobody cared!
handlers:
[<d9a29000>] (atp870u_intr_handle+0x0/0x810 [atp870u])
Disabling IRQ #5

Message from syslogd@fourier at Sun Sep 14 05:08:09 2003 ...
fourier kernel: Disabling IRQ #5
Unable to handle kernel NULL pointer dereference at virtual address 00000484
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<d9a2c0ce>]    Not tainted
EFLAGS: 00010202
EIP is at atp870u_detect+0x12e/0x930 [atp870u]
eax: 00000001   ebx: ffffffff   ecx: 00000001   edx: 00000370
esi: 0000e03b   edi: 00000033   ebp: cb768800   esp: cc91fbfc
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 4206, threadinfo=cc91e000 task=c7909880)
Stack: c029ece0 0000e000 00000040 d9a2ce60 cb768800 00000177 00000001 00000009
       cb7689ac 0000e03a c01f0483 cc91e000 00000001 0000e000 00000282 07050190
       0000e000 c01efdd0 0000e020 c032b204 00200010 c01e7407 c032b2b0 00000176
Call Trace:
 [<c01f0483>] __ide_dma_count+0x13/0x20
 [<c01efdd0>] dma_timer_expiry+0x0/0x90
 [<c01e7407>] __ide_do_rw_disk+0xc7/0x6b0
 [<c01d4a7f>] as_remove_queued_request+0x7f/0x110
 [<c0190c82>] __delay+0x12/0x20
 [<c01d4d8a>] as_move_to_dispatch+0x8a/0x130
 [<c01dc630>] start_request+0x160/0x270
 [<c01dc971>] ide_do_request+0x201/0x380
 [<c01d5148>] as_next_request+0x38/0x50
 [<c0119650>] schedule+0x1c0/0x3e0
 [<c01cf125>] generic_unplug_device+0x75/0x80
 [<c01cf29a>] blk_run_queues+0x7a/0xb0
 [<c0135d18>] __lock_page+0xb8/0xd0
 [<c011af50>] autoremove_wake_function+0x0/0x50
 [<c013bd14>] do_page_cache_readahead+0xf4/0x170
 [<c011af50>] autoremove_wake_function+0x0/0x50
 [<c0135d5c>] find_get_page+0x2c/0x60
 [<c0136e87>] filemap_nopage+0x277/0x300
 [<c0143513>] do_no_page+0x1b3/0x340
 [<c0143894>] handle_mm_fault+0xd4/0x170
 [<c01180b1>] do_page_fault+0x251/0x451
 [<c0124303>] __mod_timer+0x123/0x170
 [<c0139b01>] buffered_rmqueue+0xd1/0x170
 [<c0149ea9>] map_area_pmd+0x69/0xa0

<--->

ksymoops output is attached. Hardware used:

00:0a.0 SCSI storage controller: Artop Electronic Corp AEC6712D SCSI (rev 02)
        Subsystem: Artop Electronic Corp AEC6712D SCSI
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at e000 [size=64]
        Capabilities: <available only to root>

-- 
Carlos Valdivia Yagüe <valyag@dat.etsit.upm.es>

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename=atp870u_oops

ksymoops 2.4.9 on i686 2.6.0-test5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test5/ (default)
     -m /boot/System.map-2.6.0-test5 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
[<d9a29000>] (atp870u_intr_handle+0x0/0x810 [atp870u])
Unable to handle kernel NULL pointer dereference at virtual address
00000484
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<d9a2c0ce>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000001   ebx: ffffffff   ecx: 00000001   edx: 00000370
esi: 0000e03b   edi: 00000033   ebp: cb768800   esp: cc91fbfc
ds: 007b   es: 007b   ss: 0068
Stack: c029ece0 0000e000 00000040 d9a2ce60 cb768800 00000177 00000001 00000009
       cb7689ac 0000e03a c01f0483 cc91e000 00000001 0000e000 00000282 07050190
       0000e000 c01efdd0 0000e020 c032b204 00200010 c01e7407 c032b2b0 00000176
Call Trace:
 [<c01f0483>] __ide_dma_count+0x13/0x20
 [<c01efdd0>] dma_timer_expiry+0x0/0x90
 [<c01e7407>] __ide_do_rw_disk+0xc7/0x6b0
 [<c01d4a7f>] as_remove_queued_request+0x7f/0x110
 [<c0190c82>] __delay+0x12/0x20
 [<c01d4d8a>] as_move_to_dispatch+0x8a/0x130
 [<c01dc630>] start_request+0x160/0x270
 [<c01dc971>] ide_do_request+0x201/0x380
 [<c01d5148>] as_next_request+0x38/0x50
 [<c0119650>] schedule+0x1c0/0x3e0
 [<c01cf125>] generic_unplug_device+0x75/0x80
 [<c01cf29a>] blk_run_queues+0x7a/0xb0
 [<c0135d18>] __lock_page+0xb8/0xd0
 [<c011af50>] autoremove_wake_function+0x0/0x50
 [<c013bd14>] do_page_cache_readahead+0xf4/0x170
 [<c011af50>] autoremove_wake_function+0x0/0x50
 [<c0135d5c>] find_get_page+0x2c/0x60
 [<c0136e87>] filemap_nopage+0x277/0x300
 [<c0143513>] do_no_page+0x1b3/0x340
 [<c0143894>] handle_mm_fault+0xd4/0x170
 [<c01180b1>] do_page_fault+0x251/0x451
 [<c0124303>] __mod_timer+0x123/0x170
 [<c0139b01>] buffered_rmqueue+0xd1/0x170
 [<c0149ea9>] map_area_pmd+0x69/0xa0
 [<c0149d7b>] unmap_area_pmd+0x4b/0x60
 [<c014a2c7>] vfree+0x27/0x40
 [<c0132759>] load_module+0x719/0x960
 [<d9832000>] init_this_scsi_driver+0x0/0x109 [atp870u]
 [<d9a2cc40>] atp870u_release+0x0/0xb0 [atp870u]
 [<d983203e>] init_this_scsi_driver+0x3e/0x109 [atp870u]
 [<c0132ab8>] sys_init_module+0x118/0x230
 [<c010931b>] syscall_call+0x7/0xb
Code: 8b 82 14 01 00 00 89 44 24 34 0f b6 82 0c 01 00 00 88 44 24


>>EIP; d9a2c0ce <_end+196f93d6/3fccb308>   <=====

>>ebx; ffffffff <__kernel_rt_sigreturn+1bbf/????>
>>ebp; cb768800 <_end+b435b08/3fccb308>
>>esp; cc91fbfc <_end+c5ecf04/3fccb308>

Trace; c01f0483 <__ide_dma_count+13/20>
Trace; c01efdd0 <dma_timer_expiry+0/90>
Trace; c01e7407 <__ide_do_rw_disk+c7/6b0>
Trace; c01d4a7f <as_remove_queued_request+7f/110>
Trace; c0190c82 <__delay+12/20>
Trace; c01d4d8a <as_move_to_dispatch+8a/130>
Trace; c01dc630 <start_request+160/270>
Trace; c01dc971 <ide_do_request+201/380>
Trace; c01d5148 <as_next_request+38/50>
Trace; c0119650 <schedule+1c0/3e0>
Trace; c01cf125 <generic_unplug_device+75/80>
Trace; c01cf29a <blk_run_queues+7a/b0>
Trace; c0135d18 <__lock_page+b8/d0>
Trace; c011af50 <autoremove_wake_function+0/50>
Trace; c013bd14 <do_page_cache_readahead+f4/170>
Trace; c011af50 <autoremove_wake_function+0/50>
Trace; c0135d5c <find_get_page+2c/60>
Trace; c0136e87 <filemap_nopage+277/300>
Trace; c0143513 <do_no_page+1b3/340>
Trace; c0143894 <handle_mm_fault+d4/170>
Trace; c01180b1 <do_page_fault+251/451>
Trace; c0124303 <__mod_timer+123/170>
Trace; c0139b01 <buffered_rmqueue+d1/170>
Trace; c0149ea9 <map_area_pmd+69/a0>
Trace; c0149d7b <unmap_area_pmd+4b/60>
Trace; c014a2c7 <vfree+27/40>
Trace; c0132759 <load_module+719/960>
Trace; d9832000 <_end+194ff308/3fccb308>
Trace; d9a2cc40 <_end+196f9f48/3fccb308>
Trace; d983203e <_end+194ff346/3fccb308>
Trace; c0132ab8 <sys_init_module+118/230>
Trace; c010931b <syscall_call+7/b>

Code;  d9a2c0ce <_end+196f93d6/3fccb308>
00000000 <_EIP>:
Code;  d9a2c0ce <_end+196f93d6/3fccb308>   <=====
   0:   8b 82 14 01 00 00         mov    0x114(%edx),%eax   <=====
Code;  d9a2c0d4 <_end+196f93dc/3fccb308>
   6:   89 44 24 34               mov    %eax,0x34(%esp,1)
Code;  d9a2c0d8 <_end+196f93e0/3fccb308>
   a:   0f b6 82 0c 01 00 00      movzbl 0x10c(%edx),%eax
Code;  d9a2c0df <_end+196f93e7/3fccb308>
  11:   88 44 24 00               mov    %al,0x0(%esp,1)


1 warning and 1 error issued.  Results may not be reliable.

--YiEDa0DAkWCtVeE4--
