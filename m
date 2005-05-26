Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVEZRJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVEZRJo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 13:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVEZRJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 13:09:44 -0400
Received: from the-penguin.otak.com ([65.37.126.18]:27564 "EHLO
	the-penguin.otak.com") by vger.kernel.org with ESMTP
	id S261629AbVEZQ6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 12:58:30 -0400
Date: Thu, 26 May 2005 09:58:22 -0700
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: oops report 2.6.12-rc5-mm1 
Message-ID: <20050526165822.GA9244@the-penguin.otak.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
X-Operating-System: Linux 2.6.12-rc5-mm1 on an i686
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi
I've just booted into 2.6.12-rc5-mm1 and it oopses emidatly after starting=
=20
rhymbox. Here is the ksymoops and ver_linux report. I'm more then willing t=
o test patches.

Sould I try to pull the latest alsa patches?


ksymoops 2.4.9 on i686 2.6.12-rc5-mm1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.12-rc5-mm1/ (default)
     -m /boot/System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address 00006584
c02e9a26
*pde =3D 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c02e9a26>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282   (2.6.12-rc5-mm1)=20
eax: 000064e0   ebx: f43bc8c0   ecx: f19753b0   edx: c02e9a20
esi: f1975c78   edi: f78c7040   ebp: f1975c78   esp: f3677f74
ds: 007b   es: 007b   ss: 0068
Stack: c01412d1 00000000 f78c7040 c014291e b3cfd000 b3ced000 c0142c67 b3ced=
000=20
       b3cfd000 f1975a68 f78c7040 f78c7070 00000002 f3676000 c0142ccf b3ced=
000=20
       00000002 c0102ba5 b3ced000 00010000 b3de8298 00000002 00000002 bf88f=
b78=20
Call Trace:
 [<c01412d1>] remove_vm_struct+0x61/0x70
 [<c014291e>] unmap_vma_list+0xe/0x20
 [<c0142c67>] do_munmap+0xe7/0x110
 [<c0142ccf>] sys_munmap+0x3f/0x60
 [<c0102ba5>] syscall_call+0x7/0xb
Code: 74 24 08 89 f8 8b 6c 24 10 8b 7c 24 0c 83 c4 14 c3 8d 74 26 00 8b 40 =
50 8b 40 60 ff 80 a4 00 00 00 c3 8d 76 00 8b 40 50 8b 40 60 <ff> 88 a4 00 0=
0 00 c3 51 52 e8 cc ca 07 00 5a 59 e9 32 c6 ff ff=20


>>EIP; c02e9a26 <snd_pcm_mmap_data_close+6/d>   <=3D=3D=3D=3D=3D

>>ebx; f43bc8c0 <pg0+33f088c0/3fb4a400>
>>ecx; f19753b0 <pg0+314c13b0/3fb4a400>
>>edx; c02e9a20 <snd_pcm_mmap_data_close+0/d>
>>esi; f1975c78 <pg0+314c1c78/3fb4a400>
>>edi; f78c7040 <pg0+37413040/3fb4a400>
>>ebp; f1975c78 <pg0+314c1c78/3fb4a400>
>>esp; f3677f74 <pg0+331c3f74/3fb4a400>

Trace; c01412d1 <remove_vm_struct+61/70>
Trace; c014291e <unmap_vma_list+e/20>
Trace; c0142c67 <do_munmap+e7/110>
Trace; c0142ccf <sys_munmap+3f/60>
Trace; c0102ba5 <syscall_call+7/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c02e99fb <snd_pcm_hw_params_old_user+ab/c0>
00000000 <_EIP>:
Code;  c02e99fb <snd_pcm_hw_params_old_user+ab/c0>
   0:   74 24                     je     26 <_EIP+0x26>
Code;  c02e99fd <snd_pcm_hw_params_old_user+ad/c0>
   2:   08 89 f8 8b 6c 24         or     %cl,0x246c8bf8(%ecx)
Code;  c02e9a03 <snd_pcm_hw_params_old_user+b3/c0>
   8:   10 8b 7c 24 0c 83         adc    %cl,0x830c247c(%ebx)
Code;  c02e9a09 <snd_pcm_hw_params_old_user+b9/c0>
   e:   c4 14 c3                  les    (%ebx,%eax,8),%edx
Code;  c02e9a0c <snd_pcm_hw_params_old_user+bc/c0>
  11:   8d 74 26 00               lea    0x0(%esi),%esi
Code;  c02e9a10 <snd_pcm_mmap_data_open+0/10>
  15:   8b 40 50                  mov    0x50(%eax),%eax
Code;  c02e9a13 <snd_pcm_mmap_data_open+3/10>
  18:   8b 40 60                  mov    0x60(%eax),%eax
Code;  c02e9a16 <snd_pcm_mmap_data_open+6/10>
  1b:   ff 80 a4 00 00 00         incl   0xa4(%eax)
Code;  c02e9a1c <snd_pcm_mmap_data_open+c/10>
  21:   c3                        ret   =20
Code;  c02e9a1d <snd_pcm_mmap_data_open+d/10>
  22:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c02e9a20 <snd_pcm_mmap_data_close+0/d>
  25:   8b 40 50                  mov    0x50(%eax),%eax
Code;  c02e9a23 <snd_pcm_mmap_data_close+3/d>
  28:   8b 40 60                  mov    0x60(%eax),%eax

This decode from eip onwards should be reliable

Code;  c02e9a26 <snd_pcm_mmap_data_close+6/d>
00000000 <_EIP>:
Code;  c02e9a26 <snd_pcm_mmap_data_close+6/d>   <=3D=3D=3D=3D=3D
   0:   ff 88 a4 00 00 00         decl   0xa4(%eax)   <=3D=3D=3D=3D=3D
Code;  c02e9a2c <snd_pcm_mmap_data_close+c/d>
   6:   c3                        ret   =20
Code;  c02e9a2d <.text.lock.pcm_native+0/1d3>
   7:   51                        push   %ecx
Code;  c02e9a2e <.text.lock.pcm_native+1/1d3>
   8:   52                        push   %edx
Code;  c02e9a2f <.text.lock.pcm_native+2/1d3>
   9:   e8 cc ca 07 00            call   7cada <_EIP+0x7cada>
Code;  c02e9a34 <.text.lock.pcm_native+7/1d3>
   e:   5a                        pop    %edx
Code;  c02e9a35 <.text.lock.pcm_native+8/1d3>
   f:   59                        pop    %ecx
Code;  c02e9a36 <.text.lock.pcm_native+9/1d3>
  10:   e9 32 c6 ff ff            jmp    ffffc647 <_EIP+0xffffc647>


1 error issued.  Results may not be reliable.
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
=20
Linux the-penguin 2.6.12-rc5-mm1 #20 Thu May 26 09:17:46 PDT 2005 i686 GNU/=
Linux
=20
Gnu C                  3.3.6
Gnu make               3.80
binutils               2.15
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre1
e2fsprogs              1.38-WIP
reiserfsprogs          line
reiser4progs           line
xfsprogs               2.6.28
quota-tools            3.12.
nfs-utils              1.0.7
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.5
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded         cifs deflate zlib_deflate zlib_inflate twofish serpe=
nt aes_i586 blowfish des sha256 sha1 md5 crypto_null binfmt_misc ipv6 snd_v=
ia82xx snd_ac97_codec snd_mpu401_uart snd_rawmidi ehci_hcd uhci_hcd sk98lin=
 ohci1394 ieee1394 tun nls_iso8859_15 nls_utf8 nls_iso8859_1 nls_cp437 nls_=
cp950 radeon drm amd64_agp agpgart sg sr_mod ide_scsi ide_cd cdrom via82cxx=
x ide_core skge mii

--=20
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://the-penguin.otak.com/~lawrence
--------------------------------------
- - - - - - O t a k  i n c . - - - - -=20



--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFClgAusgPkFxgrWYkRAoJ1AJwJm2D4OPwfprz+/gNBiZ6bn8s1CwCeK1Ib
uzmYDHY8zVSwLGV6mhZXiGo=
=nqvx
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
