Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293279AbSB1KlV>; Thu, 28 Feb 2002 05:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293256AbSB1KjC>; Thu, 28 Feb 2002 05:39:02 -0500
Received: from linux.kappa.ro ([194.102.255.131]:36328 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S293085AbSB1Kgj>;
	Thu, 28 Feb 2002 05:36:39 -0500
Date: Thu, 28 Feb 2002 12:38:13 +0200 (EET)
From: Teodor Iacob <theo@astral.kappa.ro>
X-X-Sender: <theo@linux.kappa.ro>
Reply-To: <Teodor.Iacob@astral.kappa.ro>
To: Chris Rankin <cj.rankin@ntlworld.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.18 : lots of "state D" processes
In-Reply-To: <200202272307.g1RN7jsg000527@twopit.underworld>
Message-ID: <Pine.LNX.4.31.0202281236420.8068-100000@linux.kappa.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-RAVMilter-Version: 8.3.0(snapshot 20011220) (linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I got a few stats "D" process also with 2.4.19-pre1-rmap12g, the processes
were using my usb printer, which actually I never got it to work anyway
because this was the first kernel to try to make it work, and ofc I
couldn't kill the processes, but the reboot went cleanly.
Teo

On Wed, 27 Feb 2002, Chris Rankin wrote:

> Hi,
>
> I am running a freshly minted Linux-2.4.18 (SMP, devfs, >1GB memory)
> kernel + the linux-2.4.18-rc2-gregkh-1.patch.gz patch. (I do not,
> however, currently have any USB devices installed.) Anyway, my process
> table has just filled up with lots of "uninterruptibly sleeping"
> processes. I managed to do a "SysRq-T", "SysRQ-S" and so have
> generated a trace for you nice people.
>
> Something tells me that 2.4.18 isn't going to be a "keeper".
>
> Cheers,
> Chris
>
> Feb 27 22:49:33 twopit kernel: SysRq : Show State
> Feb 27 22:49:33 twopit kernel:
> Feb 27 22:49:33 twopit kernel:                          free                        sibling
> Feb 27 22:49:33 twopit kernel:   task             PC    stack   pid father child younger older
> Feb 27 22:49:33 twopit kernel: init          S C2411F2C  3888     1      0 15595       3       (NOTLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [schedule_timeout+122/156] [process_timeout+0/96] [do_select+458/516] [sys_select+832/1148] [system_call+51/56]
> Feb 27 22:49:33 twopit kernel: keventd       R 00000001  5720     2      1             8       (L-TLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [flush_to_ldisc+155/284] [__run_task_queue+96/108] [context_thread+311/464] [kernel_thread+40/56]
> Feb 27 22:49:33 twopit kernel: ksoftirqd_CPU S C242E000  6148     3      0             4     1 (L-TLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [do_softirq+111/204] [ksoftirqd+144/196] [kernel_thread+40/56]
> Feb 27 22:49:33 twopit kernel: ksoftirqd_CPU S C242C000  6148     4      0             5     3 (L-TLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [do_softirq+111/204] [ksoftirqd+144/196] [kernel_thread+40/56]
> Feb 27 22:49:33 twopit kernel: kswapd        S F7BFE000  6356     5      0             6     4 (L-TLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [exit_mm+14/124] [kswapd+130/180] [kernel_thread+40/56]
> Feb 27 22:49:33 twopit kernel: bdflush       S 00000286  5952     6      0             7     5 (L-TLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [interruptible_sleep_on+74/108] [bdflush+207/212] [kernel_thread+40/56]
> Feb 27 22:49:33 twopit kernel: kupdated      S F7BD9FC8  5588     7      0                   6 (L-TLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [schedule_timeout+122/156] [process_timeout+0/96] [kupdate+163/288] [kernel_thread+40/56]
> Feb 27 22:49:33 twopit kernel: kjournald     S 00000286  5360     8      1            14     2 (L-TLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [interruptible_sleep_on+74/108] [kjournald+345/460] [commit_timeout+0/12] [kernel_thread+40/56]
> Feb 27 22:49:33 twopit kernel: devfsd        S F77CA000  5712    14      1            39     8 (NOTLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [devfsd_read+254/956] [dput+25/340] [sys_read+143/272] [system_call+51/56]
> Feb 27 22:49:33 twopit kernel: khubd         S 00000286     0    39      1           323    14 (L-TLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [eepro100:__insmod_eepro100_O/lib/modules/2.4.18/kernel/drivers/net/e+-256344/96] [interruptible_sleep_on+74/108] [eepro100:__insmod_eepro100_O/lib/modules/2.4.18/kernel/drivers/net/e+-265049/96] [eepro100:__insmod_eepro100_O/lib/modules/2.4.18/kernel/drivers/net/e+-256340/96] [eepro100:__insmod_eepro100_O/lib/modules/2.4.18/kernel/drivers/net/e+-256340/96]
> Feb 27 22:49:33 twopit kernel:    [eepro100:__insmod_eepro100_O/lib/modules/2.4.18/kernel/drivers/net/e+-297114/96] [kernel_thread+40/56]
> Feb 27 22:49:33 twopit kernel: syslogd       S 7FFFFFFF  5276   322      1           329   327 (NOTLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148] [system_call+51/56]
> Feb 27 22:49:33 twopit kernel: klogd         R F75A4000  4848   323      1           325    39 (NOTLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [do_syslog+196/932] [kmsg_read+17/24] [sys_read+143/272] [system_call+51/56]
> Feb 27 22:49:33 twopit kernel: rpc.portmap   S 7FFFFFFF     0   325      1           327   323 (NOTLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [sock_poll+35/40] [schedule_timeout+23/156] [do_poll+134/220] [do_poll+187/220] [sys_poll+477/740]
> Feb 27 22:49:33 twopit kernel:    [sys_socketcall+484/512] [system_call+51/56]
> Feb 27 22:49:33 twopit kernel: inetd         S 7FFFFFFF  2400   327      1           322   325 (NOTLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [__pollwait+136/144] [tcp_poll+46/344] [schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148]
> Feb 27 22:49:33 twopit kernel:    [system_call+51/56]
> Feb 27 22:49:33 twopit kernel: lpd           S 7FFFFFFF     0   329      1           332   322 (NOTLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148] [system_call+51/56]
> Feb 27 22:49:33 twopit kernel: rpc.mountd    S 7FFFFFFF  6096   332      1           337   329 (NOTLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [sock_poll+35/40] [schedule_timeout+23/156] [do_poll+134/220] [do_poll+187/220] [sys_poll+477/740]
> Feb 27 22:49:33 twopit kernel:    [filp_close+170/180] [system_call+51/56]
> Feb 27 22:49:33 twopit kernel: nfsd          S 7FFFFFFF  5136   337      1           338   332 (L-TLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [schedule+1206/1408] [schedule_timeout+23/156] [<f8907da4>] [<f88f36de>] [<f890a294>]
> Feb 27 22:49:33 twopit kernel:    [<f8919b20>] [<f8919b20>] [kernel_thread+40/56]
> Feb 27 22:49:33 twopit kernel: lockd         S 7FFFFFFF  4804   338      1   339     341   337 (L-TLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [schedule_timeout+23/156] [reschedule+5/12] [<f88f36de>] [<f88fed09>] [kernel_thread+40/56]
> Feb 27 22:49:33 twopit kernel: rpciod        S 00000001  6324   339    338                     (L-TLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [<f88f7412>] [<f88f02b4>] [<f88f9d1c>] [<f88f9d1c>] [<f88f9d14>]
> Feb 27 22:49:33 twopit kernel:    [<f88f9d14>] [kernel_thread+40/56] [<f88f9d1c>] [<f88f9d28>]
> Feb 27 22:49:33 twopit kernel: rpc.statd     S 7FFFFFFF  2404   341      1           343   338 (NOTLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [__pollwait+136/144] [tcp_poll+46/344] [schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148]
> Feb 27 22:49:33 twopit kernel:    [system_call+51/56]
> Feb 27 22:49:33 twopit kernel: rpc.rquotad   S 7FFFFFFF     0   343      1           349   341 (NOTLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [sock_poll+35/40] [schedule_timeout+23/156] [do_poll+134/220] [do_poll+187/220] [sys_poll+477/740]
> Feb 27 22:49:33 twopit kernel:    [system_call+51/56]
> Feb 27 22:49:33 twopit kernel: cron          S F743BF88  5736   349      1           355   343 (NOTLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [schedule_timeout+122/156] [process_timeout+0/96] [sys_nanosleep+272/469] [system_call+51/56]
> Feb 27 22:49:33 twopit kernel: sendmail      S F7173F2C     0   355      1           370   349 (NOTLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [schedule_timeout+122/156] [process_timeout+0/96] [do_select+458/516] [sys_select+832/1148] [system_call+51/56]
> Feb 27 22:49:33 twopit kernel: acpid         S 7FFFFFFF  2384   370      1   371     436   355 (NOTLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148] [system_call+51/56]
> Feb 27 22:49:33 twopit kernel: acpid         S F70EA000  6036   371    370                     (NOTLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [dentry_open+225/396] [<f8937bc8>] [<f8939c78>] [<f8939c78>] [sys_read+143/272]
> Feb 27 22:49:33 twopit kernel:    [system_call+51/56]
> Feb 27 22:49:33 twopit kernel: ntpd          S 7FFFFFFF     0   436      1           437   370 (NOTLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148] [system_call+51/56]
> Feb 27 22:49:33 twopit kernel: bash          S 00000000  1376   437      1 15590     438   436 (NOTLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [sys_wait4+921/976] [system_call+51/56]
> Feb 27 22:49:33 twopit kernel: xdm           S F6DA9FB0     0   438      1   442     480   437 (NOTLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [sys_rt_sigaction+159/324] [sys_rt_sigsuspend+251/280] [system_call+51/56]
> Feb 27 22:49:33 twopit kernel: X             S F6C5FF2C     0   441    438           442       (NOTLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [__pollwait+136/144] [schedule_timeout+122/156] [process_timeout+0/96] [do_select+458/516] [sys_select+832/1148]
> Feb 27 22:49:33 twopit kernel:    [system_call+51/56]
> Feb 27 22:49:33 twopit kernel: xdm           S 00000000     0   442    438   483           441 (NOTLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [sys_wait4+921/976] [system_call+51/56]
> Feb 27 22:49:33 twopit kernel: xconsole      S 7FFFFFFF     0   480      1           491   438 (NOTLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148] [system_call+51/56]
> Feb 27 22:49:33 twopit kernel: xsm           S 7FFFFFFF     0   483    442                     (NOTLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148] [system_call+51/56]
> Feb 27 22:49:33 twopit kernel: twm           S 7FFFFFFF  2400   491      1           493   480 (NOTLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148] [system_call+51/56]
> Feb 27 22:49:33 twopit kernel: smproxy       S 7FFFFFFF  2400   493      1           503   491 (NOTLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148] [system_call+51/56]
> Feb 27 22:49:33 twopit kernel: xclock        S F5E7FF2C     0   501      1           595   587 (NOTLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [__pollwait+136/144] [schedule_timeout+122/156] [<fb38fe08>] [process_timeout+0/96] [do_select+458/516]
> Feb 27 22:49:33 twopit kernel:    [sys_select+832/1148] [system_call+51/56]
> Feb 27 22:49:33 twopit kernel: fetchmail     S F5E6DF2C     0   503      1           510   493 (NOTLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [schedule_timeout+122/156] [process_timeout+0/96] [do_select+458/516] [sys_select+832/1148] [system_call+51/56]
> Feb 27 22:49:33 twopit kernel: ymessenger    S 00000000  4696   510      1 10216     587   503 (NOTLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [sys_wait4+921/976] [system_call+51/56]
> Feb 27 22:49:33 twopit kernel: xbiff         S F5BD5F2C     0   587      1           501   510 (NOTLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [__pollwait+136/144] [schedule_timeout+122/156] [process_timeout+0/96] [do_select+458/516] [sys_select+832/1148]
> Feb 27 22:49:33 twopit kernel:    [system_call+51/56]
> Feb 27 22:49:33 twopit kernel: xterm         S 7FFFFFFF  2400   595      1   600     603   501 (NOTLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148] [system_call+51/56]
> Feb 27 22:49:33 twopit kernel: bash          S 00000000  1376   600    595 15585               (NOTLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [sys_wait4+921/976] [system_call+51/56]
> Feb 27 22:49:33 twopit kernel: xterm         S 7FFFFFFF     0   603      1   608     623   595 (NOTLB)
> Feb 27 22:49:33 twopit kernel: Call Trace: [schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148] [system_call+51/56]
> Feb 27 22:49:34 twopit kernel: bash          S 00000000  1376   608    603   643               (NOTLB)
> Feb 27 22:49:34 twopit kernel: Call Trace: [sys_wait4+921/976] [system_call+51/56]
> Feb 27 22:49:34 twopit kernel: setiwatcher   S F5B61FB0  4696   623      1   625     627   603 (NOTLB)
> Feb 27 22:49:34 twopit kernel: Call Trace: [sys_rt_sigsuspend+251/280] [system_call+51/56]
> Feb 27 22:49:34 twopit kernel: setiathome    R F5B7E000     0   624    623           625       (NOTLB)
> Feb 27 22:49:34 twopit kernel: Call Trace: [do_IRQ+219/236] [reschedule+5/12]
> Feb 27 22:49:34 twopit kernel: setiathome    R current   4696   625    623                 624 (NOTLB)
> Feb 27 22:49:34 twopit kernel: Call Trace: [do_IRQ+166/236]
> Feb 27 22:49:34 twopit kernel: xterm         S 7FFFFFFF  2400   627      1   632     635   623 (NOTLB)
> Feb 27 22:49:34 twopit kernel: Call Trace: [schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148] [system_call+51/56]
> Feb 27 22:49:34 twopit kernel: bash          S 00000000  5244   632    627 15581               (NOTLB)
> Feb 27 22:49:34 twopit kernel: Call Trace: [sys_wait4+921/976] [system_call+51/56]
> Feb 27 22:49:34 twopit kernel: xterm         S 7FFFFFFF     0   635      1   636     638   627 (NOTLB)
> Feb 27 22:49:34 twopit kernel: Call Trace: [schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148] [system_call+51/56]
> Feb 27 22:49:34 twopit kernel: telnet        S 7FFFFFFF     0   636    635                     (NOTLB)
> Feb 27 22:49:34 twopit kernel: Call Trace: [schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148] [system_call+51/56]
> Feb 27 22:49:34 twopit kernel: xterm         S 7FFFFFFF  2400   638      1   639     641   635 (NOTLB)
> Feb 27 22:49:34 twopit kernel: Call Trace: [schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148] [system_call+51/56]
> Feb 27 22:49:34 twopit kernel: telnet        S 7FFFFFFF     0   639    638                     (NOTLB)
> Feb 27 22:49:34 twopit kernel: Call Trace: [schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148] [system_call+51/56]
> Feb 27 22:49:34 twopit kernel: xterm         S 7FFFFFFF  5244   641      1   642    3578   638 (NOTLB)
> Feb 27 22:49:34 twopit kernel: Call Trace: [schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148] [system_call+51/56]
> Feb 27 22:49:34 twopit kernel: telnet        S 7FFFFFFF  2404   642    641                     (NOTLB)
> Feb 27 22:49:34 twopit kernel: Call Trace: [schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148] [system_call+51/56]
> Feb 27 22:49:34 twopit kernel: bash          S 00000000     0   643    608 15587               (NOTLB)
> Feb 27 22:49:34 twopit kernel: Call Trace: [sys_wait4+921/976] [system_call+51/56]
> Feb 27 22:49:34 twopit kernel: wine          R F465FC58     0  3578      1          5243   641 (L-TLB)
> Feb 27 22:49:34 twopit kernel: Call Trace: [schedule_timeout+122/156] [process_timeout+0/96] [<f898b303>] [<f898ccad>] [piix_dmaproc+35/44]
> Feb 27 22:49:34 twopit kernel:    [do_rw_disk+388/808] [__delay+19/40] [__const_udelay+41/52] [eepro100:__insmod_eepro100_S.text_L12032+5758/12096] [do_get_write_access+1526/1564] [__journal_file_buffer+229/540]
> Feb 27 22:49:34 twopit kernel:    [journal_dirty_metadata+420/460] [ext3_do_update_inode+763/920] [ext3_do_update_inode+866/920] [ext3_mark_iloc_dirty+34/72] [ext3_mark_iloc_dirty+51/72] [ext3_mark_inode_dirty+41/52]
> Feb 27 22:49:34 twopit kernel:    [ext3_dirty_inode+175/280] [__mark_inode_dirty+46/152] [ext3_free_blocks+1441/1452] [send_signal+44/256] [deliver_signal+29/128] [update_process_times+32/148]
> Feb 27 22:49:34 twopit kernel:    [reschedule_idle+607/616] [<f898d2d5>] [sock_def_wakeup+51/64] [<fb3aa4a6>] [<fb3ab648>] [fput+77/232]
> Feb 27 22:49:34 twopit kernel:    [filp_close+170/180] [put_files_struct+88/192] [do_exit+305/636] [sys_exit+14/16] [system_call+51/56]
> Feb 27 22:49:34 twopit kernel: wineserver    S 7FFFFFFF  2400  5243      1          5244  3578 (NOTLB)
> Feb 27 22:49:34 twopit kernel: Call Trace: [sock_poll+35/40] [schedule_timeout+23/156] [do_poll+134/220] [do_poll+187/220] [sys_poll+477/740]
> Feb 27 22:49:34 twopit kernel:    [filp_close+170/180] [system_call+51/56]
> Feb 27 22:49:34 twopit kernel: wine          D F7487580  2400  5244      1          5247  5243 (NOTLB)
> Feb 27 22:49:34 twopit kernel: Call Trace: [__down+108/200] [__down_failed+8/12] [<f898dc44>] [<f898cc5d>] [do_page_fault+380/1197]
> Feb 27 22:49:34 twopit kernel:    [do_page_fault+0/1197] [ext3_get_block_handle+189/680] [ext3_get_block_handle+189/680] [__alloc_pages+51/356] [<f898f605>] [<f898c128>]
> Feb 27 22:49:34 twopit kernel:    [<fb3ab2a0>] [<fb3ab51e>] [<fb3ab541>] [link_path_walk+1664/2128] [vfs_permission+116/240] [devfs_open+184/360]
> Feb 27 22:49:34 twopit kernel:    [<f898d2d5>] [<fb3aa389>] [sys_ioctl+443/520] [system_call+51/56]
> Feb 27 22:49:34 twopit kernel: wine          D F7487580  5244  5247      1          5252  5244 (NOTLB)
> Feb 27 22:49:34 twopit kernel: Call Trace: [__down+108/200] [__down_failed+8/12] [<f898dc44>] [<f898cc5d>] [do_page_fault+380/1197]
> Feb 27 22:49:34 twopit kernel:    [do_page_fault+0/1197] [ext3_get_block_handle+189/680] [ext3_get_block_handle+189/680] [__alloc_pages+51/356] [<f898f605>] [<f898c128>]
> Feb 27 22:49:34 twopit kernel:    [<fb3ab2a0>] [<fb3ab51e>] [<fb3ab541>] [link_path_walk+1664/2128] [vfs_permission+116/240] [devfs_open+184/360]
> Feb 27 22:49:34 twopit kernel:    [<f898d2d5>] [<fb3aa389>] [sys_ioctl+443/520] [system_call+51/56]
> Feb 27 22:49:34 twopit kernel: wine          D F7487580     0  5252      1         15595  5247 (NOTLB)
> Feb 27 22:49:34 twopit kernel: Call Trace: [__down+108/200] [__down_failed+8/12] [<f898dc44>] [<f898cc5d>] [do_page_fault+380/1197]
> Feb 27 22:49:34 twopit kernel:    [do_page_fault+0/1197] [ext3_get_block_handle+189/680] [ext3_get_block_handle+189/680] [__alloc_pages+51/356] [<f898f605>] [<f898c128>]
> Feb 27 22:49:34 twopit kernel:    [<fb3ab2a0>] [<fb3ab51e>] [<fb3ab541>] [link_path_walk+1664/2128] [vfs_permission+116/240] [devfs_open+184/360]
> Feb 27 22:49:34 twopit kernel:    [<f898d2d5>] [<fb3aa389>] [sys_ioctl+443/520] [system_call+51/56]
> Feb 27 22:49:34 twopit kernel: aplay         D F7487580  2400 10216    510                     (NOTLB)
> Feb 27 22:49:34 twopit kernel: Call Trace: [__down+108/200] [__down_failed+8/12] [<f898db9c>] [<f898ca5c>] [<f898cc42>]
> Feb 27 22:49:34 twopit kernel:    [__alloc_pages+51/356] [_alloc_pages+22/24] [do_anonymous_page+349/384] [do_no_page+54/780] [ide_set_handler+98/116] [ide_dmaproc+317/528]
> Feb 27 22:49:34 twopit kernel:    [ide_dma_intr+0/168] [dma_timer_expiry+0/96] [__alloc_pages+51/356] [filemap_nopage+188/504] [filemap_nopage+233/504] [do_no_page+98/780]
> Feb 27 22:49:34 twopit kernel:    [eepro100:__insmod_eepro100_O/lib/modules/2.4.18/kernel/drivers/net/e+-277245/96] [handle_mm_fault+92/188] [do_page_fault+380/1197] [do_page_fault+0/1197] [do_IRQ+219/236] [sys_ioctl+443/520]
> Feb 27 22:49:34 twopit kernel:    [system_call+51/56]
> Feb 27 22:49:34 twopit kernel: xine          D F7487580     0 15581    632 15582               (NOTLB)
> Feb 27 22:49:34 twopit kernel: Call Trace: [__down+108/200] [__down_failed+8/12] [<f898dbf0>] [<f898c50b>] [fput+77/232]
> Feb 27 22:49:34 twopit kernel:    [unmap_fixup+86/344] [do_munmap+487/592] [sys_munmap+54/84] [system_call+51/56]
> Feb 27 22:49:34 twopit kernel: xine          D F1CB3F6C    96 15582  15581                     (NOTLB)
> Feb 27 22:49:34 twopit kernel: Call Trace: [rwsem_down_write_failed+264/304] [_text_lock_ldt+6/34] [sys_modify_ldt+89/94] [system_call+51/56]
> Feb 27 22:49:34 twopit kernel: ps            D F1D79F14  2400 15584    600         15585       (NOTLB)
> Feb 27 22:49:34 twopit kernel: Call Trace: [rwsem_down_read_failed+268/308] [_text_lock_array+99/273] [_alloc_pages+22/24] [proc_info_read+83/276] [sys_read+143/272]
> Feb 27 22:49:34 twopit kernel:    [system_call+51/56]
> Feb 27 22:49:34 twopit kernel: grep          S F117E000     0 15585    600               15584 (NOTLB)
> Feb 27 22:49:34 twopit kernel: Call Trace: [pipe_wait+125/164] [pipe_read+176/504] [sys_read+143/272] [system_call+51/56]
> Feb 27 22:49:34 twopit kernel: ps            D F1BB9F14     0 15586    643         15587       (NOTLB)
> Feb 27 22:49:34 twopit kernel: Call Trace: [rwsem_down_read_failed+268/308] [vfs_permission+116/240] [_text_lock_array+99/273] [_alloc_pages+22/24] [proc_info_read+83/276]
> Feb 27 22:49:34 twopit kernel:    [sys_read+143/272] [system_call+51/56]
> Feb 27 22:49:34 twopit kernel: grep          S F24DE000     0 15587    643               15586 (NOTLB)
> Feb 27 22:49:34 twopit kernel: Call Trace: [pipe_wait+125/164] [pipe_read+176/504] [sys_read+143/272] [system_call+51/56]
> Feb 27 22:49:34 twopit kernel: ps            D F1201F14     0 15590    437                     (NOTLB)
> Feb 27 22:49:34 twopit kernel: Call Trace: [rwsem_down_read_failed+268/308] [vfs_permission+116/240] [_text_lock_array+99/273] [_alloc_pages+22/24] [proc_info_read+83/276]
> Feb 27 22:49:34 twopit kernel:    [sys_read+143/272] [system_call+51/56]
> Feb 27 22:49:34 twopit kernel: xterm         S 7FFFFFFF     0 15595      1 15600          5252 (NOTLB)
> Feb 27 22:49:34 twopit kernel: Call Trace: [schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148] [system_call+51/56]
> Feb 27 22:49:34 twopit kernel: bash          S 00000000  4696 15600  15595 15602               (NOTLB)
> Feb 27 22:49:34 twopit kernel: Call Trace: [sys_wait4+921/976] [system_call+51/56]
> Feb 27 22:49:34 twopit kernel: killall       D F496BF14  2400 15602  15600                     (NOTLB)
> Feb 27 22:49:34 twopit kernel: Call Trace: [rwsem_down_read_failed+268/308] [_text_lock_array+99/273] [_alloc_pages+22/24] [proc_info_read+83/276] [sys_mmap2+101/148]
> Feb 27 22:49:34 twopit kernel:    [sys_read+143/272] [system_call+51/56]
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

