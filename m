Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266762AbUF3Rdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266762AbUF3Rdc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 13:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266487AbUF3Rdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 13:33:32 -0400
Received: from lucidpixels.com ([66.45.37.187]:10631 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S266764AbUF3RcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 13:32:08 -0400
Date: Wed, 30 Jun 2004 13:31:59 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: "Venkatesan, Ganesh" <ganesh.venkatesan@intel.com>
cc: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>,
       linux-kernel@vger.kernel.org
Subject: RE: 2.6.5 Does Not Handle Jumbo Frames w/Intel GigE NIC - Page
 Allocation Failures
In-Reply-To: <468F3FDA28AA87429AD807992E22D07E019ADF87@orsmsx408>
Message-ID: <Pine.LNX.4.60.0406301331140.21480@p500>
References: <468F3FDA28AA87429AD807992E22D07E019ADF87@orsmsx408>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463747160-1520231160-1088616719=:21480"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463747160-1520231160-1088616719=:21480
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Certainly, attached.

On Wed, 30 Jun 2004, Venkatesan, Ganesh wrote:

> Justin:
>
> Could you also send me your kernel configuration
> (/usr/src/linux-2.6.7/.config) file?
>
> Thanks,
> ganesh
>
> -------------------------------------------------
> Ganesh Venkatesan
> Network/Storage Division, Hillsboro, OR
>
> -----Original Message-----
> From: Justin Piszcz [mailto:jpiszcz@lucidpixels.com]
> Sent: Saturday, June 26, 2004 1:57 AM
> To: Venkatesan, Ganesh
> Cc: Piszcz, Justin Michael; linux-kernel@vger.kernel.org
> Subject: RE: 2.6.5 Does Not Handle Jumbo Frames w/Intel GigE NIC - Page
> Allocation Failures
>
> Also under 2.6.7 on the other box now (did not do it w/2.4)
>
> When I try to copy a file, I get page allocation failures all over the
> place:
>
> printk: 11 messages suppressed.
> bzip2: page allocation failure. order:3, mode:0x20
>  [<c0137a8b>] __alloc_pages+0x2eb/0x300
>  [<c0137ab8>] __get_free_pages+0x18/0x40
>  [<c013b27f>] kmem_getpages+0x1f/0xc0
>  [<c013be7a>] cache_grow+0xba/0x250
>  [<c013c1db>] cache_alloc_refill+0x1cb/0x210
>  [<c037f140>] ip_rcv_finish+0x0/0x260
>  [<c013c741>] __kmalloc+0x71/0x80
>  [<c0366633>] alloc_skb+0x53/0x100
>  [<c02fc495>] e1000_alloc_rx_buffers+0x65/0x100
>  [<c02fc157>] e1000_clean_rx_irq+0x197/0x470
>  [<c037f02e>] ip_rcv+0x37e/0x490
>  [<c02fbd3d>] e1000_clean+0x4d/0xf0
>  [<c036b9da>] net_rx_action+0x6a/0xf0
>  [<c011dbb1>] __do_softirq+0x41/0x90
>  [<c011dc27>] do_softirq+0x27/0x30
>  [<c01084dd>] do_IRQ+0x10d/0x130
>  [<c0106658>] common_interrupt+0x18/0x20
>
> printk: 1542 messages suppressed.
> bzip2: page allocation failure. order:3, mode:0x20
>  [<c0137a8b>] __alloc_pages+0x2eb/0x300
>  [<c0137ab8>] __get_free_pages+0x18/0x40
>  [<c013b27f>] kmem_getpages+0x1f/0xc0
>  [<c013be7a>] cache_grow+0xba/0x250
>  [<c013c1db>] cache_alloc_refill+0x1cb/0x210
>  [<c0106658>] common_interrupt+0x18/0x20
>  [<c013c741>] __kmalloc+0x71/0x80
>  [<c0366633>] alloc_skb+0x53/0x100
>  [<c02fc495>] e1000_alloc_rx_buffers+0x65/0x100
>  [<c02fc157>] e1000_clean_rx_irq+0x197/0x470
>  [<c02fbd3d>] e1000_clean+0x4d/0xf0
>  [<c036b9da>] net_rx_action+0x6a/0xf0
>  [<c011dbb1>] __do_softirq+0x41/0x90
>  [<c011dc27>] do_softirq+0x27/0x30
>  [<c01084dd>] do_IRQ+0x10d/0x130
>  [<c0106658>] common_interrupt+0x18/0x20
>
> printk: 757 messages suppressed.
> bzip2: page allocation failure. order:3, mode:0x20
>  [<c0137a8b>] __alloc_pages+0x2eb/0x300
>  [<c0137ab8>] __get_free_pages+0x18/0x40
>  [<c013b27f>] kmem_getpages+0x1f/0xc0
>  [<c013be7a>] cache_grow+0xba/0x250
>  [<c013c1db>] cache_alloc_refill+0x1cb/0x210
>  [<c037f140>] ip_rcv_finish+0x0/0x260
>  [<c013c741>] __kmalloc+0x71/0x80
>  [<c0366633>] alloc_skb+0x53/0x100
>  [<c02fc495>] e1000_alloc_rx_buffers+0x65/0x100
>  [<c02fc157>] e1000_clean_rx_irq+0x197/0x470
>  [<c037f02e>] ip_rcv+0x37e/0x490
>  [<c02fbd3d>] e1000_clean+0x4d/0xf0
>  [<c036b9da>] net_rx_action+0x6a/0xf0
>  [<c011dbb1>] __do_softirq+0x41/0x90
>  [<c011dc27>] do_softirq+0x27/0x30
>  [<c01084dd>] do_IRQ+0x10d/0x130
>  [<c0106658>] common_interrupt+0x18/0x20
>
> printk: 584 messages suppressed.
> lftp: page allocation failure. order:3, mode:0x20
>  [<c0137a8b>] __alloc_pages+0x2eb/0x300
>  [<c0137ab8>] __get_free_pages+0x18/0x40
>  [<c013b27f>] kmem_getpages+0x1f/0xc0
>  [<c013be7a>] cache_grow+0xba/0x250
>  [<c013c1db>] cache_alloc_refill+0x1cb/0x210
>  [<c037f140>] ip_rcv_finish+0x0/0x260
>  [<c013c741>] __kmalloc+0x71/0x80
>  [<c0366633>] alloc_skb+0x53/0x100
>  [<c02fc495>] e1000_alloc_rx_buffers+0x65/0x100
>  [<c02fc157>] e1000_clean_rx_irq+0x197/0x470
>  [<c0116a20>] default_wake_function+0x0/0x20
>  [<c02fbd3d>] e1000_clean+0x4d/0xf0
>  [<c036b9da>] net_rx_action+0x6a/0xf0
>  [<c011dbb1>] __do_softirq+0x41/0x90
>  [<c011dc27>] do_softirq+0x27/0x30
>  [<c01084dd>] do_IRQ+0x10d/0x130
>  [<c0106658>] common_interrupt+0x18/0x20
>
>
>
>
> On Fri, 25 Jun 2004, Venkatesan, Ganesh wrote:
>
>> Could you send me details on your machine (processor, motherboard,
>> memory size, etc.)?
>>
>> Thanks,
>> ganesh
>>
>> -------------------------------------------------
>> Ganesh Venkatesan
>> Network/Storage Division, Hillsboro, OR
>>
>> -----Original Message-----
>> From: linux-kernel-owner@vger.kernel.org
>> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Piszcz,
> Justin
>> Michael
>> Sent: Monday, June 14, 2004 5:03 AM
>> To: Justin Piszcz; linux-kernel@vger.kernel.org
>> Subject: RE: 2.6.5 Does Not Handle Jumbo Frames w/Intel GigE NIC -
> Page
>> Allocation Failures
>>
>> Anyone have any suggestions on how to fix this?
>>
>> -----Original Message-----
>> From: linux-kernel-owner@vger.kernel.org
>> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Justin Piszcz
>> Sent: Saturday, June 12, 2004 4:44 AM
>> To: linux-kernel@vger.kernel.org
>> Subject: 2.6.5 Does Not Handle Jumbo Frames w/Intel GigE NIC - Page
>> Allocation Failures
>>
>> When I run: ifconfig eth0 mtu 9000
>>
>> Also, I tried to copy a file from 2.6.5 -> 2.4.26 (over NFS) and it
> did
>> not copy, although I saw my hard disk reading @ 35-40MB/s until it was
>> "ready to copy?" but it never sent any packets over the network.
>>
>> On kernel: 2.4.26 I get no errors.
>> On kernel: 2.6.5 I get a lot of errors, they are:
>>
>> Kernel 2.4.26 Intel Card:
>>
>> 00:0d.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit Ethernet
>> Controller
>>         Subsystem: Intel Corp.: Unknown device 1113
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
>> ParErr- Stepping- SERR+ FastB2B-
>>         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
>>> TAbort-
>> <TAbort- <MAbort- >SERR- <PERR-
>>         Latency: 64 (63750ns min), cache line size 08
>>         Interrupt: pin A routed to IRQ 10
>>         Region 0: Memory at ff040000 (32-bit, non-prefetchable)
>> [size=128K]
>>         Region 1: Memory at ff020000 (32-bit, non-prefetchable)
>> [size=128K]
>>         Region 2: I/O ports at cc80 [size=64]
>>         Expansion ROM at f9000000 [disabled] [size=128K]
>>         Capabilities: [dc] Power Management version 2
>>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
>> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
>>         Capabilities: [e4] PCI-X non-bridge device.
>>                 Command: DPERE- ERO+ RBC=0 OST=0
>>                 Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
>> DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabilities: [f0]
>> Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
>>                 Address: 0000000000000000  Data: 0000
>>
>>  Kernel 2.6.5 Intel Card:
>>
>> 02:01.0 Ethernet controller: Intel Corp. 82547EI Gigabit Ethernet
>> Controller (LOM)
>>         Subsystem: ABIT Computer Corp.: Unknown device 1014
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>> ParErr- Stepping- SERR- FastB2B-
>>         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
>>> TAbort-
>> <TAbort- <MAbort- >SERR- <PERR-
>>         Latency: 0 (63750ns min), cache line size 08
>>         Interrupt: pin A routed to IRQ 18
>>         Region 0: Memory at fc000000 (32-bit, non-prefetchable)
>> [size=128K]
>>         Region 2: I/O ports at a000 [size=32]
>>         Capabilities: [dc] Power Management version 2
>>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
>> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
>>
>> $ dmesg
>> ages+0x1b/0x31
>>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>>  [<c014265b>] __kmalloc+0x6a/0x6c
>>  [<c0303291>] alloc_skb+0x53/0xfc
>>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>>  [<c011a906>] recalc_task_prio+0xdf/0x1c9
>>  [<c030843e>] net_rx_action+0x77/0xf9
>>  [<c0125536>] do_softirq+0x6e/0xcd
>>  [<c0108da1>] do_IRQ+0x19a/0x206
>>  [<c01070b8>] common_interrupt+0x18/0x20
>>  [<c0104581>] default_idle+0x0/0x2c
>>  [<c01045aa>] default_idle+0x29/0x2c
>>  [<c010460e>] cpu_idle+0x2e/0x3c
>>  [<c04726c9>] start_kernel+0x371/0x3fb
>>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>>
>> printk: 53 messages suppressed.
>> swapper: page allocation failure. order:3, mode:0x20
>> Call Trace:
>>  [<c01401b5>] __alloc_pages+0x30d/0x311
>>  [<c01401d4>] __get_free_pages+0x1b/0x31
>>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>>  [<c014265b>] __kmalloc+0x6a/0x6c
>>  [<c0303291>] alloc_skb+0x53/0xfc
>>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>>  [<c030843e>] net_rx_action+0x77/0xf9
>>  [<c0125536>] do_softirq+0x6e/0xcd
>>  [<c0108da1>] do_IRQ+0x19a/0x206
>>  [<c01070b8>] common_interrupt+0x18/0x20
>>  [<c0104581>] default_idle+0x0/0x2c
>>  [<c01045aa>] default_idle+0x29/0x2c
>>  [<c010460e>] cpu_idle+0x2e/0x3c
>>  [<c04726c9>] start_kernel+0x371/0x3fb
>>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>>
>> printk: 165 messages suppressed.
>> swapper: page allocation failure. order:3, mode:0x20
>> Call Trace:
>>  [<c01401b5>] __alloc_pages+0x30d/0x311
>>  [<c01401d4>] __get_free_pages+0x1b/0x31
>>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>>  [<c014265b>] __kmalloc+0x6a/0x6c
>>  [<c0303291>] alloc_skb+0x53/0xfc
>>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>>  [<c011a906>] recalc_task_prio+0xdf/0x1c9
>>  [<c030843e>] net_rx_action+0x77/0xf9
>>  [<c0125536>] do_softirq+0x6e/0xcd
>>  [<c0108da1>] do_IRQ+0x19a/0x206
>>  [<c01070b8>] common_interrupt+0x18/0x20
>>  [<c0104581>] default_idle+0x0/0x2c
>>  [<c01045aa>] default_idle+0x29/0x2c
>>  [<c010460e>] cpu_idle+0x2e/0x3c
>>  [<c04726c9>] start_kernel+0x371/0x3fb
>>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>>
>> printk: 94 messages suppressed.
>> swapper: page allocation failure. order:3, mode:0x20
>> Call Trace:
>>  [<c01401b5>] __alloc_pages+0x30d/0x311
>>  [<c01401d4>] __get_free_pages+0x1b/0x31
>>  [<c011c8c6>] __wake_up_common+0x38/0x57
>>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>>  [<c014265b>] __kmalloc+0x6a/0x6c
>>  [<c0303291>] alloc_skb+0x53/0xfc
>>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>>  [<c02d5ed9>] atkbd_interrupt+0x365/0x569
>>  [<c030843e>] net_rx_action+0x77/0xf9
>>  [<c0125536>] do_softirq+0x6e/0xcd
>>  [<c0108da1>] do_IRQ+0x19a/0x206
>>  [<c01070b8>] common_interrupt+0x18/0x20
>>  [<c0104581>] default_idle+0x0/0x2c
>>  [<c01045aa>] default_idle+0x29/0x2c
>>  [<c010460e>] cpu_idle+0x2e/0x3c
>>  [<c04726c9>] start_kernel+0x371/0x3fb
>>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>>
>> printk: 95 messages suppressed.
>> swapper: page allocation failure. order:3, mode:0x20
>> Call Trace:
>>  [<c01401b5>] __alloc_pages+0x30d/0x311
>>  [<c01401d4>] __get_free_pages+0x1b/0x31
>>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>>  [<c01070b8>] common_interrupt+0x18/0x20
>>  [<c014265b>] __kmalloc+0x6a/0x6c
>>  [<c0303291>] alloc_skb+0x53/0xfc
>>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>>  [<f8e34b00>] nv_unlock_rm+0x45/0x46 [nvidia]
>>  [<c030843e>] net_rx_action+0x77/0xf9
>>  [<c0125536>] do_softirq+0x6e/0xcd
>>  [<c0108da1>] do_IRQ+0x19a/0x206
>>  [<c01070b8>] common_interrupt+0x18/0x20
>>  [<c0104581>] default_idle+0x0/0x2c
>>  [<c01045aa>] default_idle+0x29/0x2c
>>  [<c010460e>] cpu_idle+0x2e/0x3c
>>  [<c04726c9>] start_kernel+0x371/0x3fb
>>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>>
>> printk: 68 messages suppressed.
>> swapper: page allocation failure. order:3, mode:0x20
>> Call Trace:
>>  [<c01401b5>] __alloc_pages+0x30d/0x311
>>  [<c01401d4>] __get_free_pages+0x1b/0x31
>>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>>  [<c014265b>] __kmalloc+0x6a/0x6c
>>  [<c0303291>] alloc_skb+0x53/0xfc
>>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>>  [<c030843e>] net_rx_action+0x77/0xf9
>>  [<c0125536>] do_softirq+0x6e/0xcd
>>  [<c0108da1>] do_IRQ+0x19a/0x206
>>  [<c01070b8>] common_interrupt+0x18/0x20
>>  [<c0104581>] default_idle+0x0/0x2c
>>  [<c01045aa>] default_idle+0x29/0x2c
>>  [<c010460e>] cpu_idle+0x2e/0x3c
>>  [<c04726c9>] start_kernel+0x371/0x3fb
>>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>>
>> printk: 41 messages suppressed.
>> swapper: page allocation failure. order:3, mode:0x20
>> Call Trace:
>>  [<c01401b5>] __alloc_pages+0x30d/0x311
>>  [<c01401d4>] __get_free_pages+0x1b/0x31
>>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>>  [<c014265b>] __kmalloc+0x6a/0x6c
>>  [<c0303291>] alloc_skb+0x53/0xfc
>>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>>  [<c030843e>] net_rx_action+0x77/0xf9
>>  [<c0125536>] do_softirq+0x6e/0xcd
>>  [<c0108da1>] do_IRQ+0x19a/0x206
>>  [<c01070b8>] common_interrupt+0x18/0x20
>>  [<c0104581>] default_idle+0x0/0x2c
>>  [<c01045aa>] default_idle+0x29/0x2c
>>  [<c010460e>] cpu_idle+0x2e/0x3c
>>  [<c04726c9>] start_kernel+0x371/0x3fb
>>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>>
>> printk: 30 messages suppressed.
>> swapper: page allocation failure. order:3, mode:0x20
>> Call Trace:
>>  [<c01401b5>] __alloc_pages+0x30d/0x311
>>  [<c01401d4>] __get_free_pages+0x1b/0x31
>>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>>  [<c014265b>] __kmalloc+0x6a/0x6c
>>  [<c0303291>] alloc_skb+0x53/0xfc
>>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>>  [<c030843e>] net_rx_action+0x77/0xf9
>>  [<c0125536>] do_softirq+0x6e/0xcd
>>  [<c0108da1>] do_IRQ+0x19a/0x206
>>  [<c01070b8>] common_interrupt+0x18/0x20
>>  [<c0104581>] default_idle+0x0/0x2c
>>  [<c01045aa>] default_idle+0x29/0x2c
>>  [<c010460e>] cpu_idle+0x2e/0x3c
>>  [<c04726c9>] start_kernel+0x371/0x3fb
>>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>>
>> printk: 46 messages suppressed.
>> swapper: page allocation failure. order:3, mode:0x20
>> Call Trace:
>>  [<c01401b5>] __alloc_pages+0x30d/0x311
>>  [<c01401d4>] __get_free_pages+0x1b/0x31
>>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>>  [<c014265b>] __kmalloc+0x6a/0x6c
>>  [<c0303291>] alloc_skb+0x53/0xfc
>>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>>  [<c011a906>] recalc_task_prio+0xdf/0x1c9
>>  [<c030843e>] net_rx_action+0x77/0xf9
>>  [<c0125536>] do_softirq+0x6e/0xcd
>>  [<c0108da1>] do_IRQ+0x19a/0x206
>>  [<c01070b8>] common_interrupt+0x18/0x20
>>  [<c0104581>] default_idle+0x0/0x2c
>>  [<c01045aa>] default_idle+0x29/0x2c
>>  [<c010460e>] cpu_idle+0x2e/0x3c
>>  [<c04726c9>] start_kernel+0x371/0x3fb
>>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>>
>> printk: 33 messages suppressed.
>> swapper: page allocation failure. order:3, mode:0x20
>> Call Trace:
>>  [<c01401b5>] __alloc_pages+0x30d/0x311
>>  [<c01401d4>] __get_free_pages+0x1b/0x31
>>  [<c011c8c6>] __wake_up_common+0x38/0x57
>>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>>  [<c014265b>] __kmalloc+0x6a/0x6c
>>  [<c0303291>] alloc_skb+0x53/0xfc
>>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>>  [<c02d5ed9>] atkbd_interrupt+0x365/0x569
>>  [<c030843e>] net_rx_action+0x77/0xf9
>>  [<c0125536>] do_softirq+0x6e/0xcd
>>  [<c0108da1>] do_IRQ+0x19a/0x206
>>  [<c01070b8>] common_interrupt+0x18/0x20
>>  [<c0104581>] default_idle+0x0/0x2c
>>  [<c01045aa>] default_idle+0x29/0x2c
>>  [<c010460e>] cpu_idle+0x2e/0x3c
>>  [<c04726c9>] start_kernel+0x371/0x3fb
>>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>>
>> printk: 136 messages suppressed.
>> swapper: page allocation failure. order:3, mode:0x20
>> Call Trace:
>>  [<c01401b5>] __alloc_pages+0x30d/0x311
>>  [<c01401d4>] __get_free_pages+0x1b/0x31
>>  [<c011c8c6>] __wake_up_common+0x38/0x57
>>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>>  [<c014265b>] __kmalloc+0x6a/0x6c
>>  [<c0303291>] alloc_skb+0x53/0xfc
>>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>>  [<c02d5ed9>] atkbd_interrupt+0x365/0x569
>>  [<c02d9cb1>] serio_interrupt+0x7c/0xaf
>>  [<c030843e>] net_rx_action+0x77/0xf9
>>  [<c0125536>] do_softirq+0x6e/0xcd
>>  [<c0108da1>] do_IRQ+0x19a/0x206
>>  [<c01070b8>] common_interrupt+0x18/0x20
>>  [<c0104581>] default_idle+0x0/0x2c
>>  [<c01045aa>] default_idle+0x29/0x2c
>>  [<c010460e>] cpu_idle+0x2e/0x3c
>>  [<c04726c9>] start_kernel+0x371/0x3fb
>>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>>
>
>
---1463747160-1520231160-1088616719=:21480
Content-Type: APPLICATION/octet-stream; name="config-2.6.7.bz2"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.60.0406301331590.21480@p500>
Content-Description: 
Content-Disposition: attachment; filename="config-2.6.7.bz2"

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
X172J405OntXLMgCL/xdyRThQkBvm/5k

---1463747160-1520231160-1088616719=:21480--
