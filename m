Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVEFPnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVEFPnc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 11:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVEFPnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 11:43:32 -0400
Received: from spc2-brig1-3-0-cust232.asfd.broadband.ntl.com ([82.1.142.232]:52189
	"EHLO ppgpenguin.kenmoffat.uklinux.net") by vger.kernel.org with ESMTP
	id S261187AbVEFPmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 11:42:04 -0400
Date: Fri, 6 May 2005 16:41:57 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11.7 apparently locked with xscreensaver, 2.6.11.7
Message-ID: <Pine.LNX.4.58.0505061625250.23675@ppg_penguin.kenmoffat.uklinux.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811840-524957938-1115393652=:23675"
Content-ID: <Pine.LNX.4.58.0505061636050.23797@ppg_penguin.kenmoffat.uklinux.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811840-524957938-1115393652=:23675
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.58.0505061636051.23797@ppg_penguin.kenmoffat.uklinux.net>

Hi,

 I'm running my desktop on an athlon64 with a radeon 9200se, at the
moment this is a pure 32-bit build with X 6.8.2 and highmem (2GB of
physical memory).  Left it for a while this afternoon, when I came back
the 'hypercube' screensaver was showing (but no longer updating) and it
didn't seem to respond to either the mouse or the keyboard.  Managed to
get a trace, which follows.  Config and dmesg (gzipped) attached.

 Any suggestions on debugging this ?

Ken

May  6 16:06:23 bluesbreaker dhclient: bound to 192.168.0.79 -- renewal in =
2881 seconds.
May  6 16:11:00 bluesbreaker kernel: 100
May  6 16:11:00 bluesbreaker kernel:  [<c012e3ee>] add_wait_queue+0x3e/0x70
May  6 16:11:00 bluesbreaker kernel:  [<c0264da8>] read_chan+0x3d8/0x820
May  6 16:11:00 bluesbreaker kernel:  [<c012e4c9>] remove_wait_queue+0x39/0=
x60
May  6 16:11:00 bluesbreaker kernel:  [<c02653ae>] write_chan+0x1be/0x200
May  6 16:11:00 bluesbreaker kernel:  [<c0115100>] default_wake_function+0x=
0/0x20
May  6 16:11:00 bluesbreaker kernel:  [<c0115100>] default_wake_function+0x=
0/0x20
May  6 16:11:00 bluesbreaker kernel:  [<c025f43c>] tty_write+0x20c/0x280
May  6 16:11:00 bluesbreaker kernel:  [<c025f21d>] tty_read+0x12d/0x140
May  6 16:11:00 bluesbreaker kernel:  [<c0158ddc>] vfs_read+0x14c/0x160
May  6 16:11:00 bluesbreaker kernel:  [<c01590b1>] sys_read+0x51/0x80
May  6 16:11:00 bluesbreaker kernel:  [<c01032a9>] sysenter_past_esp+0x52/0=
x75
May  6 16:11:00 bluesbreaker kernel: agetty        S C05390A0     0  3117  =
    1          3462  3116 (NOTLB)
May  6 16:11:00 bluesbreaker kernel: f740de78 00000086 f7fbfa80 c05390a0 c0=
1190b5 00000005 00000005 f740d000
May  6 16:11:00 bluesbreaker kernel:        00000020 ffffffff f7748126 0000=
1d25 a0f16a18 00000016 f7fbfbd0 f7eff000
May  6 16:11:00 bluesbreaker kernel:        7fffffff f740d000 f7440440 c03f=
f4b9 b7f7a000 f740dea8 f77b2eac 0000b770
May  6 16:11:00 bluesbreaker kernel: Call Trace:
May  6 16:11:00 bluesbreaker kernel:  [<c01190b5>] release_console_sem+0x95=
/0x100
May  6 16:11:00 bluesbreaker kernel:  [<c03ff4b9>] schedule_timeout+0xa9/0x=
b0
May  6 16:11:00 bluesbreaker kernel:  [<c01190b5>] release_console_sem+0x95=
/0x100
May  6 16:11:00 bluesbreaker kernel:  [<c012e3ee>] add_wait_queue+0x3e/0x70
May  6 16:11:00 bluesbreaker kernel:  [<c0264da8>] read_chan+0x3d8/0x820
May  6 16:11:00 bluesbreaker kernel:  [<c012e4c9>] remove_wait_queue+0x39/0=
x60
May  6 16:11:00 bluesbreaker kernel:  [<c02653ae>] write_chan+0x1be/0x200
May  6 16:11:00 bluesbreaker kernel:  [<c0115100>] default_wake_function+0x=
0/0x20
May  6 16:11:00 bluesbreaker kernel:  [<c0115100>] default_wake_function+0x=
0/0x20
May  6 16:11:00 bluesbreaker kernel:  [<c025f43c>] tty_write+0x20c/0x280
May  6 16:11:00 bluesbreaker kernel:  [<c025f21d>] tty_read+0x12d/0x140
May  6 16:11:00 bluesbreaker kernel:  [<c0158ddc>] vfs_read+0x14c/0x160
May  6 16:11:00 bluesbreaker kernel:  [<c01590b1>] sys_read+0x51/0x80
May  6 16:11:00 bluesbreaker kernel:  [<c01032a9>] sysenter_past_esp+0x52/0=
x75
May  6 16:11:00 bluesbreaker kernel: gdm-binary    S C05390A0     0  3294  =
 3105  3319               (NOTLB)
