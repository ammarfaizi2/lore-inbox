Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264277AbTFDXBq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 19:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264279AbTFDXBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 19:01:46 -0400
Received: from air-2.osdl.org ([65.172.181.6]:53214 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264277AbTFDXBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 19:01:23 -0400
Date: Wed, 4 Jun 2003 16:14:37 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@redhat.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: 2.5.70-bk+ broken networking
Message-Id: <20030604161437.2b4d3a79.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Test machine running 2.5.70-bk latest can't boot because eth2 won't
come up.  The same machine and configuration successfully brings up
all the devices and runs on 2.5.70.

Starting ip6tables:  [  OK  ]
Starting iptables:  [  OK  ]
Setting network parameters:  [  OK  ]
Bringing up loopback interface:  [  OK  ]
Bringing up interface eth0:  [  OK  ]
Bringing up interface eth1:  [  OK  ]
Bringing up interface eth2:  sender address length == 0
e1000 device does not seem to be present, delaying eth2 initialization.
[FAILED]
Starting system logger: [  OK  ]
Starting kernel logger: [  OK  ]
Starting portmapper: [  OK  ]
Starting NFS statd: [  OK  ]
Starting keytable:  [  OK  ]
Initializing random number generator:  [  OK  ]
Starting pcmcia:  [  OK  ]
Mounting other filesystems:  [  OK  ]
Setting NIS domain name osdl:  [  OK  ]
Binding to the NIS domain: [  OK  ]
Listening for an NIS domain server.

(hung)

SysRq : Show State

                         free                        sibling
  task             PC    stack   pid father child younger older
init          S 00000001 3414430476     1      0     2               (NOTLB)
Call Trace:
 [<c012c068>] schedule_timeout+0x6a/0xbc
 [<c012bff2>] process_timeout+0x0/0xc
 [<c0173e47>] do_select+0x193/0x2ee
 [<c0173b28>] __pollwait+0x0/0xaa
 [<c0174274>] sys_select+0x2a6/0x4a8
 [<c0169e0f>] sys_stat64+0x35/0x38
 [<c010b41f>] syscall_call+0x7/0xb

migration/0   S 00000001 4294947312     2      1             3       (L-TLB)
Call Trace:
 [<c011fc85>] migration_thread+0x4f3/0x534
 [<c011f792>] migration_thread+0x0/0x534
 [<c0108f41>] kernel_thread_helper+0x5/0xc

ksoftirqd/0   S 00000000 4294940388     3      1             4     2 (L-TLB)
Call Trace:
 [<c0127b51>] ksoftirqd+0x95/0xe6
 [<c0127abc>] ksoftirqd+0x0/0xe6
 [<c0108f41>] kernel_thread_helper+0x5/0xc

migration/1   S 00000001  7996     4      1             5     3 (L-TLB)
Call Trace:
 [<c011f717>] set_cpus_allowed+0x155/0x1d0
 [<c011fc85>] migration_thread+0x4f3/0x534
 [<c010b2f6>] ret_from_fork+0x6/0x14
 [<c011f792>] migration_thread+0x0/0x534
 [<c011f792>] migration_thread+0x0/0x534
 [<c0108f41>] kernel_thread_helper+0x5/0xc

ksoftirqd/1   S 00000000 4294960540     5      1             6     4 (L-TLB)
Call Trace:
 [<c0127b51>] ksoftirqd+0x95/0xe6
 [<c0127abc>] ksoftirqd+0x0/0xe6
 [<c0108f41>] kernel_thread_helper+0x5/0xc

migration/2   S 00000001 4294953884     6      1             7     5 (L-TLB)
Call Trace:
 [<c011f717>] set_cpus_allowed+0x155/0x1d0
 [<c011fc85>] migration_thread+0x4f3/0x534
 [<c010b2f6>] ret_from_fork+0x6/0x14
 [<c011f792>] migration_thread+0x0/0x534
 [<c011f792>] migration_thread+0x0/0x534
 [<c0108f41>] kernel_thread_helper+0x5/0xc

ksoftirqd/2   S 00000000 4294947324     7      1             8     6 (L-TLB)
Call Trace:
 [<c0127b51>] ksoftirqd+0x95/0xe6
 [<c0127abc>] ksoftirqd+0x0/0xe6
 [<c0108f41>] kernel_thread_helper+0x5/0xc

migration/3   S 00000001 4294940668     8      1             9     7 (L-TLB)
Call Trace:
 [<c011f717>] set_cpus_allowed+0x155/0x1d0
 [<c011fc85>] migration_thread+0x4f3/0x534
 [<c010b2f6>] ret_from_fork+0x6/0x14
 [<c011f792>] migration_thread+0x0/0x534
 [<c011f792>] migration_thread+0x0/0x534
 [<c0108f41>] kernel_thread_helper+0x5/0xc

ksoftirqd/3   S 00000001  8044     9      1            10     8 (L-TLB)
Call Trace:
 [<c011f717>] set_cpus_allowed+0x155/0x1d0
 [<c0127b51>] ksoftirqd+0x95/0xe6
 [<c0127abc>] ksoftirqd+0x0/0xe6
 [<c0108f41>] kernel_thread_helper+0x5/0xc

migration/4   S 00000001 4294960492    10      1            11     9 (L-TLB)
Call Trace:
 [<c011f717>] set_cpus_allowed+0x155/0x1d0
 [<c011fc85>] migration_thread+0x4f3/0x534
 [<c010b2f6>] ret_from_fork+0x6/0x14
 [<c011f792>] migration_thread+0x0/0x534
 [<c011f792>] migration_thread+0x0/0x534
 [<c0108f41>] kernel_thread_helper+0x5/0xc

ksoftirqd/4   S 00000001 4294953932    11      1            12    10 (L-TLB)
Call Trace:
 [<c011f717>] set_cpus_allowed+0x155/0x1d0
 [<c0127b51>] ksoftirqd+0x95/0xe6
 [<c0127abc>] ksoftirqd+0x0/0xe6
 [<c0108f41>] kernel_thread_helper+0x5/0xc

migration/5   S 00000001 4294947276    12      1            13    11 (L-TLB)
Call Trace:
 [<c011f717>] set_cpus_allowed+0x155/0x1d0
 [<c011fc85>] migration_thread+0x4f3/0x534
 [<c010b2f6>] ret_from_fork+0x6/0x14
 [<c011f792>] migration_thread+0x0/0x534
 [<c011f792>] migration_thread+0x0/0x534
 [<c0108f41>] kernel_thread_helper+0x5/0xc

ksoftirqd/5   S 00000001 4294940716    13      1            14    12 (L-TLB)
Call Trace:
 [<c011f717>] set_cpus_allowed+0x155/0x1d0
 [<c0127b51>] ksoftirqd+0x95/0xe6
 [<c0127abc>] ksoftirqd+0x0/0xe6
 [<c0108f41>] kernel_thread_helper+0x5/0xc

migration/6   S 00000001  7996    14      1            15    13 (L-TLB)
Call Trace:
 [<c011f717>] set_cpus_allowed+0x155/0x1d0
 [<c011fc85>] migration_thread+0x4f3/0x534
 [<c010b2f6>] ret_from_fork+0x6/0x14
 [<c011f792>] migration_thread+0x0/0x534
 [<c011f792>] migration_thread+0x0/0x534
 [<c0108f41>] kernel_thread_helper+0x5/0xc

ksoftirqd/6   S 00000001 4294960540    15      1            16    14 (L-TLB)
Call Trace:
 [<c011f717>] set_cpus_allowed+0x155/0x1d0
 [<c0127b51>] ksoftirqd+0x95/0xe6
 [<c0127abc>] ksoftirqd+0x0/0xe6
 [<c0108f41>] kernel_thread_helper+0x5/0xc

migration/7   S 00000001 4294953884    16      1            17    15 (L-TLB)
Call Trace:
 [<c011f717>] set_cpus_allowed+0x155/0x1d0
 [<c011fc85>] migration_thread+0x4f3/0x534
 [<c010b2f6>] ret_from_fork+0x6/0x14
 [<c011f792>] migration_thread+0x0/0x534
 [<c011f792>] migration_thread+0x0/0x534
 [<c0108f41>] kernel_thread_helper+0x5/0xc

ksoftirqd/7   S 00000001 4294947324    17      1            18    16 (L-TLB)
Call Trace:
 [<c011f717>] set_cpus_allowed+0x155/0x1d0
 [<c0127b51>] ksoftirqd+0x95/0xe6
 [<c0127abc>] ksoftirqd+0x0/0xe6
 [<c0108f41>] kernel_thread_helper+0x5/0xc

events/0      S 00000001 3415176940    18      1            19    17 (L-TLB)
Call Trace:
 [<c0134715>] worker_thread+0x3a9/0x3ce
 [<c0222c1e>] flush_to_ldisc+0x0/0x176
 [<c011da12>] preempt_schedule+0x36/0x50
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c010b2f6>] ret_from_fork+0x6/0x14
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c013436c>] worker_thread+0x0/0x3ce
 [<c0108f41>] kernel_thread_helper+0x5/0xc

