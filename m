Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266764AbUF3Rjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266764AbUF3Rjb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 13:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266779AbUF3Rja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 13:39:30 -0400
Received: from lucidpixels.com ([66.45.37.187]:11911 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S266764AbUF3Rdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 13:33:55 -0400
Date: Wed, 30 Jun 2004 13:33:48 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: "Venkatesan, Ganesh" <ganesh.venkatesan@intel.com>
cc: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>,
       linux-kernel@vger.kernel.org
Subject: RE: 2.6.5 Does Not Handle Jumbo Frames w/Intel GigE NIC - Page
 Allocation Failures
In-Reply-To: <468F3FDA28AA87429AD807992E22D07E019ADF87@orsmsx408>
Message-ID: <Pine.LNX.4.60.0406301332450.21480@p500>
References: <468F3FDA28AA87429AD807992E22D07E019ADF87@orsmsx408>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463747160-473203558-1088616828=:21480"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463747160-473203558-1088616828=:21480
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

The previous one was from the box that I believe works now (P4 box), the 
one that is having issues now is my Pentium 3 500MHZ box, config for that 
attached (also 2.6.7).


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
---1463747160-473203558-1088616828=:21480
Content-Type: APPLICATION/octet-stream; name="config-2.6.7.bz2"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.60.0406301333480.21480@p500>
Content-Description: 
Content-Disposition: attachment; filename="config-2.6.7.bz2"

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
3JFOFCQQSBsKAA==

---1463747160-473203558-1088616828=:21480--