May  6 16:11:00 bluesbreaker kernel: f76b4eb0 00000082 f76c8ac0 c05390a0 00=
000001 00000000 00000000 00000001
May  6 16:11:00 bluesbreaker kernel:        00000000 f76c8ac0 f6b6fac0 0000=
065e 3cec8739 000000ff f76c8c10 00000000
May  6 16:11:00 bluesbreaker kernel:        7fffffff 0000000a 0000000a c03f=
f4b9 00000009 c012e3ee f7f89000 f76d1954
May  6 16:11:00 bluesbreaker kernel: Call Trace:
May  6 16:11:00 bluesbreaker kernel:  [<c03ff4b9>] schedule_timeout+0xa9/0x=
b0
May  6 16:11:00 bluesbreaker kernel:  [<c012e3ee>] add_wait_queue+0x3e/0x70
May  6 16:11:00 bluesbreaker kernel:  [<c01668c0>] pipe_poll+0xc0/0xd0
May  6 16:11:00 bluesbreaker kernel:  [<c016d7a7>] do_select+0x297/0x2e0
May  6 16:11:00 bluesbreaker kernel:  [<c016d340>] __pollwait+0x0/0xd0
May  6 16:11:00 bluesbreaker kernel:  [<c016da9d>] sys_select+0x26d/0x4e0
May  6 16:11:00 bluesbreaker kernel:  [<c01032a9>] sysenter_past_esp+0x52/0=
x75
May  6 16:11:00 bluesbreaker kernel: X             R running     0  3319   =
3294          3381       (NOTLB)
May  6 16:11:00 bluesbreaker kernel: Xclients      S C05390A0     0  3381  =
 3294  3396          3319 (NOTLB)
May  6 16:11:00 bluesbreaker kernel: f6fd9f1c 00000082 f7fbf0a0 c05390a0 f7=
f7d284 f7fbf0a0 c01130b9 f74ac940
May  6 16:11:00 bluesbreaker kernel:        f7f7d284 b7fe2ba1 f7e0c0e0 0000=
22ac 12aa128d 0000001a f7fbf1f0 f6fd9000
May  6 16:11:00 bluesbreaker kernel:        f7fbf0a0 fffffe00 00000001 c011=
c8a0 ffffffff 00000004 f7e0c0e0 f6fd9f50
May  6 16:11:00 bluesbreaker kernel: Call Trace:
May  6 16:11:00 bluesbreaker kernel:  [<c01130b9>] do_page_fault+0x1c9/0x5d=
e
May  6 16:11:00 bluesbreaker kernel:  [<c011c8a0>] do_wait+0x300/0x4b0
May  6 16:11:00 bluesbreaker kernel:  [<c0114838>] wake_up_new_task+0x168/0=
x180
May  6 16:11:00 bluesbreaker kernel:  [<c0115100>] default_wake_function+0x=
0/0x20
May  6 16:11:00 bluesbreaker kernel:  [<c0115100>] default_wake_function+0x=
0/0x20
May  6 16:11:00 bluesbreaker kernel:  [<c011cb3f>] sys_wait4+0x3f/0x50
May  6 16:11:00 bluesbreaker kernel:  [<c011cb77>] sys_waitpid+0x27/0x2b
May  6 16:11:00 bluesbreaker kernel:  [<c01032a9>] sysenter_past_esp+0x52/0=
x75
May  6 16:11:00 bluesbreaker kernel: ssh-agent     S C05390A0     0  3396  =
 3381          3397       (NOTLB)
May  6 16:11:00 bluesbreaker kernel: f6947eb0 00000086 f7e0c5d0 c05390a0 00=
000001 00000000 f7e0c5d0 00000010
May  6 16:11:00 bluesbreaker kernel:        c0469b8c 000000d0 f76c85d0 0000=
053c 1c5cca67 0000059f f7e0c720 00000000
May  6 16:11:00 bluesbreaker kernel:        7fffffff 00000004 00000004 c03f=
f4b9 f6947f40 00000003 c03e45a1 f74c9580
May  6 16:11:00 bluesbreaker kernel: Call Trace:
May  6 16:11:00 bluesbreaker kernel:  [<c03ff4b9>] schedule_timeout+0xa9/0x=
b0
May  6 16:11:00 bluesbreaker kernel:  [<c03e45a1>] unix_poll+0xb1/0xc0
May  6 16:11:00 bluesbreaker kernel:  [<c0378df6>] sock_poll+0x26/0x30
May  6 16:11:00 bluesbreaker kernel:  [<c016d7a7>] do_select+0x297/0x2e0
May  6 16:11:00 bluesbreaker kernel:  [<c016d340>] __pollwait+0x0/0xd0
May  6 16:11:00 bluesbreaker kernel:  [<c016da9d>] sys_select+0x26d/0x4e0
May  6 16:11:00 bluesbreaker kernel:  [<c01032a9>] sysenter_past_esp+0x52/0=
x75
May  6 16:11:00 bluesbreaker kernel: sh            S C05390A0     0  3397  =
 3381  3411          3396 (NOTLB)