events/1      S 00000001  7620    19      1            20    18 (L-TLB)
Call Trace:
 [<c0134715>] worker_thread+0x3a9/0x3ce
 [<c0248024>] blk_unplug_work+0x0/0x16
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c010b2f6>] ret_from_fork+0x6/0x14
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c013436c>] worker_thread+0x0/0x3ce
 [<c0108f41>] kernel_thread_helper+0x5/0xc

events/2      S 00000001 4294960436    20      1            21    19 (L-TLB)
Call Trace:
 [<c0130e13>] do_sigaction+0x28d/0x43a
 [<c0134715>] worker_thread+0x3a9/0x3ce
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c010b2f6>] ret_from_fork+0x6/0x14
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c013436c>] worker_thread+0x0/0x3ce
 [<c0108f41>] kernel_thread_helper+0x5/0xc

events/3      S 00000001 4294953652    21      1            22    20 (L-TLB)
Call Trace:
 [<c0134715>] worker_thread+0x3a9/0x3ce
 [<c0248024>] blk_unplug_work+0x0/0x16
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c010b2f6>] ret_from_fork+0x6/0x14
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c013436c>] worker_thread+0x0/0x3ce
 [<c0108f41>] kernel_thread_helper+0x5/0xc

events/4      S 00000001 4294947220    22      1            23    21 (L-TLB)
Call Trace:
 [<c0130e13>] do_sigaction+0x28d/0x43a
 [<c0134715>] worker_thread+0x3a9/0x3ce
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c010b2f6>] ret_from_fork+0x6/0x14
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c013436c>] worker_thread+0x0/0x3ce
 [<c0108f41>] kernel_thread_helper+0x5/0xc

