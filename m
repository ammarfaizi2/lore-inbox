Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbTEKNsD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 09:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbTEKNsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 09:48:03 -0400
Received: from mta11.srv.hcvlny.cv.net ([167.206.5.46]:44182 "EHLO
	mta11.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261414AbTEKNr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 09:47:58 -0400
Date: Sun, 11 May 2003 10:00:36 -0400
From: Mace Moneta <mmoneta@optonline.net>
Subject: Re: [bug] 2.4.21-rc2 kernel panic USB sched.c:564
In-reply-to: <20030511054554.GB7729@kroah.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Reply-to: mmoneta@optonline.net
Message-id: <1052661635.30223.26.camel@optonline.net>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5)
Content-type: multipart/signed; boundary="=-kQKrGirzitEHHe7UcWi/";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <1052600695.12657.4.camel@optonline.net>
 <20030511054554.GB7729@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kQKrGirzitEHHe7UcWi/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-05-11 at 01:45, Greg KH wrote:
> On Sat, May 10, 2003 at 05:04:56PM -0400, Mace Moneta wrote:
> > When Attempting to sync a Handspring Visor (PalmOS USB device), I
> > sometimes (about 1 time out of 4) get the following panic. =20
>=20
> can you run that oops through ksymoops so that we can see where it died
> at?
>=20
> thanks,
>=20
> greg k-h

Here you go:

ksymoops 2.4.5 on i686 2.4.21-rc2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-rc2/ (default)
     -m /boot/System.map-2.4.21-rc2 (default)
=20
Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.
=20
Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
ksymoops: No such file or directory
Warning (map_ksym_to_module): cannot match loaded module ext3 to a unique m=
odule object.  Trace may not be reliable.
kernel BUG at sched.c:564!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0117811>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000018   ebx: d8c90ce0   ecx: dd1ba000   edx: dd1bbf7c
esi: c02b6000   edi: d8c90ce8   epb: c02b7d7c   esp: c02b7d54
Warning (Oops_set_regs): garbage 'epb: c02b7d7c   esp: c02b7d54 ' at end of=
 register line ignored
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=3Dc02b7000) Stack: c024d76a de13d980
dfca2680 e1da294f c02b6000 00000000 01a6010b d8c90ce0
       c02b6000 d8c90ce8 c02b7d84 c0107c4a 00000001 c02b6000 d8c90ce8
       d8c90ce8 d8c90c88 d8c90ce0 d8c90c00 ffffffea c0107da4 d8c90ce0
       d8c90c00 ffffffed
Call Trace:    [<e1da294f>] [<c0107c4a>] [<c0107da4>] [<e3235a73>] [<e3235c=
08>]
  [<c0176122>] [<c0177ded>] [<c0176bc7>] [<c0185623>] [<c0184925>] [<e1c45b=
10>]
  [<c01755e0>] [<e323a9b2>] [<e323c36a>] [<e1c47de5>] [<e1c47f57>] [<c010a6=
25>]
  [<c010a7c4>] [<c0107040>] [<c010ce98>] [<c0107040>] [<c0107063>] [<c01070=
f2>]
  [<c0105000>]
Code: 0f 0b 34 02 62 d7 24 c0 e9 09 fd ff ff 0f 0b 2d 02 62 d7 24
=20
=20
>>EIP; c0117811 <schedule+331/350>   <=3D=3D=3D=3D=3D
=20
>>ebx; d8c90ce0 <_end+18971670/218ee9f0>
>>ecx; dd1ba000 <_end+1ce9a990/218ee9f0>
>>edx; dd1bbf7c <_end+1ce9c90c/218ee9f0>
>>esi; c02b6000 <init_task_union+0/2000>
>>edi; d8c90ce8 <_end+18971678/218ee9f0>
=20
Trace; e1da294f <[e100].data.end+104d0/12be1>
Trace; c0107c4a <__down+6a/b0>
Trace; c0107da4 <__down_failed+8/c>
Trace; e3235a73 <END_OF_CODE+fbff8c/????>
Trace; e3235c08 <END_OF_CODE+fc0121/????>
Trace; c0176122 <opost+22/1b0>
Trace; c0177ded <n_tty_receive_char+17d/750>
Trace; c0176bc7 <n_tty_receive_buf+247/4d0>
Trace; c0185623 <poke_blanked_console+53/70>
Trace; c0184925 <vt_console_print+225/310>
Trace; e1c45b10 <[usb-uhci]uhci_clean_transfer+120/1c0>
Trace; c01755e0 <flush_to_ldisc+c0/f0>
Trace; e323a9b2 <END_OF_CODE+fc4ecb/????>
Trace; e323c36a <END_OF_CODE+fc6883/????>
Trace; e1c47de5 <[usb-uhci]process_urb+185/260>
Trace; e1c47f57 <[usb-uhci]uhci_interrupt+97/170>
Trace; c010a625 <handle_IRQ_event+45/70>
Trace; c010a7c4 <do_IRQ+84/f0>
Trace; c0107040 <default_idle+0/40>
Trace; c010ce98 <call_do_IRQ+5/d>
Trace; c0107040 <default_idle+0/40>
Trace; c0107063 <default_idle+23/40>
Trace; c01070f2 <cpu_idle+52/70>
Trace; c0105000 <_stext+0/0>
=20
Code;  c0117811 <schedule+331/350>
00000000 <_EIP>:
Code;  c0117811 <schedule+331/350>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c0117813 <schedule+333/350>
   2:   34 02                     xor    $0x2,%al
Code;  c0117815 <schedule+335/350>
   4:   62 d7                     bound  %edx,%edi
Code;  c0117817 <schedule+337/350>
   6:   24 c0                     and    $0xc0,%al
Code;  c0117819 <schedule+339/350>
   8:   e9 09 fd ff ff            jmp    fffffd16 <_EIP+0xfffffd16>
Code;  c011781e <schedule+33e/350>
   d:   0f 0b                     ud2a
Code;  c0117820 <schedule+340/350>
   f:   2d 02 62 d7 24            sub    $0x24d76202,%eax
=20
 <0>Kernel panic: Aiee, killing interrupt handler!
=20
3 warnings and 2 errors issued.  Results may not be reliable.


--=-kQKrGirzitEHHe7UcWi/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+vleDeRnU1Q3hpXYRAkMyAJ0aAcKCPFZtNtOby0mmmMks2AQrqgCfVgdD
4+HO/VAq6DbUItLmXOvK1WU=
=81C/
-----END PGP SIGNATURE-----

--=-kQKrGirzitEHHe7UcWi/--