May  6 16:11:00 bluesbreaker kernel: f6940f1c 00000086 f7e0c0e0 c05390a0 f7=
ebe754 f7e0c0e0 c01130b9 f74acdc0
May  6 16:11:00 bluesbreaker kernel:        f7ebe754 080c40dc 00000001 0000=
f357 178ca11f 0000001a f7e0c230 f6940000
May  6 16:11:00 bluesbreaker kernel:        f7e0c0e0 fffffe00 00000001 c011=
c8a0 ffffffff 00000004 f743aa00 f6940f50
May  6 16:11:00 bluesbreaker kernel: Call Trace:
May  6 16:11:00 bluesbreaker kernel:  [<c01130b9>] do_page_fault+0x1c9/0x5d=
e
May  6 16:11:00 bluesbreaker kernel:  [<c011c8a0>] do_wait+0x300/0x4b0
May  6 16:11:00 bluesbreaker kernel:  [<c0114838>] wake_up_new_task+0x168/0=
x180
May  6 16:11:00 bluesbreaker kernel:  [<c0115100>] default_wake_function+0x=
0/0x20
May  6 16:11:00 bluesbreaker kernel:  [<c0115100>] default_wake_function+0x=
0/0x20
May  6 16:11:00 bluesbreaker kernel:  [<c011cb3f>] sys_wait4+0x3f/0x50
May  6 16:11:00 bluesbreaker kernel:  [<c011cb77>] sys_waitpid+0x27/0x2b
May  6 16:11:00 bluesbreaker kernel:  [<c01032a9>] sysenter_past_esp+0x52/0=
x75
May  6 16:11:00 bluesbreaker kernel: xterm         S C05390A0     0  3411  =
 3397  3415    3412       (NOTLB)
May  6 16:11:00 bluesbreaker kernel: f695deb0 00000082 f743a510 c05390a0 00=
000001 00000000 f743a510 00000010
May  6 16:11:00 bluesbreaker kernel:        c0469b8c 000000d0 f76c85d0 0000=
059d 57980236 00000452 f743a660 00000000
May  6 16:11:00 bluesbreaker kernel:        7fffffff 00000004 00000004 c03f=
f4b9 f695df40 00000003 c03e45a1 f7fc3600
May  6 16:11:00 bluesbreaker kernel: Call Trace:
May  6 16:11:00 bluesbreaker kernel:  [<c03ff4b9>] schedule_timeout+0xa9/0x=
b0
May  6 16:11:00 bluesbreaker kernel:  [<c03e45a1>] unix_poll+0xb1/0xc0
May  6 16:11:00 bluesbreaker kernel:  [<c0378df6>] sock_poll+0x26/0x30
May  6 16:11:00 bluesbreaker kernel:  [<c016d7a7>] do_select+0x297/0x2e0
May  6 16:11:00 bluesbreaker kernel:  [<c016d340>] __pollwait+0x0/0xd0
May  6 16:11:00 bluesbreaker kernel:  [<c016da9d>] sys_select+0x26d/0x4e0
May  6 16:11:00 bluesbreaker kernel:  [<c01032a9>] sysenter_past_esp+0x52/0=
x75
May  6 16:11:00 bluesbreaker kernel: xscreensaver  S C05390A0     0  3412  =
 3397  3713    3413  3411 (NOTLB)
May  6 16:11:00 bluesbreaker kernel: f6fe5eb0 00000082 f76c80e0 c05390a0 00=
000001 00000000 f76c80e0 00000010
May  6 16:11:00 bluesbreaker kernel:        c0469b8c 000000d0 f76c85d0 0000=
0450 75f99bfd 00000412 f76c8230 00000000
May  6 16:11:00 bluesbreaker kernel:        7fffffff 00000004 00000004 c03f=
f4b9 f6fe5f40 00000003 c03e45a1 f7fc3840
May  6 16:11:00 bluesbreaker kernel: Call Trace:
May  6 16:11:00 bluesbreaker kernel:  [<c03ff4b9>] schedule_timeout+0xa9/0x=
b0
May  6 16:11:00 bluesbreaker kernel:  [<c03e45a1>] unix_poll+0xb1/0xc0
May  6 16:11:00 bluesbreaker kernel:  [<c0378df6>] sock_poll+0x26/0x30
May  6 16:11:00 bluesbreaker kernel:  [<c016d7a7>] do_select+0x297/0x2e0
May  6 16:11:00 bluesbreaker kernel:  [<c016d340>] __pollwait+0x0/0xd0
May  6 16:11:00 bluesbreaker kernel:  [<c016da9d>] sys_select+0x26d/0x4e0
May  6 16:11:00 bluesbreaker kernel:  [<c01032a9>] sysenter_past_esp+0x52/0=
x75
May  6 16:11:00 bluesbreaker kernel: icewm         S C05390A0     0  3413  =
 3397  3431          3412 (NOTLB)
May  6 16:11:00 bluesbreaker kernel: f6962eb0 00000082 f743aa00 c05390a0 00=
000001 00000000 f743aa00 00000010
May  6 16:11:00 bluesbreaker kernel:        c0469b8c 000000d0 f76c85d0 0000=
17cd 531217c9 00000423 f743ab50 00000000
May  6 16:11:00 bluesbreaker kernel:        7fffffff 00000006 00000006 c03f=
f4b9 f6962f40 00000005 c03e45a1 f7405040
May  6 16:11:00 bluesbreaker kernel: Call Trace:
May  6 16:11:00 bluesbreaker kernel:  [<c03ff4b9>] schedule_timeout+0xa9/0x=
b0
May  6 16:11:00 bluesbreaker kernel:  [<c03e45a1>] unix_poll+0xb1/0xc0
May  6 16:11:00 bluesbreaker kernel:  [<c0378df6>] sock_poll+0x26/0x30
May  6 16:11:00 bluesbreaker kernel:  [<c016d7a7>] do_select+0x297/0x2e0
May  6 16:11:00 bluesbreaker kernel:  [<c016d340>] __pollwait+0x0/0xd0
May  6 16:11:00 bluesbreaker kernel:  [<c016da9d>] sys_select+0x26d/0x4e0
May  6 16:11:00 bluesbreaker kernel:  [<c01032a9>] sysenter_past_esp+0x52/0=
x75
May  6 16:11:00 bluesbreaker kernel: bash          S C05390D0     0  3415  =
 3411                     (NOTLB)