events/5      S 00000001 4294940612    23      1            24    22 (L-TLB)
Call Trace:
 [<c0130e13>] do_sigaction+0x28d/0x43a
 [<c0134715>] worker_thread+0x3a9/0x3ce
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c010b2f6>] ret_from_fork+0x6/0x14
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c013436c>] worker_thread+0x0/0x3ce
 [<c0108f41>] kernel_thread_helper+0x5/0xc

events/6      S 00000001  7940    24      1            25    23 (L-TLB)
Call Trace:
 [<c0130e13>] do_sigaction+0x28d/0x43a
 [<c0134715>] worker_thread+0x3a9/0x3ce
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c010b2f6>] ret_from_fork+0x6/0x14
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c013436c>] worker_thread+0x0/0x3ce
 [<c0108f41>] kernel_thread_helper+0x5/0xc

events/7      S 00000001 4294960436    25      1            26    24 (L-TLB)
Call Trace:
 [<c0130e13>] do_sigaction+0x28d/0x43a
 [<c0134715>] worker_thread+0x3a9/0x3ce
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c010b2f6>] ret_from_fork+0x6/0x14
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c013436c>] worker_thread+0x0/0x3ce
 [<c0108f41>] kernel_thread_helper+0x5/0xc

kirqd         S 00000001 874843020    26      1            27    25 (L-TLB)
Call Trace:
 [<c012c068>] schedule_timeout+0x6a/0xbc
 [<c012bff2>] process_timeout+0x0/0xc
 [<c0119b97>] balanced_irq+0x4f/0x76
 [<c0119b48>] balanced_irq+0x0/0x76
 [<c0108f41>] kernel_thread_helper+0x5/0xc

