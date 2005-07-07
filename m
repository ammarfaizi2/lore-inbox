Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVGGJXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVGGJXg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 05:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVGGJXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 05:23:36 -0400
Received: from nysv.org ([213.157.66.145]:42908 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S261192AbVGGJXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 05:23:35 -0400
Date: Thu, 7 Jul 2005 12:22:58 +0300
To: linux-kernel@vger.kernel.org, linux-usb-devel@vger.kernel.org
Subject: USB bugs in 2.6.11.8, 2.6.11.10 and 2.6.12.2
Message-ID: <20050707092258.GA11013@nysv.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PsEZZJjWpOB92CxQ"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PsEZZJjWpOB92CxQ
Content-Type: multipart/mixed; boundary="yQrIXZbGokyKU1X6"
Content-Disposition: inline


--yQrIXZbGokyKU1X6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I got some weird badness on two Dell PowerEdge 2850 (64-bit SMP Xeon)
boxes. One of them is all identical with one that runs ok, so I
attached that one's ksymoops information in this message.

The one that works just fine was installed locally (iirc) so this
may be an issue with Dell's Remote Administration Console's
VGA console redirection and its emulation of USB for input, maybe?

My first guess was just hardware failure, but it's a bit unlikely
on two boxes, especially now that I installed the boxes with a 32-bit
kernel and everything's fine.

Needless to say both I and the customer would want the 64-bit
one working :)

The boxes are situated some 3000km from here so getting hard
forensics is kind of hard, but the Dell system can do a bit,
so please let me know ASAP if there's something more I can
try out.

Any ideas on why box number one works but these two don't?
"Sunspots and lunar positions" is not a good theory ;)

I put up everything I could easily dig out on
http://mjt.nysv.org/kernelbugfest/

It's just that the boxes don't boot far, as they get stuck in
that suspend/wakeup loop, so there's only one really complete
oops decode there from the identical working setup.

Thanks!

--=20
mjt


--yQrIXZbGokyKU1X6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usb_bug_2.6.11.8-ck7s.ksymoops"
Content-Transfer-Encoding: quoted-printable

ksymoops 2.4.9 on x86_64 2.6.11.8-ck7server-smpnice2-em64t.  Options used
     -V (default)
     -k /proc/kallsyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.6.11.8-ck7server-smpnice2-em64t/ (default)
     -m /boot/System.map-2.6.11.8-ck7server-smpnice2-em64t (default)