May  6 16:11:00 bluesbreaker kernel: f69b5e78 00000082 f76c85d0 c05390d0 00=
0001d6 f65352dc bffeb000 c0000000
May  6 16:11:00 bluesbreaker kernel:        67aea52d 000001d6 f76c85d0 0000=
13fe 67af7bda 000001d6 f69aa6a0 f699b000
May  6 16:11:00 bluesbreaker kernel:        7fffffff f69b5000 f7ee5d40 c03f=
f4b9 f699b000 f69b5e98 c1f71be0 00000000
May  6 16:11:00 bluesbreaker kernel: Call Trace:
May  6 16:11:00 bluesbreaker kernel:  [<c03ff4b9>] schedule_timeout+0xa9/0x=
b0
May  6 16:11:00 bluesbreaker kernel:  [<c0147555>] do_wp_page+0x295/0x3b0
May  6 16:11:00 bluesbreaker kernel:  [<c012e3ee>] add_wait_queue+0x3e/0x70
May  6 16:11:00 bluesbreaker kernel:  [<c0264da8>] read_chan+0x3d8/0x820
May  6 16:11:00 bluesbreaker kernel:  [<c012e4c9>] remove_wait_queue+0x39/0=
x60
May  6 16:11:00 bluesbreaker kernel:  [<c02653ae>] write_chan+0x1be/0x200
May  6 16:11:00 bluesbreaker kernel:  [<c0115100>] default_wake_function+0x=
0/0x20
May  6 16:11:00 bluesbreaker kernel:  [<c0115100>] default_wake_function+0x=
0/0x20
May  6 16:11:00 bluesbreaker kernel:  [<c025f43c>] tty_write+0x20c/0x280
May  6 16:11:00 bluesbreaker kernel:  [<c025f21d>] tty_read+0x12d/0x140
May  6 16:11:00 bluesbreaker kernel:  [<c0158ddc>] vfs_read+0x14c/0x160
May  6 16:11:00 bluesbreaker kernel:  [<c01590b1>] sys_read+0x51/0x80
May  6 16:11:00 bluesbreaker kernel:  [<c01032a9>] sysenter_past_esp+0x52/0=
x75
May  6 16:11:00 bluesbreaker kernel: xterm         S C05390A0     0  3431  =
 3413  3432    3445       (NOTLB)
May  6 16:11:00 bluesbreaker kernel: f7e2beb0 00000082 f69aa060 c05390a0 00=
000000 00000092 00000001 f7e2beb4
May  6 16:11:00 bluesbreaker kernel:        c01151d5 00000000 f76c85d0 0000=
0254 43c80ce3 000005a0 f69aa1b0 008c0646
May  6 16:11:00 bluesbreaker kernel:        f7e2bec4 00000005 00000005 c03f=
f46d f7e2bec4 008c0646 f693f000 c053ef18
May  6 16:11:00 bluesbreaker kernel: Call Trace:
May  6 16:11:00 bluesbreaker kernel:  [<c01151d5>] __wake_up+0x55/0x80
May  6 16:11:00 bluesbreaker kernel:  [<c03ff46d>] schedule_timeout+0x5d/0x=
b0
May  6 16:11:00 bluesbreaker kernel:  [<c0122940>] process_timeout+0x0/0x10
May  6 16:11:00 bluesbreaker kernel:  [<c016d7a7>] do_select+0x297/0x2e0
May  6 16:11:00 bluesbreaker kernel:  [<c016d340>] __pollwait+0x0/0xd0
May  6 16:11:00 bluesbreaker kernel:  [<c016da9d>] sys_select+0x26d/0x4e0
May  6 16:11:00 bluesbreaker kernel:  [<c01032a9>] sysenter_past_esp+0x52/0=
x75
May  6 16:11:00 bluesbreaker kernel: bash          S C05390A0     0  3432  =
 3431  3484               (NOTLB)
May  6 16:11:00 bluesbreaker kernel: f7e34f1c 00000086 f69aaa40 c05390a0 f6=
9af8b4 f69aaa40 c01130b9 f74ac700
May  6 16:11:00 bluesbreaker kernel:        f69af8b4 080c9f58 00000001 0000=
3684 812ec102 0000003b f69aab90 f7e34000
May  6 16:11:00 bluesbreaker kernel:        f69aaa40 fffffe00 00000001 c011=
c8a0 f6479060 00000000 00000000 bffff828
May  6 16:11:00 bluesbreaker kernel: Call Trace:
May  6 16:11:00 bluesbreaker kernel:  [<c01130b9>] do_page_fault+0x1c9/0x5d=
e
May  6 16:11:00 bluesbreaker kernel:  [<c011c8a0>] do_wait+0x300/0x4b0
May  6 16:11:00 bluesbreaker kernel:  [<c0115100>] default_wake_function+0x=
0/0x20
May  6 16:11:00 bluesbreaker kernel:  [<c0115100>] default_wake_function+0x=
0/0x20
May  6 16:11:00 bluesbreaker kernel:  [<c02161f2>] copy_to_user+0x42/0x60
May  6 16:11:00 bluesbreaker kernel:  [<c011cb3f>] sys_wait4+0x3f/0x50
May  6 16:11:00 bluesbreaker kernel:  [<c011cb77>] sys_waitpid+0x27/0x2b
May  6 16:11:00 bluesbreaker kernel:  [<c01032a9>] sysenter_past_esp+0x52/0=
x75
May  6 16:11:00 bluesbreaker kernel: firefox       S C05390A0     0  3445  =
 3413  3452    3492  3431 (NOTLB)
