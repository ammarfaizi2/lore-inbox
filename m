Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268686AbTBZJCJ>; Wed, 26 Feb 2003 04:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268687AbTBZJCJ>; Wed, 26 Feb 2003 04:02:09 -0500
Received: from mail-out2.cytanet.com.cy ([195.14.133.169]:14027 "EHLO
	mail-out2.cytanet.com.cy") by vger.kernel.org with ESMTP
	id <S268686AbTBZJCF>; Wed, 26 Feb 2003 04:02:05 -0500
Date: Wed, 26 Feb 2003 04:12:14 -0500
From: wyleus <coyote1@cytanet.com.cy>
To: linux-kernel@vger.kernel.org
Subject: syslog full of kernel BUGS, frequent intermittent instability
Message-Id: <20030226041214.71e1ddc7.coyote1@cytanet.com.cy>
X-Mailer: Sylpheed version 0.8.3claws (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

My recently installed Mandrake 9.0 has been unstable since day one.  The syslog is full of kernel BUG lines (see below), the crashes are frequent, and I don't know how to reproduce them - recognize no pattern to them.

I have run memtest86 overnight (~13 hours) - it reported no errors.  So would I be correct in assuming that my RAM can be ruled out?  I have also passed both the "noapic" and "mem=nopentium" parameters to lilo, but that hasn't resulted in any noticeable improvement.

Also, I have a big fan blowing into the open box to cool everything, which fixed an overheating problem I had last summer.  Also I recently cleaned out any dust inside the box, which wasn't much anyway.

The system is dual booting with win98 - and while win 98 does crash occasionally, it is much less frequent than what I'm getting with the mdk9 partition.  

The hardware is as follows:

MSI super7 mobo w/ alladin 5 chipset
AMD k6-2 350 MHz w/ 3D-now
128m pc-100 RAM (single stick)
/dev/hda = 13 gig Quantum Fireball 
/dev/hdc = Ricoh 7060A CDRW
PSU: 235 watt (Kobian)
video: Voodoo Banshee (Creative) AGP/PCI plugged into AGP slot
sound: creative sb16 P&P (vibra) ISA card
USB device: Alcatel SpeedtouchUSB ADSL modem

note: I do not have a floppy drive installed

My BIOS is at the "failsafe" settings, with only one or two exceptions (to keep it from running like a 386).  No overclocking or any other tweaking anywhere on my part.  The BIOS has been flashed to the latest recommmended version for my particular mobo revision.

This is a stock mandrake 9.0 installation.

$ cat /proc/version 
Linux version 2.4.19-16mdk (quintela@bi.mandrakesoft.com) (gcc version 3.2 (Mandrake Linux 9.0 3.2-1mdk)) #1 Fri Sep 20 18:15:05 CEST 2002

The crashes often result in a hard freeze (no reaction to ctl-alt-del or to ctl-alt-bckspc - keyboard LED doesn't respond to caps lock).  I am in X11 almost exclusively - so I have not seen whether it will also crash at the console.  Sometimes I can go days without a crash, other times it can crash several times in a few hours.  Not all of the kernel BUG messages resulted in my system crashing, at times I notice the BUG line in the log but wouldn't have noticed anything unusual as a user in X.

I would appreciate any insight anyone can provide.  Let me know if I can provide any more info.  

I haven't suscribed to this ML because I don't want the volume in my mailbox - but will monitor this thread through google groups.

sample output of grep -i bug /var/log/syslog (on a bad day)

Jan  4 18:32:38 localhost kernel: kernel BUG at page_alloc.c:224!
Jan  4 18:32:38 localhost kernel:  kernel BUG at page_alloc.c:97!
Jan  4 18:39:21 localhost kernel:  kernel BUG at page_alloc.c:97!
Jan  4 18:39:50 localhost kernel:  kernel BUG at page_alloc.c:97!
Jan  4 18:39:50 localhost kernel:  kernel BUG at mmap.c:1245!
Jan  4 18:41:48 localhost kernel: kernel BUG at page_alloc.c:97!
Jan  4 18:41:48 localhost kernel:  kernel BUG at mmap.c:1245!
Jan  4 18:42:48 localhost kernel:  kernel BUG at page_alloc.c:97!
Jan  4 18:42:53 localhost kernel: kernel BUG at page_alloc.c:97!
Jan  4 18:42:53 localhost kernel:  kernel BUG at mmap.c:1245!
Jan  4 18:43:35 localhost kernel:  kernel BUG at page_alloc.c:97!
Jan  4 18:43:35 localhost kernel:  kernel BUG at mmap.c:1245!
Jan  4 18:43:43 localhost kernel:  kernel BUG at page_alloc.c:97!
Jan  4 18:43:43 localhost kernel:  kernel BUG at mmap.c:1245!
Jan  4 18:43:55 localhost kernel:  kernel BUG at page_alloc.c:97!
Jan  4 18:43:55 localhost kernel:  kernel BUG at mmap.c:1245!
Jan  4 18:44:42 localhost kernel:  kernel BUG at page_alloc.c:97!
Jan  4 19:00:14 localhost kernel: kernel BUG at page_alloc.c:97!
Jan  4 19:00:14 localhost kernel:  kernel BUG at mmap.c:1245!
Jan  4 19:00:32 localhost kernel:  kernel BUG at page_alloc.c:97!
Jan  4 19:00:32 localhost kernel:  kernel BUG at mmap.c:1245!
Jan  4 19:25:32 localhost kernel: kernel BUG at page_alloc.c:97!
Jan  4 19:25:33 localhost kernel:  kernel BUG at page_alloc.c:97!
Jan  4 19:25:33 localhost kernel:  kernel BUG at page_alloc.c:97!
Jan  4 19:25:33 localhost kernel:  kernel BUG at page_alloc.c:97!
Jan  4 19:25:33 localhost kernel:  kernel BUG at mmap.c:1245!
Jan  4 19:25:38 localhost kernel:  kernel BUG at page_alloc.c:97!
Jan  4 19:25:38 localhost kernel:  kernel BUG at page_alloc.c:97!
Jan  4 19:36:53 localhost kernel:  kernel BUG at page_alloc.c:224!
Jan  4 19:36:55 localhost kernel:  kernel BUG at page_alloc.c:224!

Syslog excerpt providing some context for a single crash;

Jan 13 12:01:01 localhost CROND[2334]: (root) CMD (nice -n 19 run-parts /etc/cron.hourly)
Jan 13 13:01:00 localhost CROND[2399]: (root) CMD (nice -n 19 run-parts /etc/cron.hourly)
Jan 13 13:21:20 localhost kernel: kernel BUG at page_alloc.c:224!
Jan 13 13:21:20 localhost kernel: invalid operand: 0000
Jan 13 13:21:20 localhost kernel: CPU:    0
Jan 13 13:21:20 localhost kernel: EIP:    0010:[rmqueue+631/672]    Not tainted
Jan 13 13:21:20 localhost kernel: EIP:    0010:[<c0134307>]    Not tainted
Jan 13 13:21:20 localhost kernel: EFLAGS: 00013202
Jan 13 13:21:20 localhost kernel: eax: 00000040   ebx: 00007000   ecx: 00001000   edx: 00002c2c
Jan 13 13:21:20 localhost kernel: esi: c100001c   edi: c10797ac   ebp: c025f5cc   esp: c67e1e54
Jan 13 13:21:20 localhost kernel: ds: 0018   es: 0018   ss: 0018
Jan 13 13:21:20 localhost kernel: Process X (pid: 1942, stackpage=c67e1000)
Jan 13 13:21:20 localhost kernel: Stack: 00001000 c10797ac c772d3e0 00001c2c 00003292 00000000 c025f5cc c025f5cc
Jan 13 13:21:20 localhost kernel:        c025f788 00000001 c67e1eb4 c0134564 c5725e2c c67e1ec8 00000000 00000018
Jan 13 13:21:20 localhost kdm[1939]: Server for display :0 terminated unexpectedly
Jan 13 13:21:20 localhost kernel:        c025f5cc c025f784 00000000 000001d2 c10797d8 00104025 00000025 c35ba4e0
Jan 13 13:21:21 localhost kernel: Call Trace:    [__alloc_pages+116/608] [do_anonymous_page+98/272] [handle_mm_fault+87/192] [do_page_fault+529/1397] [ppp_synctty:__insmod_ppp_synctty_O/lib/modules/2.4.19-16mdk/kernel/driv+-493048/96]
Jan 13 13:21:21 localhost kernel: Call Trace:    [<c0134564>] [<c012a122>] [<c012a3d7>] [<c0118551>] [<c8862a08>]
Jan 13 13:21:21 localhost kernel:   [ppp_synctty:__insmod_ppp_synctty_O/lib/modules/2.4.19-16mdk/kernel/driv+-492738/96] [ppp_synctty:__insmod_ppp_synctty_O/lib/modules/2.4.19-16mdk/kernel/driv+-437849/96] [handle_IRQ_event+55/112] [do_IRQ+123/192] [do_IRQ+154/192] [do_page_fault+0/1397]
Jan 13 13:21:21 localhost kernel:   [<c8862b3e>] [<c88701a7>] [<c010a247>] [<c010a3db>] [<c010a3fa>] [<c0118340>]
Jan 13 13:21:21 localhost kernel:   [error_code+52/64]
Jan 13 13:21:21 localhost kernel:   [<c01090f4>]
Jan 13 13:21:21 localhost kernel:
Jan 13 13:21:21 localhost kernel: Code: 0f 0b e0 00 80 5e 23 c0 8b 47 18 a9 80 00 00 00 74 08 0f 0b
Jan 13 13:21:21 localhost kernel:  kernel BUG at page_alloc.c:97!
Jan 13 13:21:21 localhost kernel: invalid operand: 0000
Jan 13 13:21:21 localhost kernel: CPU:    0
Jan 13 13:21:21 localhost kernel: EIP:    0010:[__free_pages_ok+71/848]    Not tainted
Jan 13 13:21:21 localhost kernel: EIP:    0010:[<c0133d87>]    Not tainted
Jan 13 13:21:21 localhost kernel: EFLAGS: 00210286
Jan 13 13:21:21 localhost kernel: eax: ffffffff   ebx: c10797ac   ecx: c4ff5e48   edx: 0000462d
Jan 13 13:21:21 localhost kernel: esi: 00000000   edi: 00000000   ebp: c63bbf08   esp: c63bbed0
Jan 13 13:21:21 localhost kernel: ds: 0018   es: 0018   ss: 0018
Jan 13 13:21:21 localhost kernel: Process kpaint (pid: 2459, stackpage=c63bb000)
Jan 13 13:21:21 localhost kernel: Stack: c025f67c fffffffe 00007000 c100001c c10e98d8 c10e98ac c025f5cc c102c01c
Jan 13 13:21:21 localhost kernel:        00200213 ffffffff 00000419 02c2c025 00034000 c552eb04 c63bbf28 c012a92f
Jan 13 13:21:21 localhost kernel:        c10797ac c10797ac 00000035 40400000 c78fc404 40400000 c63bbf60 c01291c2
Jan 13 13:21:21 localhost kernel: Call Trace:    [zap_pte_range+271/308] [zap_page_range+130/256] [exit_mmap+180/304] [mmput+53/128] [do_exit+133/560]
Jan 13 13:21:21 localhost kernel: Call Trace:    [<c012a92f>] [<c01291c2>] [<c012bcb4>] [<c011a385>] [<c011e915>]
Jan 13 13:21:21 localhost kernel:   [sys_exit+17/32] [system_call+51/64]
Jan 13 13:21:21 localhost kernel:   [<c011eaf1>] [<c0108fe3>]
Jan 13 13:21:21 localhost kernel:
Jan 13 13:21:21 localhost kernel: Code: 0f 0b 61 00 80 5e 23 c0 8b 15 30 86 2c c0 89 d8 29 d0 c1 f8
Jan 13 13:21:32 localhost devfsd[105]: error calling: "unlink" in "GLOBAL"
Jan 13 13:21:37 localhost last message repeated 13 times
Jan 13 13:23:04 localhost init: Switching to runlevel: 6
Jan 13 13:23:07 localhost lisa: Stopping lisa:  succeeded
Jan 13 13:23:07 localhost dm: Stopping display manager:
