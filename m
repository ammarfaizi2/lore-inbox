Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264644AbTANSlp>; Tue, 14 Jan 2003 13:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264956AbTANSlo>; Tue, 14 Jan 2003 13:41:44 -0500
Received: from 24-216-100-96.charter.com ([24.216.100.96]:16798 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id <S264644AbTANSlm>;
	Tue, 14 Jan 2003 13:41:42 -0500
Date: Tue, 14 Jan 2003 13:50:33 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Oops on server that just started hanging and crashing
Message-ID: <20030114185033.GA20921@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Ok, after some data collection since (didn't know only the box in
question could decode an oops...):

System panic'd and has started hanging without a visual panic:

Dual-amd 1.5Ghz
512Meg Ram
3Ware IDE RAID controller
  16x160Gig disks, Making up 4 RAID5 arrays



ksymoops 2.3.4 on i686 2.4.19-ac4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-ac4/ (default)
     -m /boot/System.map-2.4.19-ac4 (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod f=
ile?
Warning (compare_maps): ksyms_base symbol __wake_up_sync_R__ver___wake_up_s=
ync not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol i2o_sys_init_R__ver_i2o_sys_init =
not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol idle_cpu_R__ver_idle_cpu not foun=
d in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol set_cpus_allowed_R__ver_set_cpus_=
allowed not found in System.map.  Ignoring ksyms_base entry
invalid operand: 0000
CPU:    1
EIP:    0010:[<c02b700b>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000002b   ebx: c020f938   ecx: 00000001   edx: 00000001
esi: 0000001a   edi: 00000020   ebp: c16e3560   esp: dffe9ea4
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=3Ddffe9000)
Stack: c039e240 c020f938 0000189d 0000189d c16e3400 df04ea40 c020f940
df04ea40
  0000189d c020f938 00000020 c16e3400 00000040 0000e401 0000189d
00000020         00000001 0000001f c842b89d 00001000 c020f170 c16e3400
df3249c0 04000001
Call Trace:    [<c020f938>] [<c020f940>] [<c020f938>] [<c020f170>]
[<c010a461>]   [<c010a656>] [<c0106df0>] [<c010cc88>] [<c0106df0>]
[<c0106e1c>] [<c0106e79>]
  [<c011abe9>] [<c011ae7f>]
Code: 0f 0b 5c 00 60 e2 39 c0 83 c4 14 5b c3 90 8d b4 26 00 00 00

>>EIP; c02b700b <skb_over_panic+2b/40>   <=3D=3D=3D=3D=3D
Trace; c020f938 <boomerang_rx+258/430>
Trace; c020f940 <boomerang_rx+260/430>
Trace; c020f938 <boomerang_rx+258/430>
Trace; c020f170 <boomerang_interrupt+130/3d0>
Trace; c010a461 <handle_IRQ_event+51/80>
Trace; c010a656 <do_IRQ+a6/f0>
Trace; c0106df0 <default_idle+0/40>
Trace; c010cc88 <call_do_IRQ+5/d>
Trace; c0106df0 <default_idle+0/40>
Trace; c0106e1c <default_idle+2c/40>
Trace; c0106e79 <cpu_idle+29/40>
Trace; c011abe9 <call_console_drivers+d9/e0>
Trace; c011ae7f <release_console_sem+8f/a0>
Code;  c02b700b <skb_over_panic+2b/40>
00000000 <_EIP>:
Code;  c02b700b <skb_over_panic+2b/40>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c02b700d <skb_over_panic+2d/40>
   2:   5c                        pop    %esp
Code;  c02b700e <skb_over_panic+2e/40>
   3:   00 60 e2                  add    %ah,0xffffffe2(%eax)
Code;  c02b7011 <skb_over_panic+31/40>
   6:   39 c0                     cmp    %eax,%eax
Code;  c02b7013 <skb_over_panic+33/40>
   8:   83 c4 14                  add    $0x14,%esp
Code;  c02b7016 <skb_over_panic+36/40>
   b:   5b                        pop    %ebx
Code;  c02b7017 <skb_over_panic+37/40>
   c:   c3                        ret   =20
Code;  c02b7018 <skb_over_panic+38/40>
   d:   90                        nop   =20
Code;  c02b7019 <skb_over_panic+39/40>
   e:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi

<0>Kernel panic: Aiee, killing interrupt handler!

5 warnings issued.  Results may not be reliable.



:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | PGP Key ID: FC96D405
                              =20
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.
FYI:
 perl -e 'print $i=3Dpack(c5,(41*2),sqrt(7056),(unpack(c,H)-2),oct(115),10)=
;'


--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+JFv5PvY/pfyW1AURAiwTAJkBYbFThGxWszkNRsUYlsF0w1aJMACfcp06
bo04UI0kQSQa1glFlG2kP/Q=
=xeTK
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