May  6 16:11:00 bluesbreaker kernel: f69fff1c 00000082 f6a06a00 c05390a0 f6=
9fdb74 f6a06a00 c01130b9 f7e75280
May  6 16:11:00 bluesbreaker kernel:        f69fdb74 080c40dc 00000001 0000=
3a2f d17664f4 0000001e f6a06b50 f69ff000
May  6 16:11:00 bluesbreaker kernel:        f6a06a00 fffffe00 00000001 c011=
c8a0 ffffffff 00000004 f6a06510 f69fff50
May  6 16:11:00 bluesbreaker kernel: Call Trace:
May  6 16:11:00 bluesbreaker kernel:  [<c01130b9>] do_page_fault+0x1c9/0x5d=
e
May  6 16:11:00 bluesbreaker kernel:  [<c011c8a0>] do_wait+0x300/0x4b0
May  6 16:11:00 bluesbreaker kernel:  [<c0114838>] wake_up_new_task+0x168/0=
x180
May  6 16:11:00 bluesbreaker kernel:  [<c0115100>] default_wake_function+0x=
0/0x20
May  6 16:11:00 bluesbreaker kernel:  [<c0115100>] default_wake_function+0x=
0/0x20
May  6 16:11:00 bluesbreaker kernel:  [<c011cb3f>] sys_wait4+0x3f/0x50
May  6 16:11:00 bluesbreaker kernel:  [<c011cb77>] sys_waitpid+0x27/0x2b
May  6 16:11:00 bluesbreaker kernel:  [<c01032a9>] sysenter_past_esp+0x52/0=
x75
May  6 16:11:00 bluesbreaker kernel: run-mozilla.s S C05390A0     0  3452  =
 3445  3457               (NOTLB)
May  6 16:11:00 bluesbreaker kernel: f69f5f1c 00000082 f6a06510 c05390a0 f6=
9ac59c f6a06510 c01130b9 f7ebb280
May  6 16:11:00 bluesbreaker kernel:        f69ac59c 080c40dc 00000001 0000=
3c47 d6681068 0000001e f6a06660 f69f5000
May  6 16:11:00 bluesbreaker kernel:        f6a06510 fffffe00 00000001 c011=
c8a0 ffffffff 00000004 f6a06020 f69f5f50
May  6 16:11:00 bluesbreaker kernel: Call Trace:
May  6 16:11:00 bluesbreaker kernel:  [<c01130b9>] do_page_fault+0x1c9/0x5d=
e
May  6 16:11:00 bluesbreaker kernel:  [<c011c8a0>] do_wait+0x300/0x4b0
May  6 16:11:00 bluesbreaker kernel:  [<c0114838>] wake_up_new_task+0x168/0=
x180
May  6 16:11:00 bluesbreaker kernel:  [<c0115100>] default_wake_function+0x=
0/0x20
May  6 16:11:00 bluesbreaker kernel:  [<c0115100>] default_wake_function+0x=
0/0x20
May  6 16:11:00 bluesbreaker kernel:  [<c011cb3f>] sys_wait4+0x3f/0x50
May  6 16:11:00 bluesbreaker kernel:  [<c011cb77>] sys_waitpid+0x27/0x2b
May  6 16:11:00 bluesbreaker kernel:  [<c01032a9>] sysenter_past_esp+0x52/0=
x75
May  6 16:11:00 bluesbreaker kernel: firefox-bin   S C05390A0     0  3457  =
 3452          3460       (NOTLB)
May  6 16:11:00 bluesbreaker kernel: f6a04f10 00000082 f6a06020 c05390a0 00=
000000 f6a44940 f6a04fa0 f6a16c58
May  6 16:11:00 bluesbreaker kernel:        c013c497 c16ff1c0 f76c85d0 0000=
0ac5 6220dcc9 000005a0 f6a06170 00000000
May  6 16:11:00 bluesbreaker kernel:        7fffffff f6a04f64 f6a04f68 c03f=
f4b9 f74c8400 f6a04fa0 00000145 f74d5e40
May  6 16:11:00 bluesbreaker kernel: Call Trace:
May  6 16:11:00 bluesbreaker kernel:  [<c013c497>] __get_free_pages+0x27/0x=
40
May  6 16:11:00 bluesbreaker kernel:  [<c03ff4b9>] schedule_timeout+0xa9/0x=
b0
May  6 16:11:00 bluesbreaker kernel:  [<c016dd5d>] do_pollfd+0x4d/0x90
May  6 16:11:00 bluesbreaker kernel:  [<c016de47>] do_poll+0xa7/0xd0
May  6 16:11:00 bluesbreaker kernel:  [<c016e03f>] sys_poll+0x1cf/0x220
May  6 16:11:00 bluesbreaker kernel:  [<c016cd68>] sys_ioctl+0x68/0x70
May  6 16:11:00 bluesbreaker kernel:  [<c016d340>] __pollwait+0x0/0xd0
May  6 16:11:00 bluesbreaker kernel:  [<c01032a9>] sysenter_past_esp+0x52/0=
x75
May  6 16:11:00 bluesbreaker kernel: firefox-bin   S C05390A0     0  3460  =
 3452          3464  3457 (NOTLB)
