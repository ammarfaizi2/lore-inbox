Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129896AbRAQX7r>; Wed, 17 Jan 2001 18:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130393AbRAQX7h>; Wed, 17 Jan 2001 18:59:37 -0500
Received: from smtp3.jp.psi.net ([154.33.63.113]:36365 "EHLO smtp3.jp.psi.net")
	by vger.kernel.org with ESMTP id <S129896AbRAQX7f>;
	Wed, 17 Jan 2001 18:59:35 -0500
From: "Rainer Mager" <rmager@vgkk.com>
To: "Urban Widmark" <urban@teststation.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Oops with 4GB memory setting in 2.4.0 stable
Date: Thu, 18 Jan 2001 08:59:01 +0900
Message-ID: <NEBBJBCAFMMNIHGDLFKGOECDCNAA.rmager@vgkk.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0000_01C0812C.E6D92AF0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.30.0101160927130.10663-100000@cola.teststation.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01C0812C.E6D92AF0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

> smb_rename suggests mv, but the process is ls ... er? What commands where
> you running on smbfs when it crashed?
>
> Could this be a symbol mismatch? Keith Owens suggested a less manual way
> to get module symbol output. Do you get the same results using that?

Here is a newly parsed oops, this time using the /var/log/ksymoops method
mentioned by Keith Owens. Does this look better?

--Rainer

------=_NextPart_000_0000_01C0812C.E6D92AF0
Content-Type: application/octet-stream;
	name="oops.parsed"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="oops.parsed"

ksymoops 0.7c on i686 2.4.0.  Options used=0A=
     -V (default)=0A=
     -k /var/log/ksymoops/20010118084505.ksyms (specified)=0A=
     -l /var/log/ksymoops/20010118084505.modules (specified)=0A=
     -o /lib/modules/2.4.0/ (default)=0A=
     -m /boot/System.map-2.4.0-bigmem (specified)=0A=
=0A=
Warning (compare_maps): ksyms_base symbol =
highmem_start_page_R__ver_highmem_start_page not found in System.map.  =
Ignoring ksyms_base entry=0A=
Warning (compare_maps): ksyms_base symbol kmap_high_R__ver_kmap_high not =
found in System.map.  Ignoring ksyms_base entry=0A=
Warning (compare_maps): ksyms_base symbol kunmap_high_R__ver_kunmap_high =
not found in System.map.  Ignoring ksyms_base entry=0A=
Unable to handle kernel NULL pointer dereference at virtual address =
00000000=0A=
c01239a4=0A=
*pde =3D 00000000=0A=
Oops: 0000=0A=
CPU:    0=0A=
EIP:    0010:[<c01239a4>]=0A=
Using defaults from ksymoops -t elf32-i386 -a i386=0A=
EFLAGS: 00010202=0A=
eax: 00001001   ebx: 00000000   ecx: c0256730   edx: 0003f435=0A=
esi: c20cde24   edi: 00000000   ebp: 00000001   esp: ee5e3e30=0A=
ds: 0018   es: 0018   ss: 0018=0A=
Process ls (pid: 449, stackpage=3Dee5e3000)=0A=
Stack: c20cde24 ee5e3e64 f7e00004 00000001 c01262f5 c20cde24 00000000 =
00000001=0A=
       f7e00004 c1000010 fe2f0014 00000018 fe2f0000 c20cde24 f88982f8 =
00000000=0A=
       00000001 00000070 ee5e3ee8 f889e180 ee61a000 ee6ede9c 00000010 =
f8896e69=0A=
Call Trace: [<c01262f5>] [<fe2f0014>] [<fe2f0000>] [<f88982f8>] =
[<f889e180>] [<f8896e69>] [<f8896eaa>]=0A=
       [<fe2f0000>] [<fe2f0000>] [<f889e048>] [<f889e03c>] [<f8896f40>] =
[<fe2f0000>] [<f88983b0>] [<fe2f0000>]=0A=
       [<fe2f0000>] [<f889798b>] [<fe2f0000>] [<c0140c10>] [<c0140e7c>] =
