Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286313AbRLTSR7>; Thu, 20 Dec 2001 13:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286312AbRLTSRt>; Thu, 20 Dec 2001 13:17:49 -0500
Received: from timbuktu-03.budapest.interware.hu ([195.70.51.195]:8196 "EHLO
	iluvatar.ath.cx") by vger.kernel.org with ESMTP id <S286313AbRLTSR1>;
	Thu, 20 Dec 2001 13:17:27 -0500
Date: Thu, 20 Dec 2001 19:17:12 +0100
From: Gergely Nagy <algernon@debian.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17rc2aa1
Message-ID: <20011220181712.GA2494@iluvatar>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011219161610.I1395@athlon.random> <83k7vjdk8j.wl@iluvatar.ath.cx> <20011219215208.U1395@athlon.random>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
In-Reply-To: <20011219215208.U1395@athlon.random>
User-Agent: Mutt/1.3.24i
Organisation: The MadHouse Project
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

The output of ksymoops, and some other miscellaneous information is
attached, as I promised.

The box is an AMD K6-300, with 64Mb memory, and around 130Mb swap
(from which ~110Mb was free, there was no VM pressure). It is running
Debian unstable.

What I did was to boot into my system as usual, then stop all
processes I didn't need. After that, I did a `touch /tmp/foo', then a
`sync'. /tmp is /var/cache/ext3test, despite the filename, it is ext2,
mounted from an ext3 partition (/) (see the output of mount below).

`sync' hung, and the load started to slowly increase, shortly before I
rebooted, it was almost at 3:

 12:02:26 up 6 min,  2 users,  load average: 2.97, 1.81, 0.78

(btw, before doing the `sync', the load was 0.99; with 2.4.14, my
usual load is between 0.20-0.50)

,----[ mount ]
| /dev/hda3 on / type ext3 (rw)
| proc on /proc type proc (rw)
| /dev/hda1 on /boot type ext2 (rw)
| /dev/hdd2 on /gnu type ext2 (rw)
| /dev/hdd1 on /gnu/mnt type ext2 (rw)
| /dev/hda6 on /gnu/work type ext3 (rw)
| /usr/bin/emacs on /bin/emacs type none (rw,bind)
| /gnu/work/cache-apt/archives on /var/cache/apt/archives type none (rw,bind)
| /gnu/work/lib-apt/lists on /var/lib/apt/lists type none (rw,bind)
| /gnu/work/cache-apt/archives on /chroot/base/var/cache/apt/archives type none (rw,bind)
| /gnu/work/lib-apt/lists on /chroot/base/var/lib/apt/lists type none (rw,bind)
| /var/cache/ext3test on /chroot/base/tmp type ext2 (rw,loop=/dev/loop0)
| devfs on /chroot/base/dev type devfs (rw)
| proc on /chroot/base/proc type proc (rw)
`----

--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="ksymoops.log"
Content-Transfer-Encoding: quoted-printable

ksymoops 2.4.3 on i586 2.4.17-rc2-aa1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-rc2-aa1/ (default)
     -m /home/local/algernon/src/linux/System.map (specified)

Dec 20 11:59:23 iluvatar kernel: init          S C11E3F24  4836     1      =
0   503       3       (NOTLB)
Using defaults from ksymoops -t elf32-i386 -a i386
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c010fcda>] [<c010fc1c>] [<c0=
138664>] [<c01389fc>] [<c0132326>]=20
Dec 20 11:59:23 iluvatar kernel:    [<c0106b33>]=20
Dec 20 11:59:23 iluvatar kernel: keventd       S 00010000  6000     2      =
1             7       (L-TLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c011ca05>] [<c0105470>]=20
Dec 20 11:59:23 iluvatar kernel: ksoftirqd_CPU S C11C2000  6396     3      =
0             4     1 (L-TLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c011611e>] [<c0105470>]=20
Dec 20 11:59:23 iluvatar kernel: kswapd        S C11C0000  6636     4      =
0             5     3 (L-TLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c012665d>] [<c0105470>]=20
Dec 20 11:59:23 iluvatar kernel: bdflush       S 00000286  6548     5      =
0             6     4 (L-TLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c011029d>] [<c012fb13>] [<c0=
105470>]=20
Dec 20 11:59:23 iluvatar kernel: kupdated      D C11BDF6C  6016     6      =
0                   5 (L-TLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c012d08c>] [<c012dfa3>] [<c0=
15e5d1>] [<c015e845>] [<c013cb85>]=20
Dec 20 11:59:23 iluvatar kernel:    [<c012f971>] [<c012fbf5>] [<c0105470>]=
=20
Dec 20 11:59:23 iluvatar kernel: kjournald     S 00000282  5568     7      =
1            22     2 (L-TLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c011029d>] [<c015918a>] [<c0=
158fe0>] [<c0105470>]=20
Dec 20 11:59:23 iluvatar kernel: devfsd        S C22CE000  5880    22      =
1            98     7 (NOTLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c0162e4d>] [<c01624b2>] [<c0=
12c3e5>] [<c0106b33>]=20
Dec 20 11:59:23 iluvatar kernel: kjournald     S 00000282  2488    97      =
1           189    98 (L-TLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c011029d>] [<c015918a>] [<c0=
158fe0>] [<c0105470>]=20
Dec 20 11:59:23 iluvatar kernel: loop0         D C25CA868     0    98      =
1            97    22 (L-TLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c010595d>] [<c0105aa8>] [<c0=
1efe73>] [<c0181ac8>] [<c0181fe9>]=20
Dec 20 11:59:23 iluvatar kernel:    [<c0105467>] [<c0105470>]=20
Dec 20 11:59:23 iluvatar kernel: syslog-ng     S C2AC9F28  5756   189      =
1           192    97 (NOTLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c01b095d>] [<c010fcda>] [<c0=
10fc1c>] [<c0138c7c>] [<c0138e7d>]=20
Dec 20 11:59:23 iluvatar kernel:    [<c0106b33>]=20
Dec 20 11:59:23 iluvatar kernel: klogd         R C2AA4000  5756   192      =
1           481   189 (NOTLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c0112194>] [<c01471b3>] [<c0=
12c3e5>] [<c0106b33>]=20
Dec 20 11:59:23 iluvatar kernel: zsh           S 7FFFFFFF  4920   481      =
1           482   192 (NOTLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c010fc7f>] [<c016c9ad>] [<c0=
168b56>] [<c012c3e5>] [<c0106b33>]=20
Dec 20 11:59:23 iluvatar kernel: zsh           S C2177FB0   884   482      =
1   657     483   481 (NOTLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c0105ce7>] [<c0106b33>]=20
Dec 20 11:59:23 iluvatar kernel: getty         S 7FFFFFFF   884   483      =
1           484   482 (NOTLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c010fc7f>] [<c016c9ad>] [<c0=
168b56>] [<c012c3e5>] [<c0106b33>]=20
Dec 20 11:59:23 iluvatar kernel: getty         S 7FFFFFFF   396   484      =
1           485   483 (NOTLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c010fc7f>] [<c016c9ad>] [<c0=
168b56>] [<c012c3e5>] [<c0106b33>]=20
Dec 20 11:59:23 iluvatar kernel: getty         S 7FFFFFFF     0   485      =
1           486   484 (NOTLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c010fc7f>] [<c016c9ad>] [<c0=
168b56>] [<c012c3e5>] [<c0106b33>]=20
Dec 20 11:59:23 iluvatar kernel: getty         S 7FFFFFFF     8   486      =
1           487   485 (NOTLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c010fc7f>] [<c016c9ad>] [<c0=
168b56>] [<c012c3e5>] [<c0106b33>]=20
Dec 20 11:59:23 iluvatar kernel: getty         S 7FFFFFFF    12   487      =
1           488   486 (NOTLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c010fc7f>] [<c016c9ad>] [<c0=
168b56>] [<c012c3e5>] [<c0106b33>]=20
Dec 20 11:59:23 iluvatar kernel: getty         S 7FFFFFFF     0   488      =
1           489   487 (NOTLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c010fc7f>] [<c016c9ad>] [<c0=
168b56>] [<c012c3e5>] [<c0106b33>]=20
Dec 20 11:59:23 iluvatar kernel: getty         S 7FFFFFFF     0   489      =
1           490   488 (NOTLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c010fc7f>] [<c016c9ad>] [<c0=
168b56>] [<c012c3e5>] [<c0106b33>]=20
Dec 20 11:59:23 iluvatar kernel: getty         S 7FFFFFFF     0   490      =
1           491   489 (NOTLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c010fc7f>] [<c016c9ad>] [<c0=
168b56>] [<c012c3e5>] [<c0106b33>]=20
Dec 20 11:59:23 iluvatar kernel: getty         S 7FFFFFFF     0   491      =
1           492   490 (NOTLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c010fc7f>] [<c016c9ad>] [<c0=
168b56>] [<c012c3e5>] [<c0106b33>]=20
Dec 20 11:59:23 iluvatar kernel: getty         S 7FFFFFFF  5488   492      =
1           493   491 (NOTLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c010fc7f>] [<c016c9ad>] [<c0=
168b56>] [<c012c3e5>] [<c0106b33>]=20
Dec 20 11:59:23 iluvatar kernel: getty         S 7FFFFFFF  5488   493      =
1           494   492 (NOTLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c010fc7f>] [<c016c9ad>] [<c0=
168b56>] [<c012c3e5>] [<c0106b33>]=20
Dec 20 11:59:23 iluvatar kernel: getty         S 7FFFFFFF  5488   494      =
1           495   493 (NOTLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c010fc7f>] [<c016c9ad>] [<c0=
168b56>] [<c012c3e5>] [<c0106b33>]=20
Dec 20 11:59:23 iluvatar kernel: getty         S 7FFFFFFF  5488   495      =
1           496   494 (NOTLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c010fc7f>] [<c016c9ad>] [<c0=
168b56>] [<c012c3e5>] [<c0106b33>]=20
Dec 20 11:59:23 iluvatar kernel: getty         S 7FFFFFFF  5488   496      =
1           497   495 (NOTLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c010fc7f>] [<c016c9ad>] [<c0=
168b56>] [<c012c3e5>] [<c0106b33>]=20
Dec 20 11:59:23 iluvatar kernel: getty         S 7FFFFFFF  5488   497      =
1           498   496 (NOTLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c010fc7f>] [<c016c9ad>] [<c0=
168b56>] [<c012c3e5>] [<c0106b33>]=20
Dec 20 11:59:23 iluvatar kernel: getty         S 7FFFFFFF  5488   498      =
1           499   497 (NOTLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c010fc7f>] [<c016c9ad>] [<c0=
168b56>] [<c012c3e5>] [<c0106b33>]=20
Dec 20 11:59:23 iluvatar kernel: getty         S 7FFFFFFF  5488   499      =
1           500   498 (NOTLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c010fc7f>] [<c016c9ad>] [<c0=
168b56>] [<c012c3e5>] [<c0106b33>]=20
Dec 20 11:59:23 iluvatar kernel: getty         S 7FFFFFFF  5488   500      =
1           501   499 (NOTLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c010fc7f>] [<c016c9ad>] [<c0=
168b56>] [<c012c3e5>] [<c0106b33>]=20
Dec 20 11:59:23 iluvatar kernel: getty         S 7FFFFFFF  5488   501      =
1           502   500 (NOTLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c010fc7f>] [<c016c9ad>] [<c0=
168b56>] [<c012c3e5>] [<c0106b33>]=20
Dec 20 11:59:23 iluvatar kernel: getty         S 7FFFFFFF  5488   502      =
1           503   501 (NOTLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c010fc7f>] [<c016c9ad>] [<c0=
168b56>] [<c012c3e5>] [<c0106b33>]=20
Dec 20 11:59:23 iluvatar kernel: getty         S 7FFFFFFF  5488   503      =
1                 502 (NOTLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c010fc7f>] [<c016c9ad>] [<c0=
168b56>] [<c012c3e5>] [<c0106b33>]=20
Dec 20 11:59:23 iluvatar kernel: sync          D C3EE8000   596   657    48=
2                     (NOTLB)
Dec 20 11:59:23 iluvatar kernel: Call Trace: [<c013c8db>] [<c013ca9b>] [<c0=
13ccb9>] [<c012d433>] [<c012d46b>]=20
Dec 20 11:59:23 iluvatar kernel:    [<c0106b33>]=20
Warning (Oops_read): Code line not seen, dumping what data is available

Proc;  init
>>EIP; c11e3f24 <_end+f40070/259c14c>   <=3D=3D=3D=3D=3D
Trace; c010fcda <schedule_timeout+72/90>
Trace; c010fc1c <process_timeout+0/4c>
Trace; c0138664 <do_select+1a0/1dc>
Trace; c01389fc <sys_select+334/474>
Trace; c0132326 <sys_stat64+62/70>
Trace; c0106b32 <system_call+32/40>
Proc;  keventd
>>EIP; 00010000 Before first symbol   <=3D=3D=3D=3D=3D
Trace; c011ca04 <context_thread+f8/1a0>
Trace; c0105470 <kernel_thread+28/38>
Proc;  ksoftirqd_CPU
>>EIP; c11c2000 <_end+f1e14c/259c14c>   <=3D=3D=3D=3D=3D
Trace; c011611e <ksoftirqd+76/b0>
Trace; c0105470 <kernel_thread+28/38>
Proc;  kswapd
>>EIP; c11c0000 <_end+f1c14c/259c14c>   <=3D=3D=3D=3D=3D
Trace; c012665c <kswapd+80/c4>
Trace; c0105470 <kernel_thread+28/38>
Proc;  bdflush
>>EIP; 00000286 Before first symbol   <=3D=3D=3D=3D=3D
Trace; c011029c <interruptible_sleep_on+3c/50>
Trace; c012fb12 <bdflush+a2/a8>
Trace; c0105470 <kernel_thread+28/38>
Proc;  kupdated
>>EIP; c11bdf6c <_end+f1a0b8/259c14c>   <=3D=3D=3D=3D=3D
Trace; c012d08c <__wait_on_buffer+68/88>
Trace; c012dfa2 <bread+42/60>
Trace; c015e5d0 <ext2_update_inode+10c/374>
Trace; c015e844 <ext2_write_inode+c/14>
Trace; c013cb84 <sync_unlocked_inodes+b4/150>
Trace; c012f970 <sync_old_buffers+4/40>
Trace; c012fbf4 <kupdate+dc/100>
Trace; c0105470 <kernel_thread+28/38>
Proc;  kjournald
>>EIP; 00000282 Before first symbol   <=3D=3D=3D=3D=3D
Trace; c011029c <interruptible_sleep_on+3c/50>
Trace; c015918a <kjournald+19a/2b8>
Trace; c0158fe0 <commit_timeout+0/c>
Trace; c0105470 <kernel_thread+28/38>
Proc;  devfsd
>>EIP; c22ce000 <_end+202a14c/259c14c>   <=3D=3D=3D=3D=3D
Trace; c0162e4c <devfsd_read+f4/3a4>
Trace; c01624b2 <devfs_d_delete+3a/c4>
Trace; c012c3e4 <sys_read+94/cc>
Trace; c0106b32 <system_call+32/40>
Proc;  kjournald
>>EIP; 00000282 Before first symbol   <=3D=3D=3D=3D=3D
Trace; c011029c <interruptible_sleep_on+3c/50>
Trace; c015918a <kjournald+19a/2b8>
Trace; c0158fe0 <commit_timeout+0/c>
Trace; c0105470 <kernel_thread+28/38>
Proc;  loop0
>>EIP; c25ca868 <_end+23269b4/259c14c>   <=3D=3D=3D=3D=3D
Trace; c010595c <__down+54/9c>
Trace; c0105aa8 <__down_failed+8/c>
Trace; c01efe72 <stext_lock+ee2/273a>
Trace; c0181ac8 <do_bh_filebacked+58/98>
Trace; c0181fe8 <loop_thread+d0/1d4>
Trace; c0105466 <kernel_thread+1e/38>
Trace; c0105470 <kernel_thread+28/38>
Proc;  syslog-ng
>>EIP; c2ac9f28 <[cdrom].bss.end+26362a/2d4702>   <=3D=3D=3D=3D=3D
Trace; c01b095c <sock_poll+20/28>
Trace; c010fcda <schedule_timeout+72/90>
Trace; c010fc1c <process_timeout+0/4c>
Trace; c0138c7c <do_poll+b8/d8>
Trace; c0138e7c <sys_poll+1e0/2e4>
Trace; c0106b32 <system_call+32/40>
Proc;  klogd
>>EIP; c2aa4000 <[cdrom].bss.end+23d702/2d4702>   <=3D=3D=3D=3D=3D
Trace; c0112194 <do_syslog+c4/2c8>
Trace; c01471b2 <kmsg_read+e/14>
Trace; c012c3e4 <sys_read+94/cc>
Trace; c0106b32 <system_call+32/40>
Proc;  zsh
>>EIP; 7ffffffe Before first symbol   <=3D=3D=3D=3D=3D
Trace; c010fc7e <schedule_timeout+16/90>
Trace; c016c9ac <read_chan+37c/6d4>
Trace; c0168b56 <tty_read+aa/cc>
Trace; c012c3e4 <sys_read+94/cc>
Trace; c0106b32 <system_call+32/40>
Proc;  zsh
>>EIP; c2177fb0 <_end+1ed40fc/259c14c>   <=3D=3D=3D=3D=3D
Trace; c0105ce6 <sys_rt_sigsuspend+e2/100>
Trace; c0106b32 <system_call+32/40>
Proc;  getty
>>EIP; 7ffffffe Before first symbol   <=3D=3D=3D=3D=3D
Trace; c010fc7e <schedule_timeout+16/90>
Trace; c016c9ac <read_chan+37c/6d4>
Trace; c0168b56 <tty_read+aa/cc>
Trace; c012c3e4 <sys_read+94/cc>
Trace; c0106b32 <system_call+32/40>
Proc;  getty
>>EIP; 7ffffffe Before first symbol   <=3D=3D=3D=3D=3D
Trace; c010fc7e <schedule_timeout+16/90>
Trace; c016c9ac <read_chan+37c/6d4>
Trace; c0168b56 <tty_read+aa/cc>
Trace; c012c3e4 <sys_read+94/cc>
Trace; c0106b32 <system_call+32/40>
Proc;  getty
>>EIP; 7ffffffe Before first symbol   <=3D=3D=3D=3D=3D
Trace; c010fc7e <schedule_timeout+16/90>
Trace; c016c9ac <read_chan+37c/6d4>
Trace; c0168b56 <tty_read+aa/cc>
Trace; c012c3e4 <sys_read+94/cc>
Trace; c0106b32 <system_call+32/40>
Proc;  getty
>>EIP; 7ffffffe Before first symbol   <=3D=3D=3D=3D=3D
Trace; c010fc7e <schedule_timeout+16/90>
Trace; c016c9ac <read_chan+37c/6d4>
Trace; c0168b56 <tty_read+aa/cc>
Trace; c012c3e4 <sys_read+94/cc>
Trace; c0106b32 <system_call+32/40>
Proc;  getty
>>EIP; 7ffffffe Before first symbol   <=3D=3D=3D=3D=3D
Trace; c010fc7e <schedule_timeout+16/90>
Trace; c016c9ac <read_chan+37c/6d4>
Trace; c0168b56 <tty_read+aa/cc>
Trace; c012c3e4 <sys_read+94/cc>
Trace; c0106b32 <system_call+32/40>
Proc;  getty
>>EIP; 7ffffffe Before first symbol   <=3D=3D=3D=3D=3D
Trace; c010fc7e <schedule_timeout+16/90>
Trace; c016c9ac <read_chan+37c/6d4>
Trace; c0168b56 <tty_read+aa/cc>
Trace; c012c3e4 <sys_read+94/cc>
Trace; c0106b32 <system_call+32/40>
Proc;  getty
>>EIP; 7ffffffe Before first symbol   <=3D=3D=3D=3D=3D
Trace; c010fc7e <schedule_timeout+16/90>
Trace; c016c9ac <read_chan+37c/6d4>
Trace; c0168b56 <tty_read+aa/cc>
Trace; c012c3e4 <sys_read+94/cc>
Trace; c0106b32 <system_call+32/40>
Proc;  getty
>>EIP; 7ffffffe Before first symbol   <=3D=3D=3D=3D=3D
Trace; c010fc7e <schedule_timeout+16/90>
Trace; c016c9ac <read_chan+37c/6d4>
Trace; c0168b56 <tty_read+aa/cc>
Trace; c012c3e4 <sys_read+94/cc>
Trace; c0106b32 <system_call+32/40>
Proc;  getty
>>EIP; 7ffffffe Before first symbol   <=3D=3D=3D=3D=3D
Trace; c010fc7e <schedule_timeout+16/90>
Trace; c016c9ac <read_chan+37c/6d4>
Trace; c0168b56 <tty_read+aa/cc>
Trace; c012c3e4 <sys_read+94/cc>
Trace; c0106b32 <system_call+32/40>
Proc;  getty
>>EIP; 7ffffffe Before first symbol   <=3D=3D=3D=3D=3D
Trace; c010fc7e <schedule_timeout+16/90>
Trace; c016c9ac <read_chan+37c/6d4>
Trace; c0168b56 <tty_read+aa/cc>
Trace; c012c3e4 <sys_read+94/cc>
Trace; c0106b32 <system_call+32/40>
Proc;  getty
>>EIP; 7ffffffe Before first symbol   <=3D=3D=3D=3D=3D
Trace; c010fc7e <schedule_timeout+16/90>
Trace; c016c9ac <read_chan+37c/6d4>
Trace; c0168b56 <tty_read+aa/cc>
Trace; c012c3e4 <sys_read+94/cc>
Trace; c0106b32 <system_call+32/40>
Proc;  getty
>>EIP; 7ffffffe Before first symbol   <=3D=3D=3D=3D=3D
Trace; c010fc7e <schedule_timeout+16/90>
Trace; c016c9ac <read_chan+37c/6d4>
Trace; c0168b56 <tty_read+aa/cc>
Trace; c012c3e4 <sys_read+94/cc>
Trace; c0106b32 <system_call+32/40>
Proc;  getty
>>EIP; 7ffffffe Before first symbol   <=3D=3D=3D=3D=3D
Trace; c010fc7e <schedule_timeout+16/90>
Trace; c016c9ac <read_chan+37c/6d4>
Trace; c0168b56 <tty_read+aa/cc>
Trace; c012c3e4 <sys_read+94/cc>
Trace; c0106b32 <system_call+32/40>
Proc;  getty
>>EIP; 7ffffffe Before first symbol   <=3D=3D=3D=3D=3D
Trace; c010fc7e <schedule_timeout+16/90>
Trace; c016c9ac <read_chan+37c/6d4>
Trace; c0168b56 <tty_read+aa/cc>
Trace; c012c3e4 <sys_read+94/cc>
Trace; c0106b32 <system_call+32/40>
Proc;  getty
>>EIP; 7ffffffe Before first symbol   <=3D=3D=3D=3D=3D
Trace; c010fc7e <schedule_timeout+16/90>
Trace; c016c9ac <read_chan+37c/6d4>
Trace; c0168b56 <tty_read+aa/cc>
Trace; c012c3e4 <sys_read+94/cc>
Trace; c0106b32 <system_call+32/40>
Proc;  getty
>>EIP; 7ffffffe Before first symbol   <=3D=3D=3D=3D=3D
Trace; c010fc7e <schedule_timeout+16/90>
Trace; c016c9ac <read_chan+37c/6d4>
Trace; c0168b56 <tty_read+aa/cc>
Trace; c012c3e4 <sys_read+94/cc>
Trace; c0106b32 <system_call+32/40>
Proc;  getty
>>EIP; 7ffffffe Before first symbol   <=3D=3D=3D=3D=3D
Trace; c010fc7e <schedule_timeout+16/90>
Trace; c016c9ac <read_chan+37c/6d4>
Trace; c0168b56 <tty_read+aa/cc>
Trace; c012c3e4 <sys_read+94/cc>
Trace; c0106b32 <system_call+32/40>
Proc;  getty
>>EIP; 7ffffffe Before first symbol   <=3D=3D=3D=3D=3D
Trace; c010fc7e <schedule_timeout+16/90>
Trace; c016c9ac <read_chan+37c/6d4>
Trace; c0168b56 <tty_read+aa/cc>
Trace; c012c3e4 <sys_read+94/cc>
Trace; c0106b32 <system_call+32/40>
Proc;  getty
>>EIP; 7ffffffe Before first symbol   <=3D=3D=3D=3D=3D
Trace; c010fc7e <schedule_timeout+16/90>
Trace; c016c9ac <read_chan+37c/6d4>
Trace; c0168b56 <tty_read+aa/cc>
Trace; c012c3e4 <sys_read+94/cc>
Trace; c0106b32 <system_call+32/40>
Proc;  getty
>>EIP; 7ffffffe Before first symbol   <=3D=3D=3D=3D=3D
Trace; c010fc7e <schedule_timeout+16/90>
Trace; c016c9ac <read_chan+37c/6d4>
Trace; c0168b56 <tty_read+aa/cc>
Trace; c012c3e4 <sys_read+94/cc>
Trace; c0106b32 <system_call+32/40>
Proc;  getty
>>EIP; 7ffffffe Before first symbol   <=3D=3D=3D=3D=3D
Trace; c010fc7e <schedule_timeout+16/90>
Trace; c016c9ac <read_chan+37c/6d4>
Trace; c0168b56 <tty_read+aa/cc>
Trace; c012c3e4 <sys_read+94/cc>
Trace; c0106b32 <system_call+32/40>
Proc;  sync
>>EIP; c3ee8000 <END_OF_CODE+ce8dc2/????>   <=3D=3D=3D=3D=3D
Trace; c013c8da <__wait_on_inode+7e/a0>
Trace; c013ca9a <sync_inodes_sb+19e/1d4>
Trace; c013ccb8 <sync_inodes+34/4c>
Trace; c012d432 <fsync_dev+16/38>
Trace; c012d46a <sys_sync+6/10>
Trace; c0106b32 <system_call+32/40>


1 warning issued.  Results may not be reliable.

--T4sUOijqQbZv57TR--

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iEYEARECAAYFAjwiKygACgkQR47eFMOy/N5j3QCffdxwtAALWepbgcWEYSAt52D5
gAwAn2TOap+vxNXOXHYxgN3v3R2D9loT
=bcGu
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