May  6 16:11:00 bluesbreaker kernel: f6a48f10 00000082 f6a30550 c05390a0 c0=
469b8c 000000d0 f76d14c4 00000000
May  6 16:11:00 bluesbreaker kernel:        f6a56740 f6a48fa0 f76c85d0 0000=
0468 8e6d10cb 0000059d f6a306a0 00000000
May  6 16:11:00 bluesbreaker kernel:        7fffffff f6a48f64 f6a48f68 c03f=
f4b9 f74c8200 f6a48fa0 00000145 f69b0868
May  6 16:11:00 bluesbreaker kernel: Call Trace:
May  6 16:11:00 bluesbreaker kernel:  [<c03ff4b9>] schedule_timeout+0xa9/0x=
b0
May  6 16:11:00 bluesbreaker kernel:  [<c016dd5d>] do_pollfd+0x4d/0x90
May  6 16:11:00 bluesbreaker kernel:  [<c016de47>] do_poll+0xa7/0xd0
May  6 16:11:00 bluesbreaker kernel:  [<c016e03f>] sys_poll+0x1cf/0x220
May  6 16:11:00 bluesbreaker kernel:  [<c016d340>] __pollwait+0x0/0xd0
May  6 16:11:00 bluesbreaker kernel:  [<c01032a9>] sysenter_past_esp+0x52/0=
x75
May  6 16:11:00 bluesbreaker kernel: firefox-bin   S C05390D0     0  3464  =
 3452          3477  3460 (NOTLB)
May  6 16:11:00 bluesbreaker kernel: f6b1de94 00000082 f6a06020 c05390d0 00=
0005a0 000005a0 f6b1de84 c01144d4
May  6 16:11:00 bluesbreaker kernel:        62206a14 000005a0 f6a06020 0000=
02f7 6220710f 000005a0 f6b1cbd0 008c05a5
May  6 16:11:00 bluesbreaker kernel:        f6b1dea8 0001184d f6b1d000 c03f=
f46d f6b1dea8 008c05a5 f74c8400 f7c8519c
May  6 16:11:00 bluesbreaker kernel: Call Trace:
May  6 16:11:00 bluesbreaker kernel:  [<c01144d4>] activate_task+0x64/0x80
May  6 16:11:00 bluesbreaker kernel:  [<c03ff46d>] schedule_timeout+0x5d/0x=
b0
May  6 16:11:00 bluesbreaker kernel:  [<c0122940>] process_timeout+0x0/0x10
May  6 16:11:00 bluesbreaker kernel:  [<c012f4a3>] futex_wait+0x163/0x1f0
May  6 16:11:00 bluesbreaker kernel:  [<c0115100>] default_wake_function+0x=
0/0x20
May  6 16:11:00 bluesbreaker kernel:  [<c0115100>] default_wake_function+0x=
0/0x20
May  6 16:11:00 bluesbreaker kernel:  [<c012f864>] do_futex+0x74/0xd0
May  6 16:11:00 bluesbreaker kernel:  [<c012f939>] sys_futex+0x79/0x110
May  6 16:11:00 bluesbreaker kernel:  [<c01032a9>] sysenter_past_esp+0x52/0=
x75
May  6 16:11:00 bluesbreaker kernel: firefox-bin   S C05390D0     0  3477  =
 3452                3464 (NOTLB)
May  6 16:11:00 bluesbreaker kernel: f6b37f10 00000082 f76c80e0 c05390d0 00=
000358 000000d0 f6aaf074 00000000
May  6 16:11:00 bluesbreaker kernel:        18cc2873 00000358 f76c80e0 0000=
14fa 18cd4698 00000358 f6b6f230 00000000
May  6 16:11:00 bluesbreaker kernel:        7fffffff f6b37f64 f6b37f68 c03f=
f4b9 f6ab1c00 f6b37fa0 00000145 f69b0588
May  6 16:11:00 bluesbreaker kernel: Call Trace:
May  6 16:11:00 bluesbreaker kernel:  [<c03ff4b9>] schedule_timeout+0xa9/0x=
b0
May  6 16:11:00 bluesbreaker kernel:  [<c016dd5d>] do_pollfd+0x4d/0x90
May  6 16:11:00 bluesbreaker kernel:  [<c016de47>] do_poll+0xa7/0xd0
May  6 16:11:00 bluesbreaker kernel:  [<c016e03f>] sys_poll+0x1cf/0x220
May  6 16:11:00 bluesbreaker kernel:  [<c016d340>] __pollwait+0x0/0xd0
May  6 16:11:00 bluesbreaker kernel:  [<c011cb77>] sys_waitpid+0x27/0x2b
May  6 16:11:00 bluesbreaker kernel:  [<c01032a9>] sysenter_past_esp+0x52/0=
x75
May  6 16:11:00 bluesbreaker kernel: gconfd-2      S C05390A0     0  3462  =
    1                3117 (NOTLB)
May  6 16:11:00 bluesbreaker kernel: f6acef10 00000082 f6a30060 c05390a0 c0=
469b8c 000000d0 00000040 00000000
May  6 16:11:00 bluesbreaker kernel:        f6adb5c0 00000000 f76c85d0 0000=
0a36 5a998d1c 0000059d f6a301b0 008c46a3
May  6 16:11:00 bluesbreaker kernel:        f6acef24 f6acef64 f6acef68 c03f=
f46d f6acef24 008c46a3 f6ac1e40 f7f1b63c
May  6 16:11:00 bluesbreaker kernel: Call Trace:
May  6 16:11:00 bluesbreaker kernel:  [<c03ff46d>] schedule_timeout+0x5d/0x=
b0
May  6 16:11:00 bluesbreaker kernel:  [<c0122940>] process_timeout+0x0/0x10
May  6 16:11:00 bluesbreaker kernel:  [<c016de47>] do_poll+0xa7/0xd0
May  6 16:11:00 bluesbreaker kernel:  [<c016e03f>] sys_poll+0x1cf/0x220
May  6 16:11:00 bluesbreaker kernel:  [<c011d49b>] sys_gettimeofday+0x3b/0x=
80
May  6 16:11:00 bluesbreaker kernel:  [<c016d340>] __pollwait+0x0/0xd0
May  6 16:11:00 bluesbreaker kernel:  [<c01032a9>] sysenter_past_esp+0x52/0=
x75
May  6 16:11:00 bluesbreaker kernel: vim           S C05390D0     0  3484  =
 3432                     (NOTLB)
