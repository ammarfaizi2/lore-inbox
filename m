Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271404AbTGQKlh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 06:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271400AbTGQKlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 06:41:37 -0400
Received: from [194.25.167.190] ([194.25.167.190]:38408 "EHLO
	tux.offermanns.de") by vger.kernel.org with ESMTP id S271404AbTGQKjG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 06:39:06 -0400
Date: Thu, 17 Jul 2003 12:53:56 +0200
From: Rolf Offermanns <rolf.offermanns@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.6.0-test1-mm1 hangs on rpm install on reiserfs
Message-ID: <95360000.1058439236@[172.22.2.22]>
X-Mailer: Mulberry/3.1.0b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========1899649384=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========1899649384==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I do a rpm -Uvh some_stuff.rpm on my laptop and the process runs endlessly
until I kill it with kill -9. This is on reiserfs.
"top" shows high IO-Wait values (> 85%).

The same procedure runs w/o problems on a 2.4.21 kernel.
It also runs perfectly well on an ext3 fs.

Attached is the output of "MagicSysRq + T" and "sh scripts/ver_linux".

If you need further information, please say so.
I am not subscribed to linux-kernel, so please CC me, but I will also check
the archive.

Thanks,
-Rolf
--==========1899649384==========
Content-Type: application/octet-stream; name="ver_linux.laptop"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ver_linux.laptop"; size=900

SWYgc29tZSBmaWVsZHMgYXJlIGVtcHR5IG9yIGxvb2sgdW51c3VhbCB5b3UgbWF5IGhhdmUgYW4g
b2xkIHZlcnNpb24uCkNvbXBhcmUgdG8gdGhlIGN1cnJlbnQgbWluaW1hbCByZXF1aXJlbWVudHMg
aW4gRG9jdW1lbnRhdGlvbi9DaGFuZ2VzLgogCkxpbnV4IHdpbGRzYXUtbW9iaWxlIDIuNi4wLXRl
c3QxLWFjMS1tbTEgIzEgU01QIFRodSBKdWwgMTcgMTI6MjY6MTIgQ0VTVCAyMDAzIGk2ODYgTW9i
aWxlIEludGVsKFIpIFBlbnRpdW0oUikgNCAtIE0gQ1BVIDEuOTBHSHogR2VudWluZUludGVsIEdO
VS9MaW51eAogCkdudSBDICAgICAgICAgICAgICAgICAgMy4yLjMKR251IG1ha2UgICAgICAgICAg
ICAgICAzLjgwCnV0aWwtbGludXggICAgICAgICAgICAgMi4xMXkKbW91bnQgICAgICAgICAgICAg
ICAgICAyLjExeAplMmZzcHJvZ3MgICAgICAgICAgICAgIDEuMzIKamZzdXRpbHMgICAgICAgICAg
ICAgICAxLjEuMQpyZWlzZXJmc3Byb2dzICAgICAgICAgIDMuNi4zCnhmc3Byb2dzICAgICAgICAg
ICAgICAgMi4zLjExCnBjbWNpYS1jcyAgICAgICAgICAgICAgMy4yLjIKUFBQICAgICAgICAgICAg
ICAgICAgICAyLjQuMQppc2RuNGstdXRpbHMgICAgICAgICAgIDMuMXByZTQKTGludXggQyBMaWJy
YXJ5ICAgICAgICAyLjMuMQpEeW5hbWljIGxpbmtlciAobGRkKSAgIDIuMy4xClByb2NwcyAgICAg
ICAgICAgICAgICAgMy4xLjYKTmV0LXRvb2xzICAgICAgICAgICAgICAxLjYwCkNvbnNvbGUtdG9v
bHMgICAgICAgICAgMC4yLjMKU2gtdXRpbHMgICAgICAgICAgICAgICA0LjUuMgpNb2R1bGVzIExv
YWRlZCAgICAgICAgIHNyX21vZCBwYXJwb3J0X3BjIGxwIHBhcnBvcnQgc25kIHNvdW5kY29yZSBy
YWRlb24gbnRmcyBhZ3BnYXJ0IGUxMDAgeWVudGFfc29ja2V0IGFwbSBydGMK

--==========1899649384==========
Content-Type: text/plain; charset=iso-8859-1; name="tasks.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="tasks.txt"; size=65776

Jul 17 12:34:45 wildsau-mobile kernel: 0 00000000 c0379080 cfc49380 =
c037b880=20
Jul 17 12:34:45 wildsau-mobile kernel:        00000000 000000d0 00000000 =
000000d0 cf6426b0 00000000 7fffffff 00000001=20
Jul 17 12:34:45 wildsau-mobile kernel:        cf2fde94 c0128d36 00000246 =
00000246 cf08f500 cf2fdef4 cf1ad480 cf2fde94=20
Jul 17 12:34:45 wildsau-mobile kernel: Call Trace:
Jul 17 12:34:45 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:34:45 wildsau-mobile kernel:  [<d186c4b1>] do_poll+0x50/0x6e =
[apm]
Jul 17 12:34:45 wildsau-mobile kernel:  [<c016d750>] do_select+0x17a/0x2ba
Jul 17 12:34:45 wildsau-mobile kernel:  [<c016d44b>] __pollwait+0x0/0xaa
Jul 17 12:34:45 wildsau-mobile kernel:  [<c016dba3>] sys_select+0x2e8/0x51e
Jul 17 12:34:45 wildsau-mobile kernel:  [<c012872e>] =
update_wall_time+0xf/0x3a
Jul 17 12:34:45 wildsau-mobile kernel:  [<c012d415>] =
sys_rt_sigaction+0x8f/0x105
Jul 17 12:34:45 wildsau-mobile kernel:  [<c02b05c1>] =
sys_socketcall+0x156/0x27b
Jul 17 12:34:45 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:34:46 wildsau-mobile kernel:=20
Jul 17 12:34:46 wildsau-mobile kernel: apmiser       S 00000001   245      =
1           251   241 (NOTLB)
Jul 17 12:34:46 wildsau-mobile kernel: cf03be58 00000082 c1284c20 00000001 =
00000001 00b856c5 cfc49080 cf03a000=20
Jul 17 12:34:46 wildsau-mobile kernel:        cf03be58 00000246 c1285600 =
cf03be6c cf03d940 ffffd76d cf03be6c 00000000=20
Jul 17 12:34:46 wildsau-mobile kernel:        cf03be94 c0128ce7 cf03be6c =
cd7eb023 ffffffff cf881f50 cf03c838 ffffd76d=20
Jul 17 12:34:46 wildsau-mobile kernel: Call Trace:
Jul 17 12:34:46 wildsau-mobile kernel:  [<c0128ce7>] =
schedule_timeout+0x61/0xb2
Jul 17 12:34:46 wildsau-mobile kernel:  [<c0128c7a>] =
process_timeout+0x0/0xc
Jul 17 12:34:46 wildsau-mobile kernel:  [<c016d750>] do_select+0x17a/0x2ba
Jul 17 12:34:46 wildsau-mobile kernel:  [<c0228b95>] sprintf+0x1f/0x23
Jul 17 12:34:46 wildsau-mobile kernel:  [<c016d44b>] __pollwait+0x0/0xaa
Jul 17 12:34:46 wildsau-mobile kernel:  [<c016dba3>] sys_select+0x2e8/0x51e
Jul 17 12:34:46 wildsau-mobile kernel:  [<c012872e>] =
update_wall_time+0xf/0x3a
Jul 17 12:34:46 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:34:46 wildsau-mobile kernel:=20
Jul 17 12:34:48 wildsau-mobile kernel: inetd         S C037B880   251      =
1           275   245 (NOTLB)
Jul 17 12:34:48 wildsau-mobile kernel: cf05be58 00000086 00000010 c037b880 =
00000000 000000d0 cf064b00 000000d0=20
Jul 17 12:34:48 wildsau-mobile kernel:        cefe8680 cf05bef4 cf05be4c =
c013feeb cf642080 00000000 7fffffff 00000005=20
Jul 17 12:34:49 wildsau-mobile kernel:        cf05be94 c0128d36 00000004 =
cf05be7c c02b494f cefe8680 cf377518 cf05bef4=20
Jul 17 12:34:49 wildsau-mobile kernel: Call Trace:
Jul 17 12:34:49 wildsau-mobile kernel:  [<c013feeb>] =
__get_free_pages+0x22/0x45
Jul 17 12:34:51 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:34:54 wildsau-mobile kernel:  [<c02b494f>] =
datagram_poll+0x2b/0xda
Jul 17 12:34:54 wildsau-mobile kernel:  [<c02aeed0>] sock_poll+0x29/0x30
Jul 17 12:34:54 wildsau-mobile kernel:  [<c016d750>] do_select+0x17a/0x2ba
Jul 17 12:34:54 wildsau-mobile kernel:  [<c016d44b>] __pollwait+0x0/0xaa
Jul 17 12:34:54 wildsau-mobile kernel:  [<c016dba3>] sys_select+0x2e8/0x51e
Jul 17 12:34:57 wildsau-mobile kernel:  [<c012cfc5>] =
do_sigaction+0x1e4/0x2cf
Jul 17 12:35:01 wildsau-mobile kernel:  [<c012d415>] =
sys_rt_sigaction+0x8f/0x105
Jul 17 12:35:01 wildsau-mobile kernel:  [<c012c247>] sigprocmask+0x61/0xf2
Jul 17 12:35:03 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:35:03 wildsau-mobile kernel:=20
Jul 17 12:35:03 wildsau-mobile kernel: sshd          S 000000D0   275      =
1   426     278   251 (NOTLB)
Jul 17 12:35:04 wildsau-mobile kernel: cf895e58 00000082 c1284c20 000000d0 =
cef19a80 cf895ef4 cfc49c80 c013feeb=20
Jul 17 12:35:04 wildsau-mobile kernel:        00000000 cf895e54 00000246 =
00000246 cf95ece0 00000000 7fffffff 00000004=20
Jul 17 12:35:04 wildsau-mobile kernel:        cf895e94 c0128d36 cf377318 =
cf895ef4 c0379410 cef17d1c c03bff80 00000008=20
Jul 17 12:35:05 wildsau-mobile kernel: Call Trace:
Jul 17 12:35:05 wildsau-mobile kernel:  [<c013feeb>] =
__get_free_pages+0x22/0x45
Jul 17 12:35:05 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:35:07 wildsau-mobile kernel:  [<c02aeed0>] sock_poll+0x29/0x30
Jul 17 12:35:07 wildsau-mobile kernel:  [<c016d750>] do_select+0x17a/0x2ba
Jul 17 12:35:07 wildsau-mobile kernel:  [<c016d44b>] __pollwait+0x0/0xaa
Jul 17 12:35:08 wildsau-mobile kernel:  [<c016dba3>] sys_select+0x2e8/0x51e
Jul 17 12:35:13 wildsau-mobile kernel:  [<c015a412>] __fput+0xd2/0x136
Jul 17 12:35:13 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:35:14 wildsau-mobile kernel:=20
Jul 17 12:35:14 wildsau-mobile kernel: rpc.nfsd      S 00000001   278      =
1           280   275 (NOTLB)
Jul 17 12:35:14 wildsau-mobile kernel: cefc9ef8 00000086 c1284c20 00000001 =
00000001 cf0f85d0 cf064200 cefc9efc=20
Jul 17 12:35:17 wildsau-mobile kernel:        c02ce805 cefe8280 ced04b98 =
cefc9fa0 cf03d310 00000000 7fffffff cefc9f58=20
Jul 17 12:35:17 wildsau-mobile kernel:        cefc9f34 c0128d36 c02aeed0 =
cefe8280 ced04b80 cefc9fa0 00000145 cefc9f34=20
Jul 17 12:35:17 wildsau-mobile kernel: Call Trace:
Jul 17 12:35:25 wildsau-mobile kernel:  [<c02ce805>] tcp_poll+0x36/0x190
Jul 17 12:35:31 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:35:31 wildsau-mobile kernel:  [<c02aeed0>] sock_poll+0x29/0x30
Jul 17 12:35:35 wildsau-mobile kernel:  [<c016de30>] do_pollfd+0x57/0x98
Jul 17 12:35:35 wildsau-mobile kernel:  [<c016df0f>] do_poll+0x9e/0xbd
Jul 17 12:35:36 wildsau-mobile kernel:  [<c016e0b3>] sys_poll+0x185/0x26a
Jul 17 12:35:36 wildsau-mobile kernel:  [<c016d44b>] __pollwait+0x0/0xaa
Jul 17 12:35:36 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:35:38 wildsau-mobile kernel:=20
Jul 17 12:35:38 wildsau-mobile kernel: rpc.mountd    S 00000001   280      =
1           287   278 (NOTLB)
Jul 17 12:35:38 wildsau-mobile kernel: cef01ef8 00000086 c1284c20 00000001 =
00000001 cf0f8650 cf064500 cef01efc=20
Jul 17 12:35:40 wildsau-mobile kernel:        c02ce805 cf0ff580 ced04598 =
cef01fa0 cf03c6b0 00000000 7fffffff cef01f58=20
Jul 17 12:35:40 wildsau-mobile kernel:        cef01f34 c0128d36 c02aeed0 =
cf0ff580 ced04580 cef01fa0 00000145 cef01f34=20
Jul 17 12:35:40 wildsau-mobile kernel: Call Trace:
Jul 17 12:35:43 wildsau-mobile kernel:  [<c02ce805>] tcp_poll+0x36/0x190
Jul 17 12:35:43 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:35:43 wildsau-mobile kernel:  [<c02aeed0>] sock_poll+0x29/0x30
Jul 17 12:35:45 wildsau-mobile kernel:  [<c016de30>] do_pollfd+0x57/0x98
Jul 17 12:35:45 wildsau-mobile kernel:  [<c016df0f>] do_poll+0x9e/0xbd
Jul 17 12:35:45 wildsau-mobile kernel:  [<c016e0b3>] sys_poll+0x185/0x26a
Jul 17 12:35:47 wildsau-mobile kernel:  [<c016d44b>] __pollwait+0x0/0xaa
Jul 17 12:35:47 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:35:47 wildsau-mobile kernel:=20
Jul 17 12:35:48 wildsau-mobile kernel: cupsd         S 00000001   287      =
1           417   280 (NOTLB)
Jul 17 12:35:56 wildsau-mobile kernel: ceecde58 00000082 c1284c20 00000001 =
00000001 ceecdef4 cf064c80 ceecc000=20
Jul 17 12:35:56 wildsau-mobile kernel:        ceecde58 000000000d0 cf6426b0 =
00000000 7fffffff 00000001=20
Jul 17 12:35:57 wildsau-mobile kernel:        cf2fde94 c0128d36 00000246 =
00000246 cf08f500 cf2fdef4 cf1ad480 cf2fde94=20
Jul 17 12:35:57 wildsau-mobile kernel: Call Trace:
Jul 17 12:35:57 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:35:58 wildsau-mobile kernel:  [<d186c4b1>] do_poll+0x50/0x6e =
[apm]
Jul 17 12:35:58 wildsau-mobile kernel:  [<c016d750>] do_select+0x17a/0x2ba
Jul 17 12:35:58 wildsau-mobile kernel:  [<c016d44b>] __pollwait+0x0/0xaa
Jul 17 12:35:58 wildsau-mobile kernel:  [<c016dba3>] sys_select+0x2e8/0x51e
Jul 17 12:35:58 wildsau-mobile kernel:  [<c012872e>] =
update_wall_time+0xf/0x3a
Jul 17 12:35:58 wildsau-mobile kernel:  [<c012d415>] =
sys_rt_sigaction+0x8f/0x105
Jul 17 12:35:58 wildsau-mobile kernel:  [<c02b05c1>] =
sys_socketcall+0x156/0x27b
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:35:58 wildsau-mobile kernel:=20
Jul 17 12:35:58 wildsau-mobile kernel: apmiser       S 000000C0   245      =
1           251   241 (NOTLB)
Jul 17 12:35:58 wildsau-mobile kernel: cf03be58 00000082 00005682 000000c0 =
00000216 00b856c5 cfc49080 cf03a000=20
Jul 17 12:35:58 wildsau-mobile kernel:        cf03be58 00000246 c1285600 =
cf03be6c cf03d940 00000a6d cf03be6c 00000000=20
Jul 17 12:35:58 wildsau-mobile kernel:        cf03be94 c0128ce7 cf03be6c =
cc166023 ffffffff cf881f50 cfc5a348 00000a6d=20
Jul 17 12:35:58 wildsau-mobile kernel: Call Trace:
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0128ce7>] =
schedule_timeout+0x61/0xb2
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0128c7a>] =
process_timeout+0x0/0xc
Jul 17 12:35:58 wildsau-mobile kernel:  [<c016d750>] do_select+0x17a/0x2ba
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0228b95>] sprintf+0x1f/0x23
Jul 17 12:35:58 wildsau-mobile kernel:  [<c016d44b>] __pollwait+0x0/0xaa
Jul 17 12:35:58 wildsau-mobile kernel:  [<c016dba3>] sys_select+0x2e8/0x51e
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:35:58 wildsau-mobile kernel:=20
Jul 17 12:35:58 wildsau-mobile kernel: inetd         S C037B880   251      =
1           275   245 (NOTLB)
Jul 17 12:35:58 wildsau-mobile kernel: cf05be58 00000086 00000010 c037b880 =
00000000 000000d0 cf064b00 000000d0=20
Jul 17 12:35:58 wildsau-mobile kernel:        cefe8680 cf05bef4 cf05be4c =
c013feeb cf642080 00000000 7fffffff 00000005=20
Jul 17 12:35:58 wildsau-mobile kernel:        cf05be94 c0128d36 00000004 =
cf05be7c c02b494f cefe8680 cf377518 cf05bef4=20
Jul 17 12:35:58 wildsau-mobile kernel: Call Trace:
Jul 17 12:35:58 wildsau-mobile kernel:  [<c013feeb>] =
__get_free_pages+0x22/0x45
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:35:58 wildsau-mobile kernel:  [<c02b494f>] =
datagram_poll+0x2b/0xda
Jul 17 12:35:58 wildsau-mobile kernel:  [<c02aeed0>] sock_poll+0x29/0x30
Jul 17 12:35:58 wildsau-mobile kernel:  [<c016d750>] do_select+0x17a/0x2ba
Jul 17 12:35:58 wildsau-mobile kernel:  [<c016d44b>] __pollwait+0x0/0xaa
Jul 17 12:35:58 wildsau-mobile kernel:  [<c016dba3>] sys_select+0x2e8/0x51e
Jul 17 12:35:58 wildsau-mobile kernel:  [<c012cfc5>] =
do_sigaction+0x1e4/0x2cf
Jul 17 12:35:58 wildsau-mobile kernel:  [<c012d415>] =
sys_rt_sigaction+0x8f/0x105
Jul 17 12:35:58 wildsau-mobile kernel:  [<c012c247>] sigprocmask+0x61/0xf2
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:35:58 wildsau-mobile kernel:=20
Jul 17 12:35:58 wildsau-mobile kernel: sshd          S 000000D0   275      =
1   426     278   251 (NOTLB)
Jul 17 12:35:58 wildsau-mobile kernel: cf895e58 00000082 c1284c20 000000d0 =
cef19a80 cf895ef4 cfc49c80 c013feeb=20
Jul 17 12:35:58 wildsau-mobile kernel:        00000000 cf895e54 00000246 =
00000246 cf95ece0 00000000 7fffffff 00000004=20
Jul 17 12:35:58 wildsau-mobile kernel:        cf895e94 c0128d36 cf377318 =
cf895ef4 c0379410 cef17d1c c03bff80 00000008=20
Jul 17 12:35:58 wildsau-mobile kernel: Call Trace:
Jul 17 12:35:58 wildsau-mobile kernel:  [<c013feeb>] =
__get_free_pages+0x22/0x45
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:35:58 wildsau-mobile kernel:  [<c02aeed0>] sock_poll+0x29/0x30
Jul 17 12:35:58 wildsau-mobile kernel:  [<c016d750>] do_select+0x17a/0x2ba
Jul 17 12:35:58 wildsau-mobile kernel:  [<c016d44b>] __pollwait+0x0/0xaa
Jul 17 12:35:58 wildsau-mobile kernel:  [<c016dba3>] sys_select+0x2e8/0x51e
Jul 17 12:35:58 wildsau-mobile kernel:  [<c015a412>] __fput+0xd2/0x136
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:35:58 wildsau-mobile kernel:=20
Jul 17 12:35:58 wildsau-mobile kernel: rpc.nfsd      S 00000001   278      =
1           280   275 (NOTLB)
Jul 17 12:35:58 wildsau-mobile kernel: cefc9ef8 00000086 c1284c20 00000001 =
00000001 cf0f85d0 cf064200 cefc9efc=20
Jul 17 12:35:58 wildsau-mobile kernel:        c02ce805 cefe8280 ced04b98 =
cefc9fa0 cf03d310 00000000 7fffffff cefc9f58=20
Jul 17 12:35:58 wildsau-mobile kernel:        cefc9f34 c0128d36 c02aeed0 =
cefe8280 ced04b80 cefc9fa0 00000145 cefc9f34=20
Jul 17 12:35:58 wildsau-mobile kernel: Call Trace:
Jul 17 12:35:58 wildsau-mobile kernel:  [<c02ce805>] tcp_poll+0x36/0x190
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:35:58 wildsau-mobile kernel:  [<c02aeed0>] sock_poll+0x29/0x30
Jul 17 12:35:58 wildsau-mobile kernel:  [<c016de30>] do_pollfd+0x57/0x98
Jul 17 12:35:58 wildsau-mobile kernel:  [<c016df0f>] do_poll+0x9e/0xbd
Jul 17 12:35:58 wildsau-mobile kernel:  [<c016e0b3>] sys_poll+0x185/0x26a
Jul 17 12:35:58 wildsau-mobile kernel:  [<c016d44b>] __pollwait+0x0/0xaa
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:35:58 wildsau-mobile kernel:=20
Jul 17 12:35:58 wildsau-mobile kernel: rpc.mountd    S 00000001   280      =
1           287   278 (NOTLB)
Jul 17 12:35:58 wildsau-mobile kernel: cef01ef8 00000086 c1284c20 00000001 =
00000001 cf0f8650 cf064500 cef01efc=20
Jul 17 12:35:58 wildsau-mobile kernel:        c02ce805 cf0ff580 ced04598 =
cef01fa0 cf03c6b0 00000000 7fffffff cef01f58=20
Jul 17 12:35:58 wildsau-mobile kernel:        cef01f34 c0128d36 c02aeed0 =
cf0ff580 ced04580 cef01fa0 00000145 cef01f34=20
Jul 17 12:35:58 wildsau-mobile kernel: Call Trace:
Jul 17 12:35:58 wildsau-mobile kernel:  [<c02ce805>] tcp_poll+0x36/0x190
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:35:58 wildsau-mobile kernel:  [<c02aeed0>] sock_poll+0x29/0x30
Jul 17 12:35:58 wildsau-mobile kernel:  [<c016de30>] do_pollfd+0x57/0x98
Jul 17 12:35:58 wildsau-mobile kernel:  [<c016df0f>] do_poll+0x9e/0xbd
Jul 17 12:35:58 wildsau-mobile kernel:  [<c016e0b3>] sys_poll+0x185/0x26a
Jul 17 12:35:58 wildsau-mobile kernel:  [<c016d44b>] __pollwait+0x0/0xaa
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:35:58 wildsau-mobile kernel:=20
Jul 17 12:35:58 wildsau-mobile kernel: cupsd         S 000000D0   287      =
1           417   280 (NOTLB)
Jul 17 12:35:58 wildsau-mobile kernel: ceecde58 00000082 c1284c20 000000d0 =
cec01880 ceecdef4 cf064c80 ceecc000=20
Jul 17 12:35:58 wildsau-mobile kernel:        ceecde58 00000246 c1285600 =
ceecde6c ceecf940 00000ae5 ceecde6c 00000003=20
Jul 17 12:35:58 wildsau-mobile kernel:        ceecde94 c0128ce7 ceecde6c =
ceecde7c c02b494f c1285e5c cf881f50 00000ae5=20
Jul 17 12:35:58 wildsau-mobile kernel: Call Trace:
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0128ce7>] =
schedule_timeout+0x61/0xb2
Jul 17 12:35:58 wildsau-mobile kernel:  [<c02b494f>] =
datagram_poll+0x2b/0xda
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0128c7a>] =
process_timeout+0x0/0xc
Jul 17 12:35:58 wildsau-mobile kernel:  [<c016d750>] do_select+0x17a/0x2ba
Jul 17 12:35:58 wildsau-mobile kernel:  [<c016d44b>] __pollwait+0x0/0xaa
Jul 17 12:35:58 wildsau-mobile kernel:  [<c016dba3>] sys_select+0x2e8/0x51e
Jul 17 12:35:58 wildsau-mobile kernel:  [<c012872e>] =
update_wall_time+0xf/0x3a
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0110050>] =
timer_interrupt+0x82/0x178
Jul 17 12:35:58 wildsau-mobile kernel:  [<c010b74d>] =
handle_IRQ_event+0x39/0x62
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:35:58 wildsau-mobile kernel:=20
Jul 17 12:35:58 wildsau-mobile kernel: atd           S CEEEDEF8   417      =
1           420   287 (NOTLB)
Jul 17 12:35:58 wildsau-mobile kernel: ceeedef8 00000086 fffbc05c ceeedef8 =
c013303e ceeededc cfc49200 ceeec000=20
Jul 17 12:35:58 wildsau-mobile kernel:        ceeedef8 00000246 c1285600 =
ceeedf68 cf03c080 ceeec000 0036f0a5 00000000=20
Jul 17 12:35:58 wildsau-mobile kernel:        ceeedf94 c0133c91 ceeedf68 =
ceeedf18 00000000 ceeedf20 c04316e0 ceeec01c=20
Jul 17 12:35:58 wildsau-mobile kernel: Call Trace:
Jul 17 12:35:58 wildsau-mobile kernel:  [<c013303e>] =
adjust_abs_time+0xa5/0x10a
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0133c91>] =
do_clock_nanosleep+0x194/0x2ca
Jul 17 12:35:58 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:35:58 wildsau-mobile kernel:  [<c017198b>] dput+0x24/0x2ae
Jul 17 12:35:58 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:35:58 wildsau-mobile kernel:  [<c012d469>] =
sys_rt_sigaction+0xe3/0x105
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01338cc>] =
nanosleep_wake_up+0x0/0xc
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0133962>] =
sys_nanosleep+0x75/0xfa
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:35:58 wildsau-mobile kernel:=20
Jul 17 12:35:58 wildsau-mobile kernel: bash          S 00000001   420      =
1           421   417 (NOTLB)
Jul 17 12:35:58 wildsau-mobile kernel: cfbade3c 00000086 c1284c20 00000001 =
00000001 cfc4f000 cf064e00 cfbade5f=20
Jul 17 12:35:58 wildsau-mobile kernel:        00000017 00000017 cfc4f000 =
cfbadea4 cfc6a080 00000008 7fffffff 00000000=20
Jul 17 12:35:58 wildsau-mobile kernel:        cfbade78 c0128d36 00000017 =
746f6f72 6c697740 0000000e 00000206 c138c000=20
Jul 17 12:35:58 wildsau-mobile kernel: Call Trace:
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:35:58 wildsau-mobile kernel:  [<c023f888>] read_chan+0x284/0x92a
Jul 17 12:35:58 wildsau-mobile kernel:  [<c02400a4>] write_chan+0x176/0x247
Jul 17 12:35:58 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:35:58 wildsau-mobile kernel:  [<c02408a6>] set_termios+0xc8/0x19c
Jul 17 12:35:58 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0239d7e>] tty_write+0x275/0x3fd
Jul 17 12:35:58 wildsau-mobile kernel:  [<c023f604>] read_chan+0x0/0x92a
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0239ac6>] tty_read+0x157/0x19a
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0159424>] vfs_read+0xaf/0x119
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01596da>] sys_read+0x3f/0x5d
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:35:58 wildsau-mobile kernel:=20
Jul 17 12:35:58 wildsau-mobile kernel: getty         S 00000296   421      =
1           422   420 (NOTLB)
Jul 17 12:35:58 wildsau-mobile kernel: cefb9e3c 00000082 c013c363 00000296 =
0000000a cefb9e24 cf064380 ffffffff=20
Jul 17 12:35:58 wildsau-mobile kernel:        00000000 00000020 cefb9e84 =
c024c7fe cf03cce0 00000008 7fffffff 00000000=20
Jul 17 12:35:58 wildsau-mobile kernel:        cefb9e78 c0128d36 cef2220a =
00000008 00000246 000000ff 00000282 40012000=20
Jul 17 12:35:58 wildsau-mobile kernel: Call Trace:
Jul 17 12:35:58 wildsau-mobile kernel:  [<c013c363>] =
file_read_actor+0x0/0xfc
Jul 17 12:35:58 wildsau-mobile kernel:  [<c024c7fe>] =
do_con_write+0x2ec/0x71f
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:35:58 wildsau-mobile kernel:  [<c023f888>] read_chan+0x284/0x92a
Jul 17 12:35:58 wildsau-mobile kernel:  [<c024d209>] con_write+0x36/0x42
Jul 17 12:35:58 wildsau-mobile kernel:  [<c02400a4>] write_chan+0x176/0x247
Jul 17 12:35:58 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:35:58 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0239d7e>] tty_write+0x275/0x3fd
Jul 17 12:35:58 wildsau-mobile kernel:  [<c023f604>] read_chan+0x0/0x92a
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0239ac6>] tty_read+0x157/0x19a
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0159424>] vfs_read+0xaf/0x119
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01596da>] sys_read+0x3f/0x5d
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:35:58 wildsau-mobile kernel:=20
Jul 17 12:35:58 wildsau-mobile kernel: getty         S 00000296   422      =
1           423   421 (NOTLB)
Jul 17 12:35:58 wildsau-mobile kernel: ceeafe3c 00000082 c013c363 00000296 =
0000000a ceeafe24 cf064080 ffffffff=20
Jul 17 12:35:58 wildsau-mobile kernel:        00000000 00000020 ceeafe84 =
c024c7fe ceecf310 00000008 7fffffff 00000000=20
Jul 17 12:35:58 wildsau-mobile kernel:        ceeafe78 c0128d36 cf35820a =
00000008 00000246 000000ff 00000282 40012000=20
Jul 17 12:35:58 wildsau-mobile kernel: Call Trace:
Jul 17 12:35:58 wildsau-mobile kernel:  [<c013c363>] =
file_read_actor+0x0/0xfc
Jul 17 12:35:58 wildsau-mobile kernel:  [<c024c7fe>] =
do_con_write+0x2ec/0x71f
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:35:58 wildsau-mobile kernel:  [<c023f888>] read_chan+0x284/0x92a
Jul 17 12:35:58 wildsau-mobile kernel:  [<c024d209>] con_write+0x36/0x42
Jul 17 12:35:58 wildsau-mobile kernel:  [<c02400a4>] write_chan+0x176/0x247
Jul 17 12:35:58 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:35:58 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0239d7e>] tty_write+0x275/0x3fd
Jul 17 12:35:58 wildsau-mobile kernel:  [<c023f604>] read_chan+0x0/0x92a
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0239ac6>] tty_read+0x157/0x19a
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0159424>] vfs_read+0xaf/0x119
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01596da>] sys_read+0x3f/0x5d
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:35:58 wildsau-mobile kernel:=20
Jul 17 12:35:58 wildsau-mobile kernel: getty         S 00000296   423      =
1           424   422 (NOTLB)
Jul 17 12:35:58 wildsau-mobile kernel: cee75e3c 00000086 c013c363 00000296 =
0000000a cee75e24 cf9e3e00 ffffffff=20
Jul 17 12:35:58 wildsau-mobile kernel:        00000000 00000020 cee75e84 =
c024c7fe ceecece0 00000008 7fffffff 00000000=20
Jul 17 12:35:58 wildsau-mobile kernel:        cee75e78 c0128d36 cf82120a =
00000008 00000246 000000ff 00000282 40012000=20
Jul 17 12:35:58 wildsau-mobile kernel: Call Trace:
Jul 17 12:35:58 wildsau-mobile kernel:  [<c013c363>] =
file_read_actor+0x0/0xfc
Jul 17 12:35:58 wildsau-mobile kernel:  [<c024c7fe>] =
do_con_write+0x2ec/0x71f
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:35:58 wildsau-mobile kernel:  [<c023f888>] read_chan+0x284/0x92a
Jul 17 12:35:58 wildsau-mobile kernel:  [<c024d209>] con_write+0x36/0x42
Jul 17 12:35:58 wildsau-mobile kernel:  [<c02400a4>] write_chan+0x176/0x247
Jul 17 12:35:58 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:35:58 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0239d7e>] tty_write+0x275/0x3fd
Jul 17 12:35:58 wildsau-mobile kernel:  [<c023f604>] read_chan+0x0/0x92a
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0239ac6>] tty_read+0x157/0x19a
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0159424>] vfs_read+0xaf/0x119
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01596da>] sys_read+0x3f/0x5d
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:35:58 wildsau-mobile kernel:=20
Jul 17 12:35:58 wildsau-mobile kernel: getty         S 00000296   424      =
1           425   423 (NOTLB)
Jul 17 12:35:58 wildsau-mobile kernel: ce987e3c 00000086 c013c363 00000296 =
0000000a ce987e24 cf9e3800 ffffffff=20
Jul 17 12:35:58 wildsau-mobile kernel:        00000000 00000020 ce987e84 =
c024c7fe ceece6b0 00000008 7fffffff 00000000=20
Jul 17 12:35:58 wildsau-mobile kernel:        ce987e78 c0128d36 cf26920a =
00000008 00000246 000000ff 00000282 40012000=20
Jul 17 12:35:58 wildsau-mobile kernel: Call Trace:
Jul 17 12:35:58 wildsau-mobile kernel:  [<c013c363>] =
file_read_actor+0x0/0xfc
Jul 17 12:35:58 wildsau-mobile kernel:  [<c024c7fe>] =
do_con_write+0x2ec/0x71f
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:35:58 wildsau-mobile kernel:  [<c023f888>] read_chan+0x284/0x92a
Jul 17 12:35:58 wildsau-mobile kernel:  [<c024d209>] con_write+0x36/0x42
Jul 17 12:35:58 wildsau-mobile kernel:  [<c02400a4>] write_chan+0x176/0x247
Jul 17 12:35:58 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:35:58 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0239d7e>] tty_write+0x275/0x3fd
Jul 17 12:35:58 wildsau-mobile kernel:  [<c023f604>] read_chan+0x0/0x92a
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0239ac6>] tty_read+0x157/0x19a
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0159424>] vfs_read+0xaf/0x119
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01596da>] sys_read+0x3f/0x5d
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:35:58 wildsau-mobile kernel:=20
Jul 17 12:35:58 wildsau-mobile kernel: getty         S 00000296   425      =
1           431   424 (NOTLB)
Jul 17 12:35:58 wildsau-mobile kernel: ce851e3c 00000082 c013c363 00000296 =
0000000a ce851e24 cf9e3980 ffffffff=20
Jul 17 12:35:58 wildsau-mobile kernel:        00000000 00000020 ce851e84 =
c024c7fe ceece080 00000008 7fffffff 00000000=20
Jul 17 12:35:58 wildsau-mobile kernel:        ce851e78 c0128d36 cf42d20a =
00000008 00000246 000000ff 00000282 40012000=20
Jul 17 12:35:58 wildsau-mobile kernel: Call Trace:
Jul 17 12:35:58 wildsau-mobile kernel:  [<c013c363>] =
file_read_actor+0x0/0xfc
Jul 17 12:35:58 wildsau-mobile kernel:  [<c024c7fe>] =
do_con_write+0x2ec/0x71f
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:35:58 wildsau-mobile kernel:  [<c023f888>] read_chan+0x284/0x92a
Jul 17 12:35:58 wildsau-mobile kernel:  [<c024d209>] con_write+0x36/0x42
Jul 17 12:35:58 wildsau-mobile kernel:  [<c02400a4>] write_chan+0x176/0x247
Jul 17 12:35:58 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:35:58 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0239d7e>] tty_write+0x275/0x3fd
Jul 17 12:35:58 wildsau-mobile kernel:  [<c023f604>] read_chan+0x0/0x92a
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0239ac6>] tty_read+0x157/0x19a
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0159424>] vfs_read+0xaf/0x119
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01596da>] sys_read+0x3f/0x5d
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:35:58 wildsau-mobile kernel:=20
Jul 17 12:35:58 wildsau-mobile kernel: sshd          S CE863D0C   426    =
275   428               (NOTLB)
Jul 17 12:35:58 wildsau-mobile kernel: ce863d1c 00000086 00000286 ce863d0c =
00000286 cf377918 cf064800 00000001=20
Jul 17 12:35:58 wildsau-mobile kernel:        00000000 cf377918 cfaf4e00 =
ce862000 ce865940 cfaf4500 7fffffff 7fffffff=20
Jul 17 12:35:58 wildsau-mobile kernel:        ce863d58 c0128d36 cfaf4e00 =
ce863d8c c0306ef4 cfaf4e00 0000005b 00000000=20
Jul 17 12:35:58 wildsau-mobile kernel: Call Trace:
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0306ef4>] =
unix_dgram_sendmsg+0x38e/0x5fd
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0307927>] =
unix_stream_data_wait+0xfe/0x161
Jul 17 12:35:58 wildsau-mobile kernel:  [<c011dfd8>] =
autoremove_wake_function+0x0/0x4b
Jul 17 12:35:58 wildsau-mobile kernel:  [<c011dfd8>] =
autoremove_wake_function+0x0/0x4b
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0307eec>] =
unix_stream_recvmsg+0x562/0x5d6
Jul 17 12:35:58 wildsau-mobile kernel:  [<c013fae4>] =
buffered_rmqueue+0xf0/0x1b1
Jul 17 12:35:58 wildsau-mobile kernel:  [<c02ae839>] =
sock_aio_read+0xd2/0xd9
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0159343>] do_sync_read+0xc2/0xf4
Jul 17 12:35:58 wildsau-mobile kernel:  [<c014a44f>] do_wp_page+0x1bf/0x348
Jul 17 12:35:58 wildsau-mobile kernel:  [<c014b4a4>] =
handle_mm_fault+0x184/0x1be
Jul 17 12:35:58 wildsau-mobile kernel:  [<c011dfd8>] =
autoremove_wake_function+0x0/0x4b
Jul 17 12:35:58 wildsau-mobile kernel:  [<c015945e>] vfs_read+0xe9/0x119
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01596da>] sys_read+0x3f/0x5d
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:35:58 wildsau-mobile kernel:=20
Jul 17 12:35:58 wildsau-mobile kernel: sshd          S 000000D0   428    =
426                     (NOTLB)
Jul 17 12:35:58 wildsau-mobile kernel: ce7b1e58 00000082 ceca3180 000000d0 =
cfc6c880 ce7b1ef4 cf064680 c013feeb=20
Jul 17 12:35:58 wildsau-mobile kernel:        00000000 ce7b1e54 00000246 =
00000246 ce865310 00000000 7fffffff 0000000c=20
Jul 17 12:35:58 wildsau-mobile kernel:        ce7b1e94 c0128d36 0000000b =
ce7b1e7c c03082b1 ce7e0d80 ce7d7d18 ce7b1ef4=20
Jul 17 12:35:58 wildsau-mobile kernel: Call Trace:
Jul 17 12:35:58 wildsau-mobile kernel:  [<c013feeb>] =
__get_free_pages+0x22/0x45
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:35:58 wildsau-mobile kernel:  [<c03082b1>] unix_poll+0x2b/0x9c
Jul 17 12:35:58 wildsau-mobile kernel:  [<c02aeed0>] sock_poll+0x29/0x30
Jul 17 12:35:58 wildsau-mobile kernel:  [<c016d750>] do_select+0x17a/0x2ba
Jul 17 12:35:58 wildsau-mobile kernel:  [<c016d44b>] __pollwait+0x0/0xaa
Jul 17 12:35:58 wildsau-mobile kernel:  [<c016dba3>] sys_select+0x2e8/0x51e
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:35:58 wildsau-mobile kernel:=20
Jul 17 12:35:58 wildsau-mobile kernel: xterm         S 000000D0   431      =
1   432     450   425 (NOTLB)
Jul 17 12:35:58 wildsau-mobile kernel: ce6f7e58 00000082 ceca3c00 000000d0 =
ce6bf680 ce6f7ef4 cf9e3080 c013feeb=20
Jul 17 12:35:58 wildsau-mobile kernel:        00000000 00000246 cf410000 =
ce6f7ef4 ce8646b0 00000000 7fffffff 00000005=20
Jul 17 12:35:58 wildsau-mobile kernel:        ce6f7e94 c0128d36 cf410000 =
cf41092c ce6f7ef4 cf410000 ce6bf280 00000004=20
Jul 17 12:35:58 wildsau-mobile kernel: Call Trace:
Jul 17 12:35:58 wildsau-mobile kernel:  [<c013feeb>] =
__get_free_pages+0x22/0x45
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:35:58 wildsau-mobile kernel:  [<c023b4c8>] tty_poll+0x7d/0xa4
Jul 17 12:35:58 wildsau-mobile kernel:  [<c016d750>] do_select+0x17a/0x2ba
Jul 17 12:35:58 wildsau-mobile kernel:  [<c016d44b>] __pollwait+0x0/0xaa
Jul 17 12:35:58 wildsau-mobile kernel:  [<c016dba3>] sys_select+0x2e8/0x51e
Jul 17 12:35:58 wildsau-mobile kernel:  [<c02f4726>] inet_ioctl+0xd5/0xfe
Jul 17 12:35:58 wildsau-mobile kernel:  [<c02aecc5>] sock_ioctl+0x114/0x2f6
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:35:58 wildsau-mobile kernel:=20
Jul 17 12:35:58 wildsau-mobile kernel: bash          S 080D8D7C   432    =
431   436               (NOTLB)
Jul 17 12:35:58 wildsau-mobile kernel: ce40ff48 00000082 ce2c1cc0 080d8d7c =
00000001 00000001 cfc49980 ce2c1cc0=20
Jul 17 12:35:58 wildsau-mobile kernel:        00000000 00000011 00030002 =
00000246 ce864080 ce40e000 fffffe00 ce864080=20
Jul 17 12:35:58 wildsau-mobile kernel:        ce40ffbc c01233c3 ffffffff =
00000002 ce229940 ce40ff74 c01215a2 ce864120=20
Jul 17 12:35:58 wildsau-mobile kernel: Call Trace:
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01233c3>] sys_wait4+0x1d8/0x27f
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01215a2>] =
session_of_pgrp+0x37/0xb2
Jul 17 12:35:58 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:35:58 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:35:58 wildsau-mobile kernel:=20
Jul 17 12:35:58 wildsau-mobile kernel: bash          S 080D8CC8   436    =
432   460               (NOTLB)
Jul 17 12:35:58 wildsau-mobile kernel: ce239f48 00000082 ce2c1700 080d8cc8 =
00000001 00000001 cf064980 ce2c1700=20
Jul 17 12:35:58 wildsau-mobile kernel:        00000000 00000011 00030002 =
00000246 ce229940 ce238000 fffffe00 ce229940=20
Jul 17 12:35:58 wildsau-mobile kernel:        ce239fbc c01233c3 ffffffff =
00000002 ce2286b0 ce239f74 c01215a2 ce2299e0=20
Jul 17 12:35:58 wildsau-mobile kernel: Call Trace:
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01233c3>] sys_wait4+0x1d8/0x27f
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01215a2>] =
session_of_pgrp+0x37/0xb2
Jul 17 12:35:58 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:35:58 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:35:58 wildsau-mobile kernel:=20
Jul 17 12:35:58 wildsau-mobile kernel: pdflush       D 00000001   450      =
1                 431 (L-TLB)
Jul 17 12:35:58 wildsau-mobile kernel: c5fe7e2c 00000046 c1284c20 00000001 =
00000001 c5fe7e34 cfc49500 c5fe6000=20
Jul 17 12:35:58 wildsau-mobile kernel:        c5fe7e2c 00000246 c1285600 =
c5fe7e40 ce228080 000007c4 c5fe7e40 c5fe7ef8=20
Jul 17 12:35:58 wildsau-mobile kernel:        c5fe7e68 c0128ce7 c5fe7e40 =
c5fe7e4c c014130f c1285c2c c1285c2c 000007c4=20
Jul 17 12:35:58 wildsau-mobile kernel: Call Trace:
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0128ce7>] =
schedule_timeout+0x61/0xb2
Jul 17 12:35:58 wildsau-mobile kernel:  [<c014130f>] =
do_writepages+0x37/0x39
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0128c7a>] =
process_timeout+0x0/0xc
Jul 17 12:35:58 wildsau-mobile kernel:  [<c011ce3e>] =
io_schedule_timeout+0x29/0x33
Jul 17 12:35:58 wildsau-mobile kernel:  [<c025b19c>] =
blk_congestion_wait_wq+0xab/0xb8
Jul 17 12:35:58 wildsau-mobile kernel:  [<c011dfd8>] =
autoremove_wake_function+0x0/0x4b
Jul 17 12:35:58 wildsau-mobile kernel:  [<c011dfd8>] =
autoremove_wake_function+0x0/0x4b
Jul 17 12:35:58 wildsau-mobile kernel:  [<c025b1c9>] =
blk_congestion_wait+0x20/0x24
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0140ffb>] =
background_writeout+0xc3/0xd0
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0141b35>] __pdflush+0x105/0x226
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0141c56>] pdflush+0x0/0x15
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0141c67>] pdflush+0x11/0x15
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0140f38>] =
background_writeout+0x0/0xd0
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0107329>] =
kernel_thread_helper+0x5/0xb
Jul 17 12:35:58 wildsau-mobile kernel:=20
Jul 17 12:35:58 wildsau-mobile kernel: elinos-rpm    D 00000001   460    =
436                     (NOTLB)
Jul 17 12:35:58 wildsau-mobile kernel: c86e5b90 00000086 c1284c20 00000001 =
00000001 c014718e cf9e3b00 c86e4000=20
Jul 17 12:35:58 wildsau-mobile kernel:        c86e5b90 00000246 c1285600 =
c86e5ba4 ce2286b0 0000078d c86e5ba4 00000000=20
Jul 17 12:35:58 wildsau-mobile kernel:        c86e5bcc c0128ce7 c86e5ba4 =
00000282 ffffffff c1285a74 c1285a74 0000078d=20
Jul 17 12:35:58 wildsau-mobile kernel: Call Trace:
Jul 17 12:35:58 wildsau-mobile kernel:  [<c014718e>] =
shrink_cache+0x2ac/0x3c4
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0128ce7>] =
schedule_timeout+0x61/0xb2
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0128c7a>] =
process_timeout+0x0/0xc
Jul 17 12:35:58 wildsau-mobile kernel:  [<c011ce3e>] =
io_schedule_timeout+0x29/0x33
Jul 17 12:35:58 wildsau-mobile kernel:  [<c025b19c>] =
blk_congestion_wait_wq+0xab/0xb8
Jul 17 12:35:58 wildsau-mobile kernel:  [<c011dfd8>] =
autoremove_wake_function+0x0/0x4b
Jul 17 12:35:58 wildsau-mobile kernel:  [<c011dfd8>] =
autoremove_wake_function+0x0/0x4b
Jul 17 12:35:58 wildsau-mobile kernel:  [<c025b1c9>] =
blk_congestion_wait+0x20/0x24
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0147b68>] =
try_to_free_pages+0xc9/0x145
Jul 17 12:35:58 wildsau-mobile kernel:  [<c013fd65>] =
__alloc_pages+0x1c0/0x324
Jul 17 12:35:58 wildsau-mobile kernel:  [<c014227b>] =
do_page_cache_readahead+0x1bf/0x237
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0142428>] =
page_cache_readahead+0x135/0x172
Jul 17 12:35:58 wildsau-mobile kernel:  [<c013c355>] =
do_generic_mapping_read+0x467/0x475
Jul 17 12:35:58 wildsau-mobile kernel:  [<c017bb22>] =
__mark_inode_dirty+0x11a/0x11f
Jul 17 12:35:58 wildsau-mobile kernel:  [<c013c363>] =
file_read_actor+0x0/0xfc
Jul 17 12:35:58 wildsau-mobile kernel:  [<c013c631>] =
__generic_file_aio_read+0x1d2/0x20b
Jul 17 12:35:58 wildsau-mobile kernel:  [<c013c363>] =
file_read_actor+0x0/0xfc
Jul 17 12:35:58 wildsau-mobile kernel:  [<c013b853>] unlock_page+0x16/0x55
Jul 17 12:35:58 wildsau-mobile kernel:  [<c013c78d>] =
generic_file_read+0xba/0xd3
Jul 17 12:35:58 wildsau-mobile kernel:  [<c011dfd8>] =
autoremove_wake_function+0x0/0x4b
Jul 17 12:35:58 wildsau-mobile kernel:  [<c012872e>] =
update_wall_time+0xf/0x3a
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0128b88>] do_timer+0xc1/0xc6
Jul 17 12:35:58 wildsau-mobile kernel:  [<c0159424>] vfs_read+0xaf/0x119
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01596da>] sys_read+0x3f/0x5d
Jul 17 12:35:58 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:35:58 wildsau-mobile kernel:=20
Jul 17 12:36:38 wildsau-mobile kernel: 00   241      1           245   225 =
(NOTLB)
Jul 17 12:36:38 wildsau-mobile kernel: cf2fde58 00000082 00000039 00000000 =
00000000 c0379080 cfc49380 c037b880=20
Jul 17 12:36:38 wildsau-mobile kernel:        00000000 000000d0 00000000 =
000000d0 cf6426b0 00000000 7fffffff 00000001=20
Jul 17 12:36:38 wildsau-mobile kernel:        cf2fde94 c0128d36 00000246 =
00000246 cf08f500 cf2fdef4 cf1ad480 cf2fde94=20
Jul 17 12:36:38 wildsau-mobile kernel: Call Trace:
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:36:38 wildsau-mobile kernel:  [<d186c4b1>] do_poll+0x50/0x6e =
[apm]
Jul 17 12:36:38 wildsau-mobile kernel:  [<c016d750>] do_select+0x17a/0x2ba
Jul 17 12:36:38 wildsau-mobile kernel:  [<c016d44b>] __pollwait+0x0/0xaa
Jul 17 12:36:38 wildsau-mobile kernel:  [<c016dba3>] sys_select+0x2e8/0x51e
Jul 17 12:36:38 wildsau-mobile kernel:  [<c012872e>] =
update_wall_time+0xf/0x3a
Jul 17 12:36:38 wildsau-mobile kernel:  [<c012d415>] =
sys_rt_sigaction+0x8f/0x105
Jul 17 12:36:38 wildsau-mobile kernel:  [<c02b05c1>] =
sys_socketcall+0x156/0x27b
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:36:38 wildsau-mobile kernel:=20
Jul 17 12:36:38 wildsau-mobile kernel: apmiser       S 000000C0   245      =
1           251   241 (NOTLB)
Jul 17 12:36:38 wildsau-mobile kernel: cf03be58 00000082 00005682 000000c0 =
00000216 00b856c5 cfc49080 cf03a000=20
Jul 17 12:36:38 wildsau-mobile kernel:        cf03be58 00000246 c1285600 =
cf03be6c cf03d940 000192f5 cf03be6c 00000000=20
Jul 17 12:36:38 wildsau-mobile kernel:        cf03be94 c0128ce7 cf03be6c =
cc86d023 ffffffff c1285e9c c1285e9c 000192f5=20
Jul 17 12:36:38 wildsau-mobile kernel: Call Trace:
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0128ce7>] =
schedule_timeout+0x61/0xb2
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0128c7a>] =
process_timeout+0x0/0xc
Jul 17 12:36:38 wildsau-mobile kernel:  [<c016d750>] do_select+0x17a/0x2ba
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0228b95>] sprintf+0x1f/0x23
Jul 17 12:36:38 wildsau-mobile kernel:  [<c016d44b>] __pollwait+0x0/0xaa
Jul 17 12:36:38 wildsau-mobile kernel:  [<c016dba3>] sys_select+0x2e8/0x51e
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:36:38 wildsau-mobile kernel:=20
Jul 17 12:36:38 wildsau-mobile kernel: inetd         S C037B880   251      =
1           275   245 (NOTLB)
Jul 17 12:36:38 wildsau-mobile kernel: cf05be58 00000086 00000010 c037b880 =
00000000 000000d0 cf064b00 000000d0=20
Jul 17 12:36:38 wildsau-mobile kernel:        cefe8680 cf05bef4 cf05be4c =
c013feeb cf642080 00000000 7fffffff 00000005=20
Jul 17 12:36:38 wildsau-mobile kernel:        cf05be94 c0128d36 00000004 =
cf05be7c c02b494f cefe8680 cf377518 cf05bef4=20
Jul 17 12:36:38 wildsau-mobile kernel: Call Trace:
Jul 17 12:36:38 wildsau-mobile kernel:  [<c013feeb>] =
__get_free_pages+0x22/0x45
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:36:38 wildsau-mobile kernel:  [<c02b494f>] =
datagram_poll+0x2b/0xda
Jul 17 12:36:38 wildsau-mobile kernel:  [<c02aeed0>] sock_poll+0x29/0x30
Jul 17 12:36:38 wildsau-mobile kernel:  [<c016d750>] do_select+0x17a/0x2ba
Jul 17 12:36:38 wildsau-mobile kernel:  [<c016d44b>] __pollwait+0x0/0xaa
Jul 17 12:36:38 wildsau-mobile kernel:  [<c016dba3>] sys_select+0x2e8/0x51e
Jul 17 12:36:38 wildsau-mobile kernel:  [<c012cfc5>] =
do_sigaction+0x1e4/0x2cf
Jul 17 12:36:38 wildsau-mobile kernel:  [<c012d415>] =
sys_rt_sigaction+0x8f/0x105
Jul 17 12:36:38 wildsau-mobile kernel:  [<c012c247>] sigprocmask+0x61/0xf2
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:36:38 wildsau-mobile kernel:=20
Jul 17 12:36:38 wildsau-mobile kernel: sshd          S 000000D0   275      =
1   426     278   251 (NOTLB)
Jul 17 12:36:38 wildsau-mobile kernel: cf895e58 00000082 c1284c20 000000d0 =
cef19a80 cf895ef4 cfc49c80 c013feeb=20
Jul 17 12:36:38 wildsau-mobile kernel:        00000000 cf895e54 00000246 =
00000246 cf95ece0 00000000 7fffffff 00000004=20
Jul 17 12:36:38 wildsau-mobile kernel:        cf895e94 c0128d36 cf377318 =
cf895ef4 c0379410 cef17d1c c03bff80 00000008=20
Jul 17 12:36:38 wildsau-mobile kernel: Call Trace:
Jul 17 12:36:38 wildsau-mobile kernel:  [<c013feeb>] =
__get_free_pages+0x22/0x45
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:36:38 wildsau-mobile kernel:  [<c02aeed0>] sock_poll+0x29/0x30
Jul 17 12:36:38 wildsau-mobile kernel:  [<c016d750>] do_select+0x17a/0x2ba
Jul 17 12:36:38 wildsau-mobile kernel:  [<c016d44b>] __pollwait+0x0/0xaa
Jul 17 12:36:38 wildsau-mobile kernel:  [<c016dba3>] sys_select+0x2e8/0x51e
Jul 17 12:36:38 wildsau-mobile kernel:  [<c015a412>] __fput+0xd2/0x136
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:36:38 wildsau-mobile kernel:=20
Jul 17 12:36:38 wildsau-mobile kernel: rpc.nfsd      S 00000001   278      =
1           280   275 (NOTLB)
Jul 17 12:36:38 wildsau-mobile kernel: cefc9ef8 00000086 c1284c20 00000001 =
00000001 cf0f85d0 cf064200 cefc9efc=20
Jul 17 12:36:38 wildsau-mobile kernel:        c02ce805 cefe8280 ced04b98 =
cefc9fa0 cf03d310 00000000 7fffffff cefc9f58=20
Jul 17 12:36:38 wildsau-mobile kernel:        cefc9f34 c0128d36 c02aeed0 =
cefe8280 ced04b80 cefc9fa0 00000145 cefc9f34=20
Jul 17 12:36:38 wildsau-mobile kernel: Call Trace:
Jul 17 12:36:38 wildsau-mobile kernel:  [<c02ce805>] tcp_poll+0x36/0x190
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:36:38 wildsau-mobile kernel:  [<c02aeed0>] sock_poll+0x29/0x30
Jul 17 12:36:38 wildsau-mobile kernel:  [<c016de30>] do_pollfd+0x57/0x98
Jul 17 12:36:38 wildsau-mobile kernel:  [<c016df0f>] do_poll+0x9e/0xbd
Jul 17 12:36:38 wildsau-mobile kernel:  [<c016e0b3>] sys_poll+0x185/0x26a
Jul 17 12:36:38 wildsau-mobile kernel:  [<c016d44b>] __pollwait+0x0/0xaa
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:36:38 wildsau-mobile kernel:=20
Jul 17 12:36:38 wildsau-mobile kernel: rpc.mountd    S 00000001   280      =
1           287   278 (NOTLB)
Jul 17 12:36:38 wildsau-mobile kernel: cef01ef8 00000086 c1284c20 00000001 =
00000001 cf0f8650 cf064500 cef01efc=20
Jul 17 12:36:38 wildsau-mobile kernel:        c02ce805 cf0ff580 ced04598 =
cef01fa0 cf03c6b0 00000000 7fffffff cef01f58=20
Jul 17 12:36:38 wildsau-mobile kernel:        cef01f34 c0128d36 c02aeed0 =
cf0ff580 ced04580 cef01fa0 00000145 cef01f34=20
Jul 17 12:36:38 wildsau-mobile kernel: Call Trace:
Jul 17 12:36:38 wildsau-mobile kernel:  [<c02ce805>] tcp_poll+0x36/0x190
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:36:38 wildsau-mobile kernel:  [<c02aeed0>] sock_poll+0x29/0x30
Jul 17 12:36:38 wildsau-mobile kernel:  [<c016de30>] do_pollfd+0x57/0x98
Jul 17 12:36:38 wildsau-mobile kernel:  [<c016df0f>] do_poll+0x9e/0xbd
Jul 17 12:36:38 wildsau-mobile kernel:  [<c016e0b3>] sys_poll+0x185/0x26a
Jul 17 12:36:38 wildsau-mobile kernel:  [<c016d44b>] __pollwait+0x0/0xaa
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:36:38 wildsau-mobile kernel:=20
Jul 17 12:36:38 wildsau-mobile kernel: cupsd         S 00000001   287      =
1           417   280 (NOTLB)
Jul 17 12:36:38 wildsau-mobile kernel: ceecde58 00000082 c1284c20 00000001 =
00000001 ceecdef4 cf064c80 ceecc000=20
Jul 17 12:36:38 wildsau-mobile kernel:        ceecde58 00000246 c1285600 =
ceecde6c ceecf940 0001913a ceecde6c 00000003=20
Jul 17 12:36:38 wildsau-mobile kernel:        ceecde94 c0128ce7 ceecde6c =
ceecde7c c02b494f c1285e94 cf881f50 0001913a=20
Jul 17 12:36:38 wildsau-mobile kernel: Call Trace:
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0128ce7>] =
schedule_timeout+0x61/0xb2
Jul 17 12:36:38 wildsau-mobile kernel:  [<c02b494f>] =
datagram_poll+0x2b/0xda
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0128c7a>] =
process_timeout+0x0/0xc
Jul 17 12:36:38 wildsau-mobile kernel:  [<c016d750>] do_select+0x17a/0x2ba
Jul 17 12:36:38 wildsau-mobile kernel:  [<c016d44b>] __pollwait+0x0/0xaa
Jul 17 12:36:38 wildsau-mobile kernel:  [<c016dba3>] sys_select+0x2e8/0x51e
Jul 17 12:36:38 wildsau-mobile kernel:  [<c012872e>] =
update_wall_time+0xf/0x3a
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0110050>] =
timer_interrupt+0x82/0x178
Jul 17 12:36:38 wildsau-mobile kernel:  [<c010b74d>] =
handle_IRQ_event+0x39/0x62
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:36:38 wildsau-mobile kernel:=20
Jul 17 12:36:38 wildsau-mobile kernel: atd           S CEEEDEF8   417      =
1           420   287 (NOTLB)
Jul 17 12:36:38 wildsau-mobile kernel: ceeedef8 00000086 fffbc05c ceeedef8 =
c013303e ceeededc cfc49200 ceeec000=20
Jul 17 12:36:38 wildsau-mobile kernel:        ceeedef8 00000246 c1285600 =
ceeedf68 cf03c080 ceeec000 0036f0a5 00000000=20
Jul 17 12:36:38 wildsau-mobile kernel:        ceeedf94 c0133c91 ceeedf68 =
ceeedf18 00000000 ceeedf20 c04316e0 ceeec01c=20
Jul 17 12:36:38 wildsau-mobile kernel: Call Trace:
Jul 17 12:36:38 wildsau-mobile kernel:  [<c013303e>] =
adjust_abs_time+0xa5/0x10a
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0133c91>] =
do_clock_nanosleep+0x194/0x2ca
Jul 17 12:36:38 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:36:38 wildsau-mobile kernel:  [<c017198b>] dput+0x24/0x2ae
Jul 17 12:36:38 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:36:38 wildsau-mobile kernel:  [<c012d469>] =
sys_rt_sigaction+0xe3/0x105
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01338cc>] =
nanosleep_wake_up+0x0/0xc
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0133962>] =
sys_nanosleep+0x75/0xfa
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:36:38 wildsau-mobile kernel:=20
Jul 17 12:36:38 wildsau-mobile kernel: bash          S 00000001   420      =
1           421   417 (NOTLB)
Jul 17 12:36:38 wildsau-mobile kernel: cfbade3c 00000086 c1284c20 00000001 =
00000001 cfc4f000 cf064e00 cfbade5f=20
Jul 17 12:36:38 wildsau-mobile kernel:        00000017 00000017 cfc4f000 =
cfbadea4 cfc6a080 00000008 7fffffff 00000000=20
Jul 17 12:36:38 wildsau-mobile kernel:        cfbade78 c0128d36 00000017 =
746f6f72 6c697740 0000000e 00000202 c138c000=20
Jul 17 12:36:38 wildsau-mobile kernel: Call Trace:
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:36:38 wildsau-mobile kernel:  [<c023f888>] read_chan+0x284/0x92a
Jul 17 12:36:38 wildsau-mobile kernel:  [<c02400a4>] write_chan+0x176/0x247
Jul 17 12:36:38 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:36:38 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0239d7e>] tty_write+0x275/0x3fd
Jul 17 12:36:38 wildsau-mobile kernel:  [<c023f604>] read_chan+0x0/0x92a
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0239ac6>] tty_read+0x157/0x19a
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0159424>] vfs_read+0xaf/0x119
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01596da>] sys_read+0x3f/0x5d
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:36:38 wildsau-mobile kernel:=20
Jul 17 12:36:38 wildsau-mobile kernel: getty         S 00000296   421      =
1           422   420 (NOTLB)
Jul 17 12:36:38 wildsau-mobile kernel: cefb9e3c 00000082 c013c363 00000296 =
0000000a cefb9e24 cf064380 ffffffff=20
Jul 17 12:36:38 wildsau-mobile kernel:        00000000 00000020 cefb9e84 =
c024c7fe cf03cce0 00000008 7fffffff 00000000=20
Jul 17 12:36:38 wildsau-mobile kernel:        cefb9e78 c0128d36 cef2220a =
00000008 00000246 000000ff 00000282 40012000=20
Jul 17 12:36:38 wildsau-mobile kernel: Call Trace:
Jul 17 12:36:38 wildsau-mobile kernel:  [<c013c363>] =
file_read_actor+0x0/0xfc
Jul 17 12:36:38 wildsau-mobile kernel:  [<c024c7fe>] =
do_con_write+0x2ec/0x71f
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:36:38 wildsau-mobile kernel:  [<c023f888>] read_chan+0x284/0x92a
Jul 17 12:36:38 wildsau-mobile kernel:  [<c024d209>] con_write+0x36/0x42
Jul 17 12:36:38 wildsau-mobile kernel:  [<c02400a4>] write_chan+0x176/0x247
Jul 17 12:36:38 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:36:38 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0239d7e>] tty_write+0x275/0x3fd
Jul 17 12:36:38 wildsau-mobile kernel:  [<c023f604>] read_chan+0x0/0x92a
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0239ac6>] tty_read+0x157/0x19a
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0159424>] vfs_read+0xaf/0x119
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01596da>] sys_read+0x3f/0x5d
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:36:38 wildsau-mobile kernel:=20
Jul 17 12:36:38 wildsau-mobile kernel: getty         S 00000296   422      =
1           423   421 (NOTLB)
Jul 17 12:36:38 wildsau-mobile kernel: ceeafe3c 00000082 c013c363 00000296 =
0000000a ceeafe24 cf064080 ffffffff=20
Jul 17 12:36:38 wildsau-mobile kernel:        00000000 00000020 ceeafe84 =
c024c7fe ceecf310 00000008 7fffffff 00000000=20
Jul 17 12:36:38 wildsau-mobile kernel:        ceeafe78 c0128d36 cf35820a =
00000008 00000246 000000ff 00000282 40012000=20
Jul 17 12:36:38 wildsau-mobile kernel: Call Trace:
Jul 17 12:36:38 wildsau-mobile kernel:  [<c013c363>] =
file_read_actor+0x0/0xfc
Jul 17 12:36:38 wildsau-mobile kernel:  [<c024c7fe>] =
do_con_write+0x2ec/0x71f
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:36:38 wildsau-mobile kernel:  [<c023f888>] read_chan+0x284/0x92a
Jul 17 12:36:38 wildsau-mobile kernel:  [<c024d209>] con_write+0x36/0x42
Jul 17 12:36:38 wildsau-mobile kernel:  [<c02400a4>] write_chan+0x176/0x247
Jul 17 12:36:38 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:36:38 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0239d7e>] tty_write+0x275/0x3fd
Jul 17 12:36:38 wildsau-mobile kernel:  [<c023f604>] read_chan+0x0/0x92a
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0239ac6>] tty_read+0x157/0x19a
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0159424>] vfs_read+0xaf/0x119
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01596da>] sys_read+0x3f/0x5d
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:36:38 wildsau-mobile kernel:=20
Jul 17 12:36:38 wildsau-mobile kernel: getty         S 00000296   423      =
1           424   422 (NOTLB)
Jul 17 12:36:38 wildsau-mobile kernel: cee75e3c 00000086 c013c363 00000296 =
0000000a cee75e24 cf9e3e00 ffffffff=20
Jul 17 12:36:38 wildsau-mobile kernel:        00000000 00000020 cee75e84 =
c024c7fe ceecece0 00000008 7fffffff 00000000=20
Jul 17 12:36:38 wildsau-mobile kernel:        cee75e78 c0128d36 cf82120a =
00000008 00000246 000000ff 00000282 40012000=20
Jul 17 12:36:38 wildsau-mobile kernel: Call Trace:
Jul 17 12:36:38 wildsau-mobile kernel:  [<c013c363>] =
file_read_actor+0x0/0xfc
Jul 17 12:36:38 wildsau-mobile kernel:  [<c024c7fe>] =
do_con_write+0x2ec/0x71f
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:36:38 wildsau-mobile kernel:  [<c023f888>] read_chan+0x284/0x92a
Jul 17 12:36:38 wildsau-mobile kernel:  [<c024d209>] con_write+0x36/0x42
Jul 17 12:36:38 wildsau-mobile kernel:  [<c02400a4>] write_chan+0x176/0x247
Jul 17 12:36:38 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:36:38 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0239d7e>] tty_write+0x275/0x3fd
Jul 17 12:36:38 wildsau-mobile kernel:  [<c023f604>] read_chan+0x0/0x92a
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0239ac6>] tty_read+0x157/0x19a
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0159424>] vfs_read+0xaf/0x119
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01596da>] sys_read+0x3f/0x5d
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:36:38 wildsau-mobile kernel:=20
Jul 17 12:36:38 wildsau-mobile kernel: getty         S 00000296   424      =
1           425   423 (NOTLB)
Jul 17 12:36:38 wildsau-mobile kernel: ce987e3c 00000086 c013c363 00000296 =
0000000a ce987e24 cf9e3800 ffffffff=20
Jul 17 12:36:38 wildsau-mobile kernel:        00000000 00000020 ce987e84 =
c024c7fe ceece6b0 00000008 7fffffff 00000000=20
Jul 17 12:36:38 wildsau-mobile kernel:        ce987e78 c0128d36 cf26920a =
00000008 00000246 000000ff 00000282 40012000=20
Jul 17 12:36:38 wildsau-mobile kernel: Call Trace:
Jul 17 12:36:38 wildsau-mobile kernel:  [<c013c363>] =
file_read_actor+0x0/0xfc
Jul 17 12:36:38 wildsau-mobile kernel:  [<c024c7fe>] =
do_con_write+0x2ec/0x71f
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:36:38 wildsau-mobile kernel:  [<c023f888>] read_chan+0x284/0x92a
Jul 17 12:36:38 wildsau-mobile kernel:  [<c024d209>] con_write+0x36/0x42
Jul 17 12:36:38 wildsau-mobile kernel:  [<c02400a4>] write_chan+0x176/0x247
Jul 17 12:36:38 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:36:38 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0239d7e>] tty_write+0x275/0x3fd
Jul 17 12:36:38 wildsau-mobile kernel:  [<c023f604>] read_chan+0x0/0x92a
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0239ac6>] tty_read+0x157/0x19a
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0159424>] vfs_read+0xaf/0x119
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01596da>] sys_read+0x3f/0x5d
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:36:38 wildsau-mobile kernel:=20
Jul 17 12:36:38 wildsau-mobile kernel: getty         S 00000296   425      =
1           431   424 (NOTLB)
Jul 17 12:36:38 wildsau-mobile kernel: ce851e3c 00000082 c013c363 00000296 =
0000000a ce851e24 cf9e3980 ffffffff=20
Jul 17 12:36:38 wildsau-mobile kernel:        00000000 00000020 ce851e84 =
c024c7fe ceece080 00000008 7fffffff 00000000=20
Jul 17 12:36:38 wildsau-mobile kernel:        ce851e78 c0128d36 cf42d20a =
00000008 00000246 000000ff 00000282 40012000=20
Jul 17 12:36:38 wildsau-mobile kernel: Call Trace:
Jul 17 12:36:38 wildsau-mobile kernel:  [<c013c363>] =
file_read_actor+0x0/0xfc
Jul 17 12:36:38 wildsau-mobile kernel:  [<c024c7fe>] =
do_con_write+0x2ec/0x71f
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:36:38 wildsau-mobile kernel:  [<c023f888>] read_chan+0x284/0x92a
Jul 17 12:36:38 wildsau-mobile kernel:  [<c024d209>] con_write+0x36/0x42
Jul 17 12:36:38 wildsau-mobile kernel:  [<c02400a4>] write_chan+0x176/0x247
Jul 17 12:36:38 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:36:38 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0239d7e>] tty_write+0x275/0x3fd
Jul 17 12:36:38 wildsau-mobile kernel:  [<c023f604>] read_chan+0x0/0x92a
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0239ac6>] tty_read+0x157/0x19a
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0159424>] vfs_read+0xaf/0x119
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01596da>] sys_read+0x3f/0x5d
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:36:38 wildsau-mobile kernel:=20
Jul 17 12:36:38 wildsau-mobile kernel: sshd          S CE863D0C   426    =
275   428               (NOTLB)
Jul 17 12:36:38 wildsau-mobile kernel: ce863d1c 00000086 00000286 ce863d0c =
00000286 cf377918 cf064800 00000001=20
Jul 17 12:36:38 wildsau-mobile kernel:        00000000 cf377918 cfaf4e00 =
ce862000 ce865940 cfaf4500 7fffffff 7fffffff=20
Jul 17 12:36:38 wildsau-mobile kernel:        ce863d58 c0128d36 cfaf4e00 =
ce863d8c c0306ef4 cfaf4e00 0000005b 00000000=20
Jul 17 12:36:38 wildsau-mobile kernel: Call Trace:
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0306ef4>] =
unix_dgram_sendmsg+0x38e/0x5fd
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0307927>] =
unix_stream_data_wait+0xfe/0x161
Jul 17 12:36:38 wildsau-mobile kernel:  [<c011dfd8>] =
autoremove_wake_function+0x0/0x4b
Jul 17 12:36:38 wildsau-mobile kernel:  [<c011dfd8>] =
autoremove_wake_function+0x0/0x4b
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0307eec>] =
unix_stream_recvmsg+0x562/0x5d6
Jul 17 12:36:38 wildsau-mobile kernel:  [<c013fae4>] =
buffered_rmqueue+0xf0/0x1b1
Jul 17 12:36:38 wildsau-mobile kernel:  [<c02ae839>] =
sock_aio_read+0xd2/0xd9
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0159343>] do_sync_read+0xc2/0xf4
Jul 17 12:36:38 wildsau-mobile kernel:  [<c014a44f>] do_wp_page+0x1bf/0x348
Jul 17 12:36:38 wildsau-mobile kernel:  [<c014b4a4>] =
handle_mm_fault+0x184/0x1be
Jul 17 12:36:38 wildsau-mobile kernel:  [<c011dfd8>] =
autoremove_wake_function+0x0/0x4b
Jul 17 12:36:38 wildsau-mobile kernel:  [<c015945e>] vfs_read+0xe9/0x119
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01596da>] sys_read+0x3f/0x5d
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:36:38 wildsau-mobile kernel:=20
Jul 17 12:36:38 wildsau-mobile kernel: sshd          S 000000D0   428    =
426                     (NOTLB)
Jul 17 12:36:38 wildsau-mobile kernel: ce7b1e58 00000082 ceca3180 000000d0 =
cfc6c880 ce7b1ef4 cf064680 c013feeb=20
Jul 17 12:36:38 wildsau-mobile kernel:        00000000 ce7b1e54 00000246 =
00000246 ce865310 00000000 7fffffff 0000000c=20
Jul 17 12:36:38 wildsau-mobile kernel:        ce7b1e94 c0128d36 0000000b =
ce7b1e7c c03082b1 ce7e0d80 ce7d7d18 ce7b1ef4=20
Jul 17 12:36:38 wildsau-mobile kernel: Call Trace:
Jul 17 12:36:38 wildsau-mobile kernel:  [<c013feeb>] =
__get_free_pages+0x22/0x45
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:36:38 wildsau-mobile kernel:  [<c03082b1>] unix_poll+0x2b/0x9c
Jul 17 12:36:38 wildsau-mobile kernel:  [<c02aeed0>] sock_poll+0x29/0x30
Jul 17 12:36:38 wildsau-mobile kernel:  [<c016d750>] do_select+0x17a/0x2ba
Jul 17 12:36:38 wildsau-mobile kernel:  [<c016d44b>] __pollwait+0x0/0xaa
Jul 17 12:36:38 wildsau-mobile kernel:  [<c016dba3>] sys_select+0x2e8/0x51e
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:36:38 wildsau-mobile kernel:=20
Jul 17 12:36:38 wildsau-mobile kernel: xterm         S 000000D0   431      =
1   432     450   425 (NOTLB)
Jul 17 12:36:38 wildsau-mobile kernel: ce6f7e58 00000082 ceca3c00 000000d0 =
ce6bf680 ce6f7ef4 cf9e3080 c013feeb=20
Jul 17 12:36:38 wildsau-mobile kernel:        00000000 00000246 cf410000 =
ce6f7ef4 ce8646b0 00000000 7fffffff 00000005=20
Jul 17 12:36:38 wildsau-mobile kernel:        ce6f7e94 c0128d36 cf410000 =
cf41092c ce6f7ef4 cf410000 ce6bf280 00000004=20
Jul 17 12:36:38 wildsau-mobile kernel: Call Trace:
Jul 17 12:36:38 wildsau-mobile kernel:  [<c013feeb>] =
__get_free_pages+0x22/0x45
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0128d36>] =
schedule_timeout+0xb0/0xb2
Jul 17 12:36:38 wildsau-mobile kernel:  [<c023b4c8>] tty_poll+0x7d/0xa4
Jul 17 12:36:38 wildsau-mobile kernel:  [<c016d750>] do_select+0x17a/0x2ba
Jul 17 12:36:38 wildsau-mobile kernel:  [<c016d44b>] __pollwait+0x0/0xaa
Jul 17 12:36:38 wildsau-mobile kernel:  [<c016dba3>] sys_select+0x2e8/0x51e
Jul 17 12:36:38 wildsau-mobile kernel:  [<c02f4726>] inet_ioctl+0xd5/0xfe
Jul 17 12:36:38 wildsau-mobile kernel:  [<c02aecc5>] sock_ioctl+0x114/0x2f6
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:36:38 wildsau-mobile kernel:=20
Jul 17 12:36:38 wildsau-mobile kernel: bash          S 080D8D7C   432    =
431   436               (NOTLB)
Jul 17 12:36:38 wildsau-mobile kernel: ce40ff48 00000082 ce2c1cc0 080d8d7c =
00000001 00000001 cfc49980 ce2c1cc0=20
Jul 17 12:36:38 wildsau-mobile kernel:        00000000 00000011 00030002 =
00000246 ce864080 ce40e000 fffffe00 ce864080=20
Jul 17 12:36:38 wildsau-mobile kernel:        ce40ffbc c01233c3 ffffffff =
00000002 ce229940 ce40ff74 c01215a2 ce864120=20
Jul 17 12:36:38 wildsau-mobile kernel: Call Trace:
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01233c3>] sys_wait4+0x1d8/0x27f
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01215a2>] =
session_of_pgrp+0x37/0xb2
Jul 17 12:36:38 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:36:38 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:36:38 wildsau-mobile kernel:=20
Jul 17 12:36:38 wildsau-mobile kernel: bash          S 080D8CC8   436    =
432   460               (NOTLB)
Jul 17 12:36:38 wildsau-mobile kernel: ce239f48 00000082 ce2c1700 080d8cc8 =
00000001 00000001 cf064980 ce2c1700=20
Jul 17 12:36:38 wildsau-mobile kernel:        00000000 00000011 00030002 =
00000246 ce229940 ce238000 fffffe00 ce229940=20
Jul 17 12:36:38 wildsau-mobile kernel:        ce239fbc c01233c3 ffffffff =
00000002 ce2286b0 ce239f74 c01215a2 ce2299e0=20
Jul 17 12:36:38 wildsau-mobile kernel: Call Trace:
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01233c3>] sys_wait4+0x1d8/0x27f
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01215a2>] =
session_of_pgrp+0x37/0xb2
Jul 17 12:36:38 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:36:38 wildsau-mobile kernel:  [<c011ba53>] =
default_wake_function+0x0/0x2e
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:36:38 wildsau-mobile kernel:=20
Jul 17 12:36:38 wildsau-mobile kernel: pdflush       D 00000001   450      =
1           465   431 (L-TLB)
Jul 17 12:36:38 wildsau-mobile kernel: c5fe7e34 00000046 c1284c20 00000001 =
00000001 c5fe7e08 cf9e3b00 c5fe6000=20
Jul 17 12:36:38 wildsau-mobile kernel:        c5fe7e34 00000246 c1285600 =
c5fe7e48 ce228080 00018ffd c5fe7e48 00019da1=20
Jul 17 12:36:38 wildsau-mobile kernel:        c5fe7e70 c0128ce7 c5fe7e48 =
c0116c7e 00000000 c1285df4 c1285df4 00018ffd=20
Jul 17 12:36:38 wildsau-mobile kernel: Call Trace:
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0128ce7>] =
schedule_timeout+0x61/0xb2
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0116c7e>] =
smp_apic_timer_interrupt+0xd8/0x140
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0128c7a>] =
process_timeout+0x0/0xc
Jul 17 12:36:38 wildsau-mobile kernel:  [<c011ce3e>] =
io_schedule_timeout+0x29/0x33
Jul 17 12:36:38 wildsau-mobile kernel:  [<c025b19c>] =
blk_congestion_wait_wq+0xab/0xb8
Jul 17 12:36:38 wildsau-mobile kernel:  [<c011dfd8>] =
autoremove_wake_function+0x0/0x4b
Jul 17 12:36:38 wildsau-mobile kernel:  [<c011dfd8>] =
autoremove_wake_function+0x0/0x4b
Jul 17 12:36:38 wildsau-mobile kernel:  [<c025b1c9>] =
blk_congestion_wait+0x20/0x24
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0141142>] wb_kupdate+0x103/0x15a
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0141b35>] __pdflush+0x105/0x226
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0141c56>] pdflush+0x0/0x15
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0141c67>] pdflush+0x11/0x15
Jul 17 12:36:38 wildsau-mobile kernel:  [<c014103f>] wb_kupdate+0x0/0x15a
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0107329>] =
kernel_thread_helper+0x5/0xb
Jul 17 12:36:38 wildsau-mobile kernel:=20
Jul 17 12:36:38 wildsau-mobile kernel: elinos-rpm    R current    460    =
436                     (NOTLB)
Jul 17 12:36:38 wildsau-mobile kernel: 0003ec3f 0003ec40 0003ec41 0003ec42 =
c277d4e0 c86e5da8 c0214a20 c277d4e0=20
Jul 17 12:36:38 wildsau-mobile kernel:        00001000 c86e5e10 c7f1f580 =
00000000 00000000 00000000 00001000 00000000=20
Jul 17 12:36:38 wildsau-mobile kernel:        00000020 00000000 c86e5ca0 =
c86e5d08 c2df9978 c2df9018 15d00000 00000000=20
Jul 17 12:36:38 wildsau-mobile kernel: Call Trace:
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0214a20>] =
search_for_position_by_key+0x1ba/0x3e8
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01ff22e>] make_cpu_key+0x54/0x5e
Jul 17 12:36:38 wildsau-mobile kernel:  [<c010b74d>] =
handle_IRQ_event+0x39/0x62
Jul 17 12:36:38 wildsau-mobile kernel:  [<c010bb0e>] do_IRQ+0xd7/0x1d8
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0109e68>] =
common_interrupt+0x18/0x20
Jul 17 12:36:38 wildsau-mobile kernel:  [<c02297e4>] =
__copy_from_user_ll+0x4e/0x76
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0205b99>] =
reiserfs_copy_from_user_to_file_region+0xb9/0xfa
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0206dd0>] =
reiserfs_file_write+0x497/0x69c
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0159631>] vfs_write+0xaf/0x119
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0159737>] sys_write+0x3f/0x5d
Jul 17 12:36:38 wildsau-mobile kernel:  [<c01094fb>] syscall_call+0x7/0xb
Jul 17 12:36:38 wildsau-mobile kernel:=20
Jul 17 12:36:38 wildsau-mobile kernel: pdflush       S C0373558   465      =
1                 450 (L-TLB)
Jul 17 12:36:38 wildsau-mobile kernel: c6445fa4 00000046 c037701c c0373558 =
00000008 c6444000 cf9e3b00 c6445fa4=20
Jul 17 12:36:38 wildsau-mobile kernel:        c0121ae1 ce228ce0 c6445f98 =
00000000 ce228ce0 c6445fd8 c6445fcc c6444000=20
Jul 17 12:36:38 wildsau-mobile kernel:        c6445fc0 c0141adb c032ff55 =
c6444000 c0141c56 00000000 00000000 c6445fec=20
Jul 17 12:36:38 wildsau-mobile kernel: Call Trace:
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0121ae1>] daemonize+0xd2/0xd8
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0141adb>] __pdflush+0xab/0x226
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0141c56>] pdflush+0x0/0x15
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0141c67>] pdflush+0x11/0x15
Jul 17 12:36:38 wildsau-mobile kernel:  [<c0107329>] =
kernel_thread_helper+0x5/0xb
Jul 17 12:36:38 wildsau-mobile kernel:=20
Jul 17 12:37:42 wildsau-mobile kernel: spurious 8259A interrupt: IRQ7.

--==========1899649384==========--