pdflush       S 00000001 874836508    27      1            29    26 (L-TLB)
Call Trace:
 [<c012489b>] daemonize+0xd1/0xd8
 [<c01434a0>] __pdflush+0xdc/0x378
 [<c011da12>] preempt_schedule+0x36/0x50
 [<c011c8ae>] schedule_tail+0xc0/0xdc
 [<c014373c>] pdflush+0x0/0x16
 [<c014374d>] pdflush+0x11/0x16
 [<c0108f41>] kernel_thread_helper+0x5/0xc

kswapd0       S F7A37EE4  7884    29      1            28    27 (L-TLB)
Call Trace:
 [<c0124544>] reparent_to_init+0x10a/0x1b0
 [<c012489b>] daemonize+0xd1/0xd8
 [<c014b2b8>] kswapd+0xe0/0x10c
 [<c011da12>] preempt_schedule+0x36/0x50
 [<c01205d6>] autoremove_wake_function+0x0/0x4c
 [<c010b2f6>] ret_from_fork+0x6/0x14
 [<c01205d6>] autoremove_wake_function+0x0/0x4c
 [<c014b1d8>] kswapd+0x0/0x10c
 [<c0108f41>] kernel_thread_helper+0x5/0xc

pdflush       S 00000001 874828660    28      1            30    29 (L-TLB)
Call Trace:
 [<c01434a0>] __pdflush+0xdc/0x378
 [<c011da12>] preempt_schedule+0x36/0x50
 [<c011c8ae>] schedule_tail+0xc0/0xdc
 [<c014373c>] pdflush+0x0/0x16
 [<c014374d>] pdflush+0x11/0x16
 [<c0108f41>] kernel_thread_helper+0x5/0xc

aio/0         S F7A0DBF8 4294624600    30      1            31    28 (L-TLB)
Call Trace:
 [<c0130e13>] do_sigaction+0x28d/0x43a
 [<c0134715>] worker_thread+0x3a9/0x3ce
 [<c011da12>] preempt_schedule+0x36/0x50
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c010b2f6>] ret_from_fork+0x6/0x14
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c013436c>] worker_thread+0x0/0x3ce
 [<c0108f41>] kernel_thread_helper+0x5/0xc

aio/1         S 00000001 4294617956    31      1            32    30 (L-TLB)
Call Trace:
 [<c0130e13>] do_sigaction+0x28d/0x43a
 [<c0134715>] worker_thread+0x3a9/0x3ce
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c010b2f6>] ret_from_fork+0x6/0x14
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c013436c>] worker_thread+0x0/0x3ce
 [<c0108f41>] kernel_thread_helper+0x5/0xc

aio/2         S 00000001 4294611348    32      1            33    31 (L-TLB)
Call Trace:
 [<c0130e13>] do_sigaction+0x28d/0x43a
 [<c0134715>] worker_thread+0x3a9/0x3ce
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c010b2f6>] ret_from_fork+0x6/0x14
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c013436c>] worker_thread+0x0/0x3ce
 [<c0108f41>] kernel_thread_helper+0x5/0xc

aio/3         S 00000001 4294604740    33      1            34    32 (L-TLB)
Call Trace:
 [<c0130e13>] do_sigaction+0x28d/0x43a
 [<c0134715>] worker_thread+0x3a9/0x3ce
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c010b2f6>] ret_from_fork+0x6/0x14
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c013436c>] worker_thread+0x0/0x3ce
 [<c0108f41>] kernel_thread_helper+0x5/0xc

aio/4         S 00000001  7940    34      1            35    33 (L-TLB)
Call Trace:
 [<c0130e13>] do_sigaction+0x28d/0x43a
 [<c0134715>] worker_thread+0x3a9/0x3ce
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c010b2f6>] ret_from_fork+0x6/0x14
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c013436c>] worker_thread+0x0/0x3ce
 [<c0108f41>] kernel_thread_helper+0x5/0xc

aio/5         S 00000001 4294960436    35      1            36    34 (L-TLB)
Call Trace:
 [<c0130e13>] do_sigaction+0x28d/0x43a
 [<c0134715>] worker_thread+0x3a9/0x3ce
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c010b2f6>] ret_from_fork+0x6/0x14
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c013436c>] worker_thread+0x0/0x3ce
 [<c0108f41>] kernel_thread_helper+0x5/0xc

