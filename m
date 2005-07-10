Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbVGJKwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVGJKwl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 06:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVGJKwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 06:52:41 -0400
Received: from nysv.org ([213.157.66.145]:59797 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S261886AbVGJKwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 06:52:40 -0400
Date: Sun, 10 Jul 2005 13:51:56 +0300
To: Pauli Borodulin <pauli.borodulin@uta.fi>
Cc: linux-poweredge@dell.com, linux-kernel@vger.kernel.org,
       linux-usb-devel@vger.kernel.org
Subject: Re: DRAC4 oddness and questions
Message-ID: <20050710105156.GG11013@nysv.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FPT3HoKoCv7j0oWb"
Content-Disposition: inline
In-Reply-To: <42CE88B7.3070501@uta.fi>
User-Agent: Mutt/1.5.9i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FPT3HoKoCv7j0oWb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Graa, I reinserted the mailing lists there to the CCs, it may
be good for those guys too to be able to share whatever
hints they may have :P

On Fri, Jul 08, 2005 at 05:07:51PM +0300, Pauli Borodulin wrote:
>>It's a lot better than the VGA console which requires me
>>to plug in the 100MBps connection at the office, until
>>I get around to looking into a VNC connection which is
>>still mostly useless if telnet would work.
>
>Nice connection you have there. We're using the DRAC4 web management for=
=20
>graphical remote console access, and it works quite nicely even over=20

As do we.
And that's a placebo effect for sure, the wlan should be able to
handle this ;)

>10Mbps. And hey, anyways, you only need it in some special occasions. I=20
>haven't seen any problems with USB. We are only using 32-bit.

I'm just mystified that an identical setup works.

I figured I'd upgrade the DRAC 4/I bios, as 1.20 is installed
and 1.30 is out, for what it's worth, but Red Hat seems to ship
some el mysterioso lockfile thing that I have to find somewhere...

>There are some nasty 64-bit problems in Linux. I wouldn't be surprised=20
>if it's the reason for your grief. Some Opteron people are depressed=20
>with the situation.

Perfect.

>I read the file=20
>http://mjt.nysv.org/kernelbugfest/netconsole_panic_2.6.12.2 thru'. Do=20
>you have some kind of watchdog enabled? I have seen the "NMI Watchdog=20
>detected LOCKUP on CPU0" message during bootup as a symptom for broken=20
>watchdog stuff on 64-bit x86 servers. Try "nmi_watchdog=3D0" as kernel=20

Maybe I should clean the kernel conf up a bit, but nmi_watchdog=3D0
if it disables everythin a-ok didn't help :P

>parameter. If that doesn't help, try disabling all watchdogs from the=20
>kernel. Also you could try adding "noapic" as kernel parameter on boot.=20
>Collect some output and report back :-)

noapic and friends didn't help.

http://mjt.nysv.org/kernelbugfest/usb_bug_2_2.6.12.2
http://mjt.nysv.org/kernelbugfest/usb_bug_2_2.6.12.2.ksymoops

What does the old poke_blanked_console refer to?
I just rebooted the box with console=3DttyS0,9600 as well (removed
above) and I still didn't see any issues.

Am I to assume pci=3Drouteirq is truly so deprecated I shouldn't
bother with it even?

What's up with nmi_watchdog=3D0 and testing NMI watchdog ... CPU#0: NMI app=
ears
to be stuck (0->0)! anyway?

Any hints on why the telnet interface spews only =E0 at me after grub,
that or nothing?

I'd _really_ hate to launch these boxes 32-bit or without
working remote administration, so I'll still do a bit more
work but this is starting to suck :>

I'm sure no one has any guarantees this'll just be fixed in the
future and I can launch with 64 bits and schedule a reboot
later on...

Thanks!

And here's the ksymoops-decoded output:

ksymoops 2.4.9 on x86_64 2.6.12.2-amd64.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.12.2-amd64/ (default)
     -m /boot/System.map-2.6.12.2-amd64 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -16 cycles, maxerr 1300 cycle=
s)
CPU 2: Syncing TSC to CPU 0.
CPU 2: synchronized TSC with CPU 0 (last diff 3 cycles, maxerr 867 cycles)
CPU 3: Syncing TSC to CPU 0.
testing NMI watchdog ... <6>CPU 3: synchronized TSC with CPU 0 (last diff 0=
 cycles, maxerr 1326 cycles)