Warning (read_ksyms): no kernel symbols in ksyms, is /proc/kallsyms a valid=
 ksyms file?
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Kernel BUG at traps:324
invalid operand: 0000 [1] SMP=20
CPU 1=20
Pid: 633, comm: khubd Not tainted 2.6.11.8-ck7server-smpnice2-em64t
RIP: 0010:[<ffffffff8010fa0a>] <ffffffff8010fa0a>{out_of_line_bug+0}
Using defaults from ksymoops -t elf64-x86-64 -a i386:x86-64
RSP: 0018:ffff81013e725bd0  EFLAGS: 00010206
RAX: ffffffff00000000 RBX: ffff8100062841c0 RCX: 0000000000000040
RDX: 000000013f711780 RSI: ffff8100bfd58070 RDI: ffff8100062841c0
RBP: 000000013f711740 R08: 0000000000000040 R09: 00000000000003e8
R10: 0000000000000000 R11: 0000000000000002 R12: ffff810138e9fc00
R13: 0000000000000292 R14: ffff81013a125468 R15: 0000000000000010
FS:  00002aaaaae00640(0000) GS:ffffffff805fc200(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaaac6c640 CR3: 000000013a8b3000 CR4: 00000000000006e0
Stack: ffffffff8800fd7a 0000000300000000 <4>ffff8100062841c0 ffff81013a1254=
00=20
0000000000000002 <4>0000000000000010 uhci_hcd 0000:00:1d.2: irq 18, io base=
 0xbca0
0000000000000000 <4>0000000080000080=20
       ffffffff8801088d uhci_hcd 0000:00:1d.2: new USB bus registered, assi=
gned bus number 3
ffffffff805b8343 <4>
Call Trace:uhci_hcd 0000:00:1d.2: detected 2 ports
<ffffffff8800fd7a>{:usbcore:hcd_submit_urb+460}<4> usb usb3: new device str=
ings: Mfr=3D3, Product=3D2, SerialNumber=3D1
<ffffffff8801088d>{:usbcore:usb_submit_urb+847}<4>=20
<ffffffff88010ad5>{:usbcore:usb_start_wait_urb+88}<4>=20
<ffffffff80124f27>{vprintk+323}<4> <ffffffff80124ddc>{printk+141}=20
<ffffffff88010c55>{:usbcore:usb_internal_control_msg+137}usb usb3: hotplug
<ffffffff88010d13>{:usbcore:usb_control_msg+143}<4> usb 3-0:1.0: hotplug
<ffffffff8800d53f>{:usbcore:hub_port_init+627}<4>=20
<ffffffff8023711d>{kobject_get+18}<4> hub 3-0:1.0: USB hub found
<ffffffff8800dc4f>{:usbcore:hub_port_connect_change+535}<4>=20
<4><ffffffff8800e249>{:usbcore:hub_events+955}<4> hub 3-0:1.0: individual p=
ort over-current protection
<ffffffff8800e37d>{:usbcore:hub_thread+37}<4>=20
<ffffffff80139509>{autoremove_wake_function+0}<4> hub 3-0:1.0: local power =
source is good
<ffffffff8011e999>{finish_task_switch+64}=20
       <ffffffff80139509>{autoremove_wake_function+0} <ffffffff8011ea00>{sc=
hedule_tail+17}=20
       <ffffffff8010eeb3>{child_rip+8} <ffffffff8800e358>{:usbcore:hub_thre=
ad+0}=20
       <ffffffff8010eeab>{child_rip+0}=20
Code: 0f 0b a3 fd 3d 80 ff ff ff ff 44 01 c3 8b 35 87 60 4a 00 53=20


>>RIP; ffffffff8010fa0a <out_of_line_bug+0/d>   <=3D=3D=3D=3D=3D

Trace; ffffffff8800fd7a <_end+79d9d7a/7efca000>
Trace; ffffffff8801088d <_end+79da88d/7efca000>
Trace; ffffffff88010ad5 <_end+79daad5/7efca000>
Trace; ffffffff80124f27 <vprintk+143/14a>
Trace; ffffffff88010c55 <_end+79dac55/7efca000>
Trace; ffffffff88010d13 <_end+79dad13/7efca000>
Trace; ffffffff8800d53f <_end+79d753f/7efca000>
Trace; ffffffff8023711d <kobject_get+12/17>
Trace; ffffffff8800dc4f <_end+79d7c4f/7efca000>
Trace; ffffffff8800e249 <_end+79d8249/7efca000>
Trace; ffffffff8800e37d <_end+79d837d/7efca000>
Trace; ffffffff80139509 <autoremove_wake_function+0/2e>
Trace; ffffffff8011e999 <finish_task_switch+40/96>
Trace; ffffffff80139509 <autoremove_wake_function+0/2e>
Trace; ffffffff8010eeb3 <child_rip+8/11>
Trace; ffffffff8010eeab <child_rip+0/11>

Code;  ffffffff8010fa0a <out_of_line_bug+0/d>
0000000000000000 <_RIP>:
Code;  ffffffff8010fa0a <out_of_line_bug+0/d>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  ffffffff8010fa0c <out_of_line_bug+2/d>
   2:   a3 fd 3d 80 ff ff ff      mov    %eax,0x44ffffffff803dfd
Code;  ffffffff8010fa13 <out_of_line_bug+9/d>
   9:   ff 44=20
Code;  ffffffff8010fa15 <out_of_line_bug+b/d>
   b:   01 c3                     add    %eax,%ebx
Code;  ffffffff8010fa17 <oops_begin+0/91>
   d:   8b 35 87 60 4a 00         mov    4874375(%rip),%esi        # 4a609a=
 <_RIP+0x4a609a>
Code;  ffffffff8010fa1d <oops_begin+6/91>
  13:   53                        push   %rbx

Call Trace:<ffffffff80275f7d>{poke_blanked_console+63} <ffffffff802750a5>{v=
t_console_print+715}=20
       <ffffffff80124ad3>{__call_console_drivers+71} <ffffffff80124c23>{cal=
l_console_drivers+232}=20
       <ffffffff80125013>{release_console_sem+90} <ffffffff80124f16>{vprint=
k+306}=20
       <ffffffff80124ddc>{printk+141} <ffffffff88010d1d>{:usbcore:usb_contr=
ol_msg+153}=20
       <ffffffff8800b400>{:usbcore:get_hub_status+72} <ffffffff88011a4f>{:u=
sbcore:usb_get_status+130}=20
       <ffffffff8800b9d2>{:usbcore:hub_hub_status+46} <ffffffff8800c0d1>{:u=
sbcore:hub_configure+1672}=20
       <ffffffff8800c563>{:usbcore:hub_probe+402} <ffffffff8800a0d2>{:usbco=
re:usb_probe_interface+204}=20
       <ffffffff80281ef6>{driver_probe_device+78} <ffffffff80281f78>{device=
_attach+84}=20
       <ffffffff8028224b>{bus_add_device+97} <ffffffff80281198>{device_add+=
149}=20
       <ffffffff88012432>{:usbcore:usb_set_configuration+984}=20
       <ffffffff80195c04>{sysfs_make_dirent+41} <ffffffff8800ccc2>{:usbcore=
:usb_new_device+369}=20
       <ffffffff8800f6e4>{:usbcore:usb_register_root_hub+241}=20
       <ffffffff88046294>{:ehci_hcd:ehci_start+1105} <ffffffff8801848f>{:us=
bcore:usbfs_add_bus+176}=20
       <ffffffff88014734>{:usbcore:usb_hcd_pci_probe+1220}=20
       <ffffffff8023fa2f>{pci_device_probe_static+62} <ffffffff8023fa7d>{__=
pci_device_probe+42}=20
       <ffffffff8023facd>{pci_device_probe+48} <ffffffff80281ef6>{driver_pr=
obe_device+78}=20
       <ffffffff80282002>{driver_attach+69} <ffffffff8028247f>{bus_add_driv=
er+140}=20
       <ffffffff8023fd3b>{pci_register_driver+132} <ffffffff8013d5c2>{sys_i=
nit_module+299}=20
       <ffffffff8010e1d6>{system_call+126}=20
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; ffffffff80275f7d <poke_blanked_console+3f/be>
Trace; ffffffff80124ad3 <__call_console_drivers+47/55>
Trace; ffffffff80125013 <release_console_sem+5a/df>
Trace; ffffffff80124ddc <printk+8d/95>
Trace; ffffffff8800b400 <_end+79d5400/7efca000>
Trace; ffffffff8800b9d2 <_end+79d59d2/7efca000>
Trace; ffffffff8800c563 <_end+79d6563/7efca000>
Trace; ffffffff80281ef6 <driver_probe_device+4e/7c>
Trace; ffffffff8028224b <bus_add_device+61/a4>
Trace; ffffffff88012432 <_end+79dc432/7efca000>
Trace; ffffffff80195c04 <sysfs_make_dirent+29/a2>
Trace; ffffffff8800f6e4 <_end+79d96e4/7efca000>
Trace; ffffffff88046294 <_end+7a10294/7efca000>
Trace; ffffffff88014734 <_end+79de734/7efca000>
Trace; ffffffff8023fa2f <pci_device_probe_static+3e/62>
Trace; ffffffff8023facd <pci_device_probe+30/50>
Trace; ffffffff80282002 <driver_attach+45/7f>
Trace; ffffffff8023fd3b <pci_register_driver+84/a4>
Trace; ffffffff8010e1d6 <system_call+7e/83>


2 warnings issued.  Results may not be reliable.

--yQrIXZbGokyKU1X6--

--PsEZZJjWpOB92CxQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCzPRyIqNMpVm8OhwRAu4zAKCIXMt4NWzJnu087tUrel4ji1WOwgCdHONs
y1Ob6gsZ1aytWwke+gY/7bo=
=x/0E
-----END PGP SIGNATURE-----

--PsEZZJjWpOB92CxQ--