aio/6         S 00000001 4294953828    36      1            37    35 (L-TLB)
Call Trace:
 [<c0130e13>] do_sigaction+0x28d/0x43a
 [<c0134715>] worker_thread+0x3a9/0x3ce
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c010b2f6>] ret_from_fork+0x6/0x14
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c013436c>] worker_thread+0x0/0x3ce
 [<c0108f41>] kernel_thread_helper+0x5/0xc

aio/7         S 00000001 4294947220    37      1            38    36 (L-TLB)
Call Trace:
 [<c0130e13>] do_sigaction+0x28d/0x43a
 [<c0134715>] worker_thread+0x3a9/0x3ce
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c010b2f6>] ret_from_fork+0x6/0x14
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c013436c>] worker_thread+0x0/0x3ce
 [<c0108f41>] kernel_thread_helper+0x5/0xc

kseriod       S 00000001 4294383536    38      1            43    37 (L-TLB)
Call Trace:
 [<c012474c>] allow_signal+0x5a/0xd8
 [<c027e72a>] serio_thread+0xbe/0x190
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c027e66c>] serio_thread+0x0/0x190
 [<c0108f41>] kernel_thread_helper+0x5/0xc

scsi_eh_0     S 00000000  8052    43      1            44    38 (L-TLB)
Call Trace:
 [<c0109f00>] __down_interruptible+0xe2/0x1fc
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c010a0fe>] __down_failed_interruptible+0xa/0x10
 [<f888cc30>] .text.lock.scsi_error+0xad/0xb5 [scsi_mod]
 [<f88943bb>] +0x20fb/0x2d40 [scsi_mod]
 [<f888c75c>] scsi_error_handler+0x0/0x23a [scsi_mod]
 [<c0108f41>] kernel_thread_helper+0x5/0xc

ahc_dv_0      S F70F6000 4294960340    44      1            45    43 (L-TLB)
Call Trace:
 [<c0109f00>] __down_interruptible+0xe2/0x1fc
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<f8902671>] ahc_linux_release_simq+0xdb/0x15a [aic7xxx]
 [<c010a0fe>] __down_failed_interruptible+0xa/0x10
 [<f89034eb>] .text.lock.aic7xxx_osm+0x8e/0x1fb [aic7xxx]
 [<f8907a9d>] +0x215d/0x2600 [aic7xxx]
 [<f88fccc6>] ahc_linux_dv_thread+0x0/0x632 [aic7xxx]
 [<c0108f41>] kernel_thread_helper+0x5/0xc

scsi_eh_1     S 00000000 4294359084    45      1            46    44 (L-TLB)
Call Trace:
 [<c0109f00>] __down_interruptible+0xe2/0x1fc
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c010a0fe>] __down_failed_interruptible+0xa/0x10
 [<f888cc30>] .text.lock.scsi_error+0xad/0xb5 [scsi_mod]
 [<f88943bb>] +0x20fb/0x2d40 [scsi_mod]
 [<f888c75c>] scsi_error_handler+0x0/0x23a [scsi_mod]
 [<c0108f41>] kernel_thread_helper+0x5/0xc

ahc_dv_1      S F70D4000 4294349080    46      1            47    45 (L-TLB)
Call Trace:
 [<c0109f00>] __down_interruptible+0xe2/0x1fc
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<f8902671>] ahc_linux_release_simq+0xdb/0x15a [aic7xxx]
 [<c010a0fe>] __down_failed_interruptible+0xa/0x10
 [<f89034eb>] .text.lock.aic7xxx_osm+0x8e/0x1fb [aic7xxx]
 [<f8907a9d>] +0x215d/0x2600 [aic7xxx]
 [<f88fccc6>] ahc_linux_dv_thread+0x0/0x632 [aic7xxx]
 [<c0108f41>] kernel_thread_helper+0x5/0xc

kjournald     S 00000001 4294213892    47      1           148    46 (L-TLB)
Call Trace:
 [<c011e05f>] interruptible_sleep_on+0x8f/0x158
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c01b3ea1>] kjournald+0x14f/0x25a
 [<c01b3d40>] commit_timeout+0x0/0xc
 [<c01b3d52>] kjournald+0x0/0x25a
 [<c0108f41>] kernel_thread_helper+0x5/0xc