CPU#0: NMI appears to be stuck (0->0)!
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
e100: Intel(R) PRO/100 Network Driver, 3.4.8-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
Kernel BUG at "arch/x86_64/kernel/traps.c":338
invalid operand: 0000 [1] SMP=20
CPU 0=20
Pid: 1227, comm: khubd Not tainted 2.6.12.2-amd64
RIP: 0010:[<ffffffff8010ff66>] <ffffffff8010ff66>{out_of_line_bug+0}
Using defaults from ksymoops -t elf64-x86-64 -a i386:x86-64
RSP: 0018:ffff81013b27fbc0  EFLAGS: 00010206
RAX: ffffffff00000000 RBX: ffff81013acbebc0 RCX: 0000000000000040
RDX: 000000013fd3a100 RSI: ffff8100bfdd4870 RDI: ffff81013acbebc0
RBP: 000000013fd3a0c0 R08: 0000000000000000 R09: 00000000000003e8
R10: 0000000000000000 R11: 0000000000000002 R12: ffff81013d8b5000
R13: ffff81013e354468 R14: 0000000000000296 R15: 0000000000000010
FS:  00002aaaaae00640(0000) GS:ffffffff80637e80(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaab040720 CR3: 0000000000101000 CR4: 00000000000006e0
Stack: ffffffff8800fffb 0000000000000296 ffff81013acbebc0 ffff81013e354400=
=20
       0000000000000002 0000000000000010 0000000000000000 0000000080000080=
=20
       ffffffff88010fd1 ffffffff8801bd00=20
Call Trace:<ffffffff8800fffb>{:usbcore:hcd_submit_urb+492} <ffffffff88010fd=
1>{:usbcore:usb_submit_urb+847}
       <ffffffff88011219>{:usbcore:usb_start_wait_urb+88} <ffffffff80131a40=
>{printk+141}
       <ffffffff880113c6>{:usbcore:usb_internal_control_msg+137}
       <ffffffff88011484>{:usbcore:usb_control_msg+143} <ffffffff8800d596>{=
:usbcore:hub_port_init+643}
       <ffffffff8024ab8d>{kobject_get+18} <ffffffff8800dcbb>{:usbcore:hub_p=
ort_connect_change+535}
       <ffffffff8800e308>{:usbcore:hub_events+1038} <ffffffff8800e443>{:usb=
core:hub_thread+37}
       <ffffffff801461fd>{autoremove_wake_function+0} <ffffffff801461fd>{au=
toremove_wake_function+0}
       <ffffffff8010f45b>{child_rip+8} <ffffffff8800e41e>{:usbcore:hub_thre=
ad+0}
       <ffffffff8010f453>{child_rip+0}=20
Code: 0f 0b f9 d7 3f 80 ff ff ff ff 52 01 c3 53 e8 2a 99 00 00 89=20


>>RIP; ffffffff8010ff66 <out_of_line_bug+0/d>   <=3D=3D=3D=3D=3D

Trace; ffffffff8800fffb <_end+7999ffb/7ef8a000>
Trace; ffffffff88011219 <_end+799b219/7ef8a000>
Trace; ffffffff880113c6 <_end+799b3c6/7ef8a000>
Trace; ffffffff88011484 <_end+799b484/7ef8a000>
Trace; ffffffff8024ab8d <kobject_get+12/17>
Trace; ffffffff8800e308 <_end+7998308/7ef8a000>
Trace; ffffffff801461fd <autoremove_wake_function+0/2e>
Trace; ffffffff8010f45b <child_rip+8/11>
Trace; ffffffff8010f453 <child_rip+0/11>

Code;  ffffffff8010ff66 <out_of_line_bug+0/d>
0000000000000000 <_RIP>:
Code;  ffffffff8010ff66 <out_of_line_bug+0/d>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  ffffffff8010ff68 <out_of_line_bug+2/d>
   2:   f9                        stc   =20
Code;  ffffffff8010ff69 <out_of_line_bug+3/d>
   3:   d7                        xlat   %ds:(%ebx)
Code;  ffffffff8010ff6a <out_of_line_bug+4/d>
   4:   3f                        (bad) =20
Code;  ffffffff8010ff6b <out_of_line_bug+5/d>
   5:   80 ff ff                  cmp    $0xff,%bh
Code;  ffffffff8010ff6e <out_of_line_bug+8/d>
   8:   ff                        (bad) =20
Code;  ffffffff8010ff6f <out_of_line_bug+9/d>
   9:   ff 52 01                  callq  *0x1(%rdx)
Code;  ffffffff8010ff72 <out_of_line_bug+c/d>
   c:   c3                        retq  =20
Code;  ffffffff8010ff73 <oops_begin+0/54>
   d:   53                        push   %rbx
Code;  ffffffff8010ff74 <oops_begin+1/54>
   e:   e8 2a 99 00 00            callq  993d <_RIP+0x993d>
Code;  ffffffff8010ff79 <oops_begin+6/54>
  13:   89 00                     mov    %eax,(%rax)

e1000: eth0: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex

1 warning and 1 error issued.  Results may not be reliable.

--=20
mjt


--FPT3HoKoCv7j0oWb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFC0P3MIqNMpVm8OhwRAubOAKDR6SdjVkoa3vn+FaDnsVfYakZwrwCeMF7G
EjI1nm4EGqr3NYoLzH9TwR4=
=cSpp
-----END PGP SIGNATURE-----

--FPT3HoKoCv7j0oWb--