May  6 16:11:00 bluesbreaker kernel: f6b1aeb0 00000082 f69aa060 c05390d0 00=
000349 00000092 00000001 f6b1aeb4
May  6 16:11:00 bluesbreaker kernel:        820e492d 00000349 f69aa060 0000=
1147 820e492d 00000349 f64791b0 00000000
May  6 16:11:00 bluesbreaker kernel:        7fffffff 00000001 00000001 c03f=
f4b9 c025e235 00000000 f6fc5000 f6fc500c
May  6 16:11:00 bluesbreaker kernel: Call Trace:
May  6 16:11:00 bluesbreaker kernel:  [<c03ff4b9>] schedule_timeout+0xa9/0x=
b0
May  6 16:11:00 bluesbreaker kernel:  [<c025e235>] tty_ldisc_deref+0x35/0xa=
0
May  6 16:11:00 bluesbreaker kernel:  [<c0260b9b>] tty_poll+0x8b/0xf0
May  6 16:11:00 bluesbreaker kernel:  [<c0159f0b>] fget+0x4b/0x70
May  6 16:11:00 bluesbreaker kernel:  [<c016d7a7>] do_select+0x297/0x2e0
May  6 16:11:00 bluesbreaker kernel:  [<c016d340>] __pollwait+0x0/0xd0
May  6 16:11:00 bluesbreaker kernel:  [<c016da9d>] sys_select+0x26d/0x4e0
May  6 16:11:00 bluesbreaker kernel:  [<c01032a9>] sysenter_past_esp+0x52/0=
x75
May  6 16:11:00 bluesbreaker kernel: xterm         S C05390A0     0  3492  =
 3413  3493          3445 (NOTLB)
May  6 16:11:00 bluesbreaker kernel: f6a31eb0 00000082 f6b6fac0 c05390a0 00=
000000 00000092 00000001 f6a31eb4
May  6 16:11:00 bluesbreaker kernel:        c01151d5 00000000 f76c85d0 0000=
0382 6a74f470 000005a0 f6b6fc10 008c08d0
May  6 16:11:00 bluesbreaker kernel:        f6a31ec4 00000005 00000005 c03f=
f46d f6a31ec4 008c08d0 f6b39000 c053ef28
May  6 16:11:00 bluesbreaker kernel: Call Trace:
May  6 16:11:00 bluesbreaker kernel:  [<c01151d5>] __wake_up+0x55/0x80
May  6 16:11:00 bluesbreaker kernel:  [<c03ff46d>] schedule_timeout+0x5d/0x=
b0
May  6 16:11:00 bluesbreaker kernel:  [<c0122940>] process_timeout+0x0/0x10
May  6 16:11:00 bluesbreaker kernel:  [<c016d7a7>] do_select+0x297/0x2e0
May  6 16:11:00 bluesbreaker kernel:  [<c016d340>] __pollwait+0x0/0xd0
May  6 16:11:00 bluesbreaker kernel:  [<c016da9d>] sys_select+0x26d/0x4e0
May  6 16:11:00 bluesbreaker kernel:  [<c01032a9>] sysenter_past_esp+0x52/0=
x75
May  6 16:11:00 bluesbreaker kernel: bash          S C05390D0     0  3493  =
 3492  3506               (NOTLB)
May  6 16:11:00 bluesbreaker kernel: f64b5f1c 00000082 f6b6fac0 c05390d0 00=
000100 f6b6f5d0 c01130b9 f7f9f040
May  6 16:11:00 bluesbreaker kernel:        441b83a0 00000100 f6b6fac0 0000=
35d1 44200d02 00000100 f6b6f720 f64b5000
May  6 16:11:00 bluesbreaker kernel:        f6b6f5d0 fffffe00 00000001 c011=
c8a0 f650fa80 00000000 00000000 bffff828
May  6 16:11:00 bluesbreaker kernel: Call Trace:
May  6 16:11:00 bluesbreaker kernel:  [<c01130b9>] do_page_fault+0x1c9/0x5d=
e
May  6 16:11:00 bluesbreaker kernel:  [<c011c8a0>] do_wait+0x300/0x4b0
May  6 16:11:00 bluesbreaker kernel:  [<c0115100>] default_wake_function+0x=
0/0x20
May  6 16:11:00 bluesbreaker kernel:  [<c0115100>] default_wake_function+0x=
0/0x20
May  6 16:11:00 bluesbreaker kernel:  [<c02161f2>] copy_to_user+0x42/0x60
May  6 16:11:00 bluesbreaker kernel:  [<c011cb3f>] sys_wait4+0x3f/0x50
May  6 16:11:00 bluesbreaker kernel:  [<c011cb77>] sys_waitpid+0x27/0x2b
May  6 16:11:00 bluesbreaker kernel:  [<c01032a9>] sysenter_past_esp+0x52/0=
x75
May  6 16:11:00 bluesbreaker kernel: ssh           S C05390A0     0  3506  =
 3493                     (NOTLB)