kjournald     S 00000001 16131824   148      1           149    47 (L-TLB)
Call Trace:
 [<c011da56>] default_wake_function+0x2a/0x2e
 [<c011e05f>] interruptible_sleep_on+0x8f/0x158
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c01b3ea1>] kjournald+0x14f/0x25a
 [<c01b3d40>] commit_timeout+0x0/0xc
 [<c01b3d52>] kjournald+0x0/0x25a
 [<c0108f41>] kernel_thread_helper+0x5/0xc

kjournald     S 00000001   192   149      1           150   148 (L-TLB)
Call Trace:
 [<c011da56>] default_wake_function+0x2a/0x2e
 [<c011e05f>] interruptible_sleep_on+0x8f/0x158
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c01b3ea1>] kjournald+0x14f/0x25a
 [<c01b3d40>] commit_timeout+0x0/0xc
 [<c01b3d52>] kjournald+0x0/0x25a
 [<c0108f41>] kernel_thread_helper+0x5/0xc

kjournald     S 00000000 4287980920   150      1           151   149 (L-TLB)
Call Trace:
 [<c011da56>] default_wake_function+0x2a/0x2e
 [<c011e05f>] interruptible_sleep_on+0x8f/0x158
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c01b3ea1>] kjournald+0x14f/0x25a
 [<c01b3d40>] commit_timeout+0x0/0xc
 [<c01b3d52>] kjournald+0x0/0x25a
 [<c0108f41>] kernel_thread_helper+0x5/0xc

kjournald     D 00000001 4287973144   151      1           152   150 (L-TLB)
Call Trace:
 [<c0248387>] blk_run_queues+0xcd/0x1ae
 [<c011f15e>] io_schedule+0x26/0x30
 [<c01600c3>] __wait_on_buffer+0xcf/0xd2
 [<c01205d6>] autoremove_wake_function+0x0/0x4c
 [<c01205d6>] autoremove_wake_function+0x0/0x4c
 [<c01b0a25>] journal_commit_transaction+0x49b/0x1632
 [<c0118600>] smp_apic_timer_interrupt+0xd8/0x140
 [<c011d5ec>] schedule+0x218/0x608
 [<c011da56>] default_wake_function+0x2a/0x2e
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c01b3eb5>] kjournald+0x163/0x25a
 [<c01b3d40>] commit_timeout+0x0/0xc
 [<c01b3d52>] kjournald+0x0/0x25a
 [<c0108f41>] kernel_thread_helper+0x5/0xc

kjournald     S 00000001 4287966564   152      1           242   151 (L-TLB)
Call Trace:
 [<c011da56>] default_wake_function+0x2a/0x2e
 [<c011e05f>] interruptible_sleep_on+0x8f/0x158
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c01b3ea1>] kjournald+0x14f/0x25a
 [<c01b3d40>] commit_timeout+0x0/0xc
 [<c01b3d52>] kjournald+0x0/0x25a
 [<c0108f41>] kernel_thread_helper+0x5/0xc

rc            S 00000001 4294206928   242      1   670     434   152 (NOTLB)
Call Trace:
 [<c01264e8>] sys_wait4+0x1e6/0x29a
 [<c01313bf>] sys_rt_sigaction+0xd1/0xf4
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c0130076>] sys_rt_sigprocmask+0xce/0x1b0
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c010b41f>] syscall_call+0x7/0xb

dhclient      S 00000001 4291868976   434      1           557   242 (NOTLB)
Call Trace:
 [<c010bd8c>] common_interrupt+0x18/0x20
 [<c012c068>] schedule_timeout+0x6a/0xbc
 [<c0173b60>] __pollwait+0x38/0xaa
 [<c012bff2>] process_timeout+0x0/0xc
 [<c0282026>] sock_poll+0x26/0x2a
 [<c0173e47>] do_select+0x193/0x2ee
 [<c0173b28>] __pollwait+0x0/0xaa
 [<c0174274>] sys_select+0x2a6/0x4a8
 [<c010b41f>] syscall_call+0x7/0xb

syslogd       D 00000001 4290889300   557      1           561   434 (NOTLB)
Call Trace:
 [<c011da56>] default_wake_function+0x2a/0x2e
 [<c011e31b>] sleep_on+0x8f/0x158
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c01b4454>] log_wait_commit+0x70/0x120
 [<c01b43ba>] log_start_commit+0xea/0x114
 [<c01af53b>] journal_stop+0x193/0x20e
 [<c01af687>] journal_force_commit+0xd1/0xea
 [<c01a9bcd>] ext3_force_commit+0x69/0xe6
 [<c01604c1>] sys_fsync+0xa3/0xce
 [<c010b41f>] syscall_call+0x7/0xb