[<c0140f9e>] [<c0140e7c>] [<c0108f4b>]=0A=
Code: 8b 07 ff 47 18 89 70 04 89 06 89 7e 04 89 37 89 7e 08 8b 44=0A=
=0A=
>>EIP; c01239a4 <add_to_page_cache_unique+c0/f4>   <=3D=3D=3D=3D=3D=0A=
Trace; c01262f5 <grab_cache_page+7d/a4>=0A=
Trace; fe2f0014 <END_OF_CODE+5a531b5/????>=0A=
Trace; fe2f0000 <END_OF_CODE+5a531a1/????>=0A=
Trace; f88982f8 <[smbfs]smb_add_to_cache+dc/104>=0A=
Trace; f889e180 <.data.end+1321/????>=0A=
Trace; f8896e69 <[smbfs]smb_proc_readdir_long+34d/400>=0A=
Trace; f8896eaa <[smbfs]smb_proc_readdir_long+38e/400>=0A=
Trace; fe2f0000 <END_OF_CODE+5a531a1/????>=0A=
Trace; fe2f0000 <END_OF_CODE+5a531a1/????>=0A=
Trace; f889e048 <.data.end+11e9/????>=0A=
Trace; f889e03c <.data.end+11dd/????>=0A=
Trace; f8896f40 <[smbfs]smb_proc_readdir+24/34>=0A=
Trace; fe2f0000 <END_OF_CODE+5a531a1/????>=0A=
Trace; f88983b0 <[smbfs]smb_refill_dircache+24/70>=0A=
Trace; fe2f0000 <END_OF_CODE+5a531a1/????>=0A=
Trace; fe2f0000 <END_OF_CODE+5a531a1/????>=0A=
Trace; f889798b <[smbfs]smb_readdir+db/188>=0A=
Trace; fe2f0000 <END_OF_CODE+5a531a1/????>=0A=
Trace; c0140c10 <vfs_readdir+90/ec>=0A=
Trace; c0140e7c <filldir+0/d8>=0A=
Trace; c0140f9e <sys_getdents+4a/98>=0A=
Trace; c0140e7c <filldir+0/d8>=0A=
Trace; c0108f4b <system_call+33/38>=0A=
Code;  c01239a4 <add_to_page_cache_unique+c0/f4>=0A=
00000000 <_EIP>:=0A=
Code;  c01239a4 <add_to_page_cache_unique+c0/f4>   <=3D=3D=3D=3D=3D=0A=
   0:   8b 07                     mov    (%edi),%eax   <=3D=3D=3D=3D=3D=0A=
Code;  c01239a6 <add_to_page_cache_unique+c2/f4>=0A=
   2:   ff 47 18                  incl   0x18(%edi)=0A=
Code;  c01239a9 <add_to_page_cache_unique+c5/f4>=0A=
   5:   89 70 04                  mov    %esi,0x4(%eax)=0A=
Code;  c01239ac <add_to_page_cache_unique+c8/f4>=0A=
   8:   89 06                     mov    %eax,(%esi)=0A=
Code;  c01239ae <add_to_page_cache_unique+ca/f4>=0A=
   a:   89 7e 04                  mov    %edi,0x4(%esi)=0A=
Code;  c01239b1 <add_to_page_cache_unique+cd/f4>=0A=
   d:   89 37                     mov    %esi,(%edi)=0A=
Code;  c01239b3 <add_to_page_cache_unique+cf/f4>=0A=
   f:   89 7e 08                  mov    %edi,0x8(%esi)=0A=
Code;  c01239b6 <add_to_page_cache_unique+d2/f4>=0A=
  12:   8b 44 00 00               mov    0x0(%eax,%eax,1),%eax=0A=
=0A=
=0A=
3 warnings issued.  Results may not be reliable.=0A=

------=_NextPart_000_0000_01C0812C.E6D92AF0
Content-Type: text/plain;
	name="oops.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="oops.txt"

Unable to handle kernel NULL pointer dereference at virtual address =
00000000=0A=
 printing eip:=0A=
c01239a4=0A=
*pde =3D 00000000=0A=
Oops: 0000=0A=
CPU:    0=0A=
EIP:    0010:[<c01239a4>]=0A=
EFLAGS: 00010202=0A=
eax: 00001001   ebx: 00000000   ecx: c0256730   edx: 0003f435=0A=
esi: c20cde24   edi: 00000000   ebp: 00000001   esp: ee5e3e30=0A=
ds: 0018   es: 0018   ss: 0018=0A=
Process ls (pid: 449, stackpage=3Dee5e3000)=0A=
Stack: c20cde24 ee5e3e64 f7e00004 00000001 c01262f5 c20cde24 00000000 =
00000001=0A=
       f7e00004 c1000010 fe2f0014 00000018 fe2f0000 c20cde24 f88982f8 =
00000000=0A=
       00000001 00000070 ee5e3ee8 f889e180 ee61a000 ee6ede9c 00000010 =
f8896e69=0A=
Call Trace: [<c01262f5>] [<fe2f0014>] [<fe2f0000>] [<f88982f8>] =
[<f889e180>] [<f8896e69>] [<f8896eaa>]=0A=
       [<fe2f0000>] [<fe2f0000>] [<f889e048>] [<f889e03c>] [<f8896f40>] =
[<fe2f0000>] [<f88983b0>] [<fe2f0000>]=0A=
       [<fe2f0000>] [<f889798b>] [<fe2f0000>] [<c0140c10>] [<c0140e7c>] =
[<c0140f9e>] [<c0140e7c>] [<c0108f4b>]=0A=
=0A=
Code: 8b 07 ff 47 18 89 70 04 89 06 89 7e 04 89 37 89 7e 08 8b 44=0A=
Segmentation fault=0A=

------=_NextPart_000_0000_01C0812C.E6D92AF0--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