May  6 16:11:00 bluesbreaker kernel: f653ceb0 00000086 f650fa80 c05390a0 00=
000000 00000092 00000001 f653ceb4
May  6 16:11:00 bluesbreaker kernel:        c01151d5 c04acd4c 00000003 0000=
00a9 df1aa98b 00000355 f650fbd0 00000000
May  6 16:11:00 bluesbreaker kernel:        7fffffff 00000005 00000005 c03f=
f4b9 c025e235 00000000 f646c000 f646c00c
May  6 16:11:00 bluesbreaker kernel: Call Trace:
May  6 16:11:00 bluesbreaker kernel:  [<c01151d5>] __wake_up+0x55/0x80
May  6 16:11:00 bluesbreaker kernel:  [<c03ff4b9>] schedule_timeout+0xa9/0x=
b0
May  6 16:11:00 bluesbreaker kernel:  [<c025e235>] tty_ldisc_deref+0x35/0xa=
0
May  6 16:11:00 bluesbreaker kernel:  [<c0260b9b>] tty_poll+0x8b/0xf0
May  6 16:11:00 bluesbreaker kernel:  [<c0159f0b>] fget+0x4b/0x70
May  6 16:11:00 bluesbreaker kernel:  [<c016d7a7>] do_select+0x297/0x2e0
May  6 16:11:00 bluesbreaker kernel:  [<c016d340>] __pollwait+0x0/0xd0
May  6 16:11:00 bluesbreaker kernel:  [<c016da9d>] sys_select+0x26d/0x4e0
May  6 16:11:00 bluesbreaker kernel:  [<c01032a9>] sysenter_past_esp+0x52/0=
x75
May  6 16:11:00 bluesbreaker kernel: pickup        S C05390A0     0  3628  =
 3085                3088 (NOTLB)
May  6 16:11:00 bluesbreaker kernel: f7f36eb0 00000082 f7fd45d0 c05390a0 00=
00059b 00000000 f7fd45d0 00000010
May  6 16:11:00 bluesbreaker kernel:        2dd38640 00000000 f76c85d0 0000=
005b 2dd44393 0000059b f7fd4720 008d3384
May  6 16:11:00 bluesbreaker kernel:        f7f36ec4 00000007 00000007 c03f=
f46d f7f36ec4 008d3384 f7f3f200 c053f288
May  6 16:11:00 bluesbreaker kernel: Call Trace:
May  6 16:11:00 bluesbreaker kernel:  [<c03ff46d>] schedule_timeout+0x5d/0x=
b0
May  6 16:11:00 bluesbreaker kernel:  [<c0122940>] process_timeout+0x0/0x10
May  6 16:11:00 bluesbreaker kernel:  [<c016d7a7>] do_select+0x297/0x2e0
May  6 16:11:00 bluesbreaker kernel:  [<c016d340>] __pollwait+0x0/0xd0
May  6 16:11:00 bluesbreaker kernel:  [<c016da9d>] sys_select+0x26d/0x4e0
May  6 16:11:00 bluesbreaker kernel:  [<c011d3bb>] sys_time+0x1b/0x60
May  6 16:11:00 bluesbreaker kernel:  [<c01032a9>] sysenter_past_esp+0x52/0=
x75
May  6 16:11:00 bluesbreaker kernel: hypercube     S C05390A0     0  3713  =
 3412                     (NOTLB)
May  6 16:11:00 bluesbreaker kernel: f640deb0 00000086 f6a30a40 c05390a0 00=
000001 00000000 f6a30a40 00000010
May  6 16:11:00 bluesbreaker kernel:        c0469b8c 000000d0 f76c85d0 0000=
04ba 40751bda 0000074a f6a30b90 00000000
May  6 16:11:00 bluesbreaker kernel:        7fffffff 00000004 00000004 c03f=
f4b9 f640df40 00000003 c03e45a1 f6ac1600
May  6 16:11:00 bluesbreaker kernel: Call Trace:
May  6 16:11:00 bluesbreaker kernel:  [<c03ff4b9>] schedule_timeout+0xa9/0x=
b0
May  6 16:11:00 bluesbreaker kernel:  [<c03e45a1>] unix_poll+0xb1/0xc0
May  6 16:11:00 bluesbreaker kernel:  [<c0378df6>] sock_poll+0x26/0x30
May  6 16:11:00 bluesbreaker kernel:  [<c016d7a7>] do_select+0x297/0x2e0
May  6 16:11:00 bluesbreaker kernel:  [<c016d340>] __pollwait+0x0/0xd0
May  6 16:11:00 bluesbreaker kernel:  [<c016da9d>] sys_select+0x26d/0x4e0
May  6 16:11:00 bluesbreaker kernel:  [<c01032a9>] sysenter_past_esp+0x52/0=
x75
May  6 16:11:04 bluesbreaker kernel: SysRq : Emergency Sync
May  6 16:11:04 bluesbreaker kernel: Emergency Sync complete

--=20
 das eine Mal als Trag=F6die, das andere Mal als Farce
---1463811840-524957938-1115393652=:23675
Content-Type: APPLICATION/x-gunzip; name="config-2.6.11.7.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0505061641570.23797@ppg_penguin.kenmoffat.uklinux.net>
Content-Description: 
Content-Disposition: attachment; filename="config-2.6.11.7.gz"

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

---1463811840-524957938-1115393652=:23675
Content-Type: APPLICATION/x-gunzip; name="dmesg.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0505061641571.23797@ppg_penguin.kenmoffat.uklinux.net>
Content-Description: 
Content-Disposition: attachment; filename="dmesg.gz"

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
hvhyAAA=

---1463811840-524957938-1115393652=:23675--