klogd         S 00000001 4289963772   561      1           572   557 (NOTLB)
Call Trace:
 [<c0144245>] fprob+0x2b/0x34
 [<c012c0b7>] schedule_timeout+0xb9/0xbc
 [<c0146494>] kmalloc+0x188/0x1d6
 [<c02fd26e>] unix_wait_for_peer+0xde/0xea
 [<c01205d6>] autoremove_wake_function+0x0/0x4c
 [<c02872ec>] memcpy_fromiovec+0x88/0x8e
 [<c01205d6>] autoremove_wake_function+0x0/0x4c
 [<c0284dac>] sock_alloc_send_skb+0x2e/0x32
 [<c02fdee0>] unix_dgram_sendmsg+0x2be/0x68c
 [<c013eecb>] filemap_nopage+0x1e5/0x2ce
 [<c01544cc>] pte_chain_alloc+0x94/0x9c
 [<c0281a00>] sock_aio_write+0xbc/0xd8
 [<c015ea62>] do_sync_write+0x8a/0xb6
 [<c014f63f>] handle_mm_fault+0x103/0x1fc
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c012bd6a>] run_timer_softirq+0x196/0x25c
 [<c015eb77>] vfs_write+0xe9/0x11a
 [<c015ec45>] sys_write+0x3f/0x5e
 [<c010b41f>] syscall_call+0x7/0xb

portmap       S 00000001 4292398496   572      1                 561 (NOTLB)
Call Trace:
 [<c012c0b7>] schedule_timeout+0xb9/0xbc
 [<c0282026>] sock_poll+0x26/0x2a
 [<c01744cd>] do_pollfd+0x57/0x98
 [<c01745b3>] do_poll+0xa5/0xc4
 [<c0174732>] sys_poll+0x160/0x23a
 [<c0173b28>] __pollwait+0x0/0xaa
 [<c010b41f>] syscall_call+0x7/0xb

S27ypbind     S 00000001 276376   670    242   687               (NOTLB)
Call Trace:
 [<c01264e8>] sys_wait4+0x1e6/0x29a
 [<c01313bf>] sys_rt_sigaction+0xd1/0xf4
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c0130076>] sys_rt_sigprocmask+0xce/0x1b0
 [<c011da2c>] default_wake_function+0x0/0x2e
 [<c010b41f>] syscall_call+0x7/0xb

rpcinfo       S 00000001 4287705648   687    670           688       (NOTLB)
Call Trace:
 [<c02baa81>] tcp_v4_connect+0x42f/0x68c
 [<c012c0b7>] schedule_timeout+0xb9/0xbc
 [<c02cea79>] inet_wait_for_connect+0x119/0x298
 [<c01205d6>] autoremove_wake_function+0x0/0x4c
 [<c01205d6>] autoremove_wake_function+0x0/0x4c
 [<c02cee10>] inet_stream_connect+0x218/0x340
 [<c028123b>] move_addr_to_kernel+0x6b/0x70
 [<c0282c42>] sys_connect+0x78/0x9a
 [<c011b213>] do_page_fault+0x27f/0x4bd
 [<c028261c>] sock_create+0x100/0x2b0
 [<c0282806>] sys_socket+0x3a/0x56
 [<c0283726>] sys_socketcall+0xb2/0x262
 [<c0151c18>] sys_munmap+0x58/0x78
 [<c010b41f>] syscall_call+0x7/0xb

grep          S 00000001 4293967752   688    670                 687 (NOTLB)
Call Trace:
 [<c016cc0b>] pipe_wait+0x8b/0xc0
 [<c01205d6>] autoremove_wake_function+0x0/0x4c
 [<c0169dd6>] cp_new_stat64+0xe6/0xea
 [<c01205d6>] autoremove_wake_function+0x0/0x4c
 [<c016cd98>] pipe_read+0x158/0x246
 [<c015e96d>] vfs_read+0xaf/0x11a
 [<c015ebe7>] sys_read+0x3f/0x5e
 [<c010b41f>] syscall_call+0x7/0xb

