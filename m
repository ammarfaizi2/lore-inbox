Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313074AbSDDA6C>; Wed, 3 Apr 2002 19:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313077AbSDDA5x>; Wed, 3 Apr 2002 19:57:53 -0500
Received: from huitzilopochtli.presidencia.gob.mx ([200.57.34.35]:15028 "EHLO
	huitzilopochtli.presidencia.gob.mx") by vger.kernel.org with ESMTP
	id <S313074AbSDDA5l>; Wed, 3 Apr 2002 19:57:41 -0500
Message-ID: <3CABA4FE.2835A5A8@sandino.net>
Date: Wed, 03 Apr 2002 18:57:34 -0600
From: Sandino Araico =?iso-8859-1?Q?S=E1nchez?= <sandino@sandino.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: es-MX, es, es-ES, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.18 mount.smbfs oops
Content-Type: multipart/mixed;
 boundary="------------C83A58821EC712E310DC5FDD"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C83A58821EC712E310DC5FDD
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

1. mount -t smbfs -o uid=500,gid=500 //blue/shared-dir /mnt/smb
    The smbmount asked me for a password, I pressed enter
2. df
    Nothing strange happens
3. ls /mnt/smb
    The Oops happens.

The Windows machine is Windows Xp, the ksymoops output attached.

--
Sandino Araico Sánchez
>drop table internet;
OK, 135454265363565609860398636678346496 rows affected.
"oh fuck" --fluxrad



--------------C83A58821EC712E310DC5FDD
Content-Type: text/plain; charset=us-ascii;
 name="Oops-2002-04-03-smbfs.ksymoops"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Oops-2002-04-03-smbfs.ksymoops"

ksymoops 2.3.4 on i686 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol acpi_fadt_R__ver_acpi_fadt not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_gbl_FADT_R__ver_acpi_gbl_FADT not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel paging request at virtual address e0000000
e0de895c
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<e0de895c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 7848f5e4   ebx: e0000000   ecx: f2ebe3fd   edx: 180e9794
esi: 08a0835c   edi: d8199e30   ebp: d8199ec8   esp: d8199de0
ds: 0018   es: 0018   ss: 0018
Process ls (pid: 1445, stackpage=d8199000)
Stack: c0143914 d8199e98 e0df913c 00000000 00000000 00000000 00000000 cfbe0280 
       d1a921e0 00000000 0ecad52d 00000000 00000000 00000000 ce54b000 00000022 
       00000000 00000000 00000001 00000024 e0de71c9 d089c7a0 d8199fb0 c0143914 
Call Trace: [<c0143914>] [<e0de71c9>] [<c0143914>] [<c0143914>] [<e0de7258>] 
   [<c0143914>] [<e0de80fb>] [<c0143914>] [<c0143546>] [<c0143914>] [<c0143abf>] 
   [<c0143914>] [<c0126377>] [<c0106e23>] 
Code: 0f b6 03 43 89 c2 c1 e2 04 01 f2 c1 e8 04 01 c2 8d 04 92 8d 

>>EIP; e0de895c <END_OF_CODE+1bc15d/????>   <=====
Trace; c0143914 <filldir64+0/15c>
Trace; e0de71c9 <END_OF_CODE+1ba9ca/????>
Trace; c0143914 <filldir64+0/15c>
Trace; c0143914 <filldir64+0/15c>
Trace; e0de7258 <END_OF_CODE+1baa59/????>
Trace; c0143914 <filldir64+0/15c>
Trace; e0de80fb <END_OF_CODE+1bb8fc/????>
Trace; c0143914 <filldir64+0/15c>
Trace; c0143546 <vfs_readdir+8e/d4>
Trace; c0143914 <filldir64+0/15c>
Trace; c0143abf <sys_getdents64+4f/103>
Trace; c0143914 <filldir64+0/15c>
Trace; c0126377 <sys_brk+bf/ec>
Trace; c0106e23 <system_call+33/38>
Code;  e0de895c <END_OF_CODE+1bc15d/????>
00000000 <_EIP>:
Code;  e0de895c <END_OF_CODE+1bc15d/????>   <=====
   0:   0f b6 03                  movzbl (%ebx),%eax   <=====
Code;  e0de895f <END_OF_CODE+1bc160/????>
   3:   43                        inc    %ebx
Code;  e0de8960 <END_OF_CODE+1bc161/????>
   4:   89 c2                     mov    %eax,%edx
Code;  e0de8962 <END_OF_CODE+1bc163/????>
   6:   c1 e2 04                  shl    $0x4,%edx
Code;  e0de8965 <END_OF_CODE+1bc166/????>
   9:   01 f2                     add    %esi,%edx
Code;  e0de8967 <END_OF_CODE+1bc168/????>
   b:   c1 e8 04                  shr    $0x4,%eax
Code;  e0de896a <END_OF_CODE+1bc16b/????>
   e:   01 c2                     add    %eax,%edx
Code;  e0de896c <END_OF_CODE+1bc16d/????>
  10:   8d 04 92                  lea    (%edx,%edx,4),%eax
Code;  e0de896f <END_OF_CODE+1bc170/????>
  13:   8d 00                     lea    (%eax),%eax


3 warnings issued.  Results may not be reliable.

--------------C83A58821EC712E310DC5FDD--

