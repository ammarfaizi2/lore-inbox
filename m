Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262744AbTCJHpQ>; Mon, 10 Mar 2003 02:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262745AbTCJHpQ>; Mon, 10 Mar 2003 02:45:16 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:25617 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S262744AbTCJHpM>; Mon, 10 Mar 2003 02:45:12 -0500
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EISA aic7770 broken
References: <wrp65qscwxx.fsf@hina.wild-wind.fr.eu.org>
	<229560000.1047229710@aslan.scsiguy.com>
	<wrp1y1gcv96.fsf@hina.wild-wind.fr.eu.org>
	<301080000.1047244547@aslan.scsiguy.com>
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 10 Mar 2003 08:53:56 +0100
Message-ID: <wrpptozbqsr.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <301080000.1047244547@aslan.scsiguy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Justin" == Justin T Gibbs <gibbs@scsiguy.com> writes:

Justin> Define crashes badly.  Driver messages or kernel panic strings
Justin> typically help.

Here it is :

<quote>
[...]
PCI: PCI BIOS revision 2.10 entry at 0xf80cd, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Linux Plug and Play Support v0.95 (c) Adam Belay
pnp: Enabling Plug and Play Card Services.
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Starting balanced_irq
Enabling SEP on CPU 1
Enabling SEP on CPU 0
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.11
scsi HBA driver Adaptec 174x (EISA) didn't set a release method, please fix the template
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.28
        <Adaptec aic7880 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
  Vendor: WDIGTL    Model: WDE4360-1808A3    Rev: 1.80
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
  Vendor: DELL      Model: 6UW BACKPLANE     Rev: 9   
  Type:   Processor                          ANSI SCSI revision: 02
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.28
        <Adaptec aic7860 Ultra SCSI adapter>
        aic7860: Ultra Single Channel A, SCSI Id=7, 3/253 SCBs

(scsi1:A:5): 10.000MB/s transfers (10.000MHz, offset 15)
  Vendor: NEC       Model: CD-ROM DRIVE:464  Rev: 1.05
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi2 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.28
        <Adaptec 274X SCSI adapter>
        aic7770: Twin Channel, A SCSI Id=7, B SCSI Id=7, primary A, 4/253 SCBs

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c01f8cec
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c01f8cec>]    Not tainted
EFLAGS: 00010046
EIP is at ahc_runq_tasklet+0x54/0x140
eax: 00000000   ebx: dfe00400   ecx: c1535600   edx: 00000000
esi: dfe00600   edi: c02fdf48   ebp: 00000001   esp: c02fdf3c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c02fc000 task=c02bdce0)
Stack: dfe00454 00000000 c02fc000 00000286 c011f722 dfe00600 00000001 c02faf08 
       ffffffdd 00000000 c0352438 c0352438 c011f50a c02faf08 00000000 00000000 
       c02fdf9c 0008e000 00000046 c0113a83 c02fc000 c0106d90 c0105000 c010974a 
Call Trace:
 [<c011f722>] tasklet_action+0x86/0xe4
 [<c011f50a>] do_softirq+0x5a/0xac
 [<c0113a83>] smp_apic_timer_interrupt+0x13f/0x150
 [<c0106d90>] default_idle+0x0/0x34
 [<c0105000>] _stext+0x0/0x58
 [<c010974a>] apic_timer_interrupt+0x1a/0x20
 [<c0106d90>] default_idle+0x0/0x34
 [<c0105000>] _stext+0x0/0x58
 [<c0106db9>] default_idle+0x29/0x34
 [<c0106e43>] cpu_idle+0x37/0x48
 [<c0105055>] _stext+0x55/0x58

Code: 89 02 8b 41 24 89 c2 83 e2 f7 89 51 24 a8 02 74 0e 83 79 10 
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
</quote>

Running the dump through ksymoops :

<quote>
>>EIP; c01f8cec <ahc_runq_tasklet+54/140>   <=====

>>edi; c02fdf48 <init_thread_union+1f48/2000>
>>esp; c02fdf3c <init_thread_union+1f3c/2000>

Trace; c011f722 <tasklet_action+86/e4>
Trace; c011f50a <do_softirq+5a/ac>
Trace; c0113a83 <smp_apic_timer_interrupt+13f/150>
Trace; c0106d90 <default_idle+0/34>
Trace; c0105000 <_stext+0/0>
Trace; c010974a <apic_timer_interrupt+1a/20>
Trace; c0106d90 <default_idle+0/34>
Trace; c0105000 <_stext+0/0>
Trace; c0106db9 <default_idle+29/34>
Trace; c0106e43 <cpu_idle+37/48>
Trace; c0105055 <rest_init+55/58>

Code;  c01f8cec <ahc_runq_tasklet+54/140>
00000000 <_EIP>:
Code;  c01f8cec <ahc_runq_tasklet+54/140>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c01f8cee <ahc_runq_tasklet+56/140>
   2:   8b 41 24                  mov    0x24(%ecx),%eax
Code;  c01f8cf1 <ahc_runq_tasklet+59/140>
   5:   89 c2                     mov    %eax,%edx
Code;  c01f8cf3 <ahc_runq_tasklet+5b/140>
   7:   83 e2 f7                  and    $0xfffffff7,%edx
Code;  c01f8cf6 <ahc_runq_tasklet+5e/140>
   a:   89 51 24                  mov    %edx,0x24(%ecx)
Code;  c01f8cf9 <ahc_runq_tasklet+61/140>
   d:   a8 02                     test   $0x2,%al
Code;  c01f8cfb <ahc_runq_tasklet+63/140>
   f:   74 0e                     je     1f <_EIP+0x1f> c01f8d0b <ahc_runq_tasklet+73/140>
Code;  c01f8cfd <ahc_runq_tasklet+65/140>
  11:   83 79 10 00               cmpl   $0x0,0x10(%ecx)
</quote>

There is a single disk connected to the EISA card (channel A).

Does it help ?

Thanks,

        M.
-- 
Places change, faces change. Life is so very strange.
