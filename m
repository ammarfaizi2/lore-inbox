Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbTKTRhH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 12:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbTKTRhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 12:37:07 -0500
Received: from [65.37.126.18] ([65.37.126.18]:8320 "EHLO the-penguin.otak.com")
	by vger.kernel.org with ESMTP id S262050AbTKTRg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 12:36:57 -0500
Date: Thu, 20 Nov 2003 09:36:49 -0800
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Opps 2.6.0-test9
Message-ID: <20031120173649.GA1684@the-penguin.otak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.0-test9 on an i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello, I got this oops while creating a large tar.bz file, so far it has
not been repeatable per se, but I have had several complete freezes while moving files with this kernel.

If anyone needs additional information I would be more then happy to
supply it, and or test patches.

Opps and versions follow.



ksymoops 2.4.9 on i686 2.6.0-test9.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test9/ (default)
     -m /System.old (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address 45297fc8
c012ce97
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c012ce97>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210296
eax: daa1e000   ebx: bffffac4   ecx: bffffac4   edx: 0000007b
esi: 00000008   edi: bffffc84   ebp: daa1e000   esp: daa1ff9c
ds: 007b   es: 007b   ss: 0068
Stack: da7a9ae4 da5397c0 0000541b bffff21c 02faf080 bffffac4 00000003 bffffc84 
       daa1e000 c010a939 bffffac4 00000000 01200008 00000003 bffffc84 bffffbf8 
       000000a2 0000007b 0000007b 000000a2 ffffe410 00000073 00200246 bffffaa8 
Call Trace:
 [<c010a939>] sysenter_past_esp+0x52/0x71
Code: 8b 6c 24 2c 8d 5c 24 0c 89 ca 83 c2 08 19 ff 39 50 18 83 df 


>>EIP; c012ce97 <sys_nanosleep+17/f0>   <=====

>>eax; daa1e000 <acqseq_lock.5+1a5a50d8/3fb850d8>
>>ebp; daa1e000 <acqseq_lock.5+1a5a50d8/3fb850d8>
>>esp; daa1ff9c <acqseq_lock.5+1a5a7074/3fb850d8>

Trace; c010a939 <sysenter_past_esp+52/71>

Code;  c012ce97 <sys_nanosleep+17/f0>
00000000 <_EIP>:
Code;  c012ce97 <sys_nanosleep+17/f0>   <=====
   0:   8b 6c 24 2c               mov    0x2c(%esp,1),%ebp   <=====
Code;  c012ce9b <sys_nanosleep+1b/f0>
   4:   8d 5c 24 0c               lea    0xc(%esp,1),%ebx
Code;  c012ce9f <sys_nanosleep+1f/f0>
   8:   89 ca                     mov    %ecx,%edx
Code;  c012cea1 <sys_nanosleep+21/f0>
   a:   83 c2 08                  add    $0x8,%edx
Code;  c012cea4 <sys_nanosleep+24/f0>
   d:   19 ff                     sbb    %edi,%edi
Code;  c012cea6 <sys_nanosleep+26/f0>
   f:   39 50 18                  cmp    %edx,0x18(%eax)
Code;  c012cea9 <sys_nanosleep+29/f0>
  12:   83 df 00                  sbb    $0x0,%edi


1 error issued.  Results may not be reliable.


If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux the-penguin 2.6.0-test9 #3 Tue Nov 11 16:30:50 PST 2003 i686 GNU/Linux
 
Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.15-pre3
e2fsprogs              1.35-WIP
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.14
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         nls_cp850 smbfs deflate zlib_deflate zlib_inflate twofish serpent aes blowfish des sha256 sha1 md5 binfmt_misc ipv6 uhci_hcd ohci_hcd ehci_hcd 3c59x mii snd_cmipci snd_opl3_lib snd_hwdep snd_mpu401_uart snd_rawmidi nls_iso8859_15 nls_utf8 nls_iso8859_1 nls_cp437 nls_cp950 radeon agpgart sg sr_mod cdrom
-- 
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://www.otak-k.com/~lawrence/
--------------------------------------
- - - - - - O t a k  i n c . - - - - - 


