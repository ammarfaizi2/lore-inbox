Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135489AbRAYG7a>; Thu, 25 Jan 2001 01:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135498AbRAYG7U>; Thu, 25 Jan 2001 01:59:20 -0500
Received: from mons.uio.no ([129.240.130.14]:59620 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S135489AbRAYG7P>;
	Thu, 25 Jan 2001 01:59:15 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.1-pre3: kernel BUG at /usr/src/linux/include/linux/nfs_fs.h:167!
From: Sturle Sunde <sturle.sunde@usit.uio.no>
Organization: Universitetets senter for informasjonsteknologi
Date: 25 Jan 2001 07:59:11 +0100
Message-ID: <riq66j4ce2o.fsf@aqualene.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  sybil.uio.no# uname -a
  Linux sybil.uio.no 2.4.1-pre2 #2 SMP Mon Jan 15 09:16:02 CET 2001 i686 unknown

(It's pre3, not pre2.)

Is the bug below a known issue?  If not, ask me for more details if
needed.  Common for all processes killed is that they have been
SIGSTOPed and then SIGCONTed later.

>From dmesg:

 kernel BUG at /usr/src/linux/include/linux/nfs_fs.h:167!
 invalid operand: 0000
 CPU:    0
 EIP:    0010:[<c016d49c>]
 EFLAGS: 00010296
 eax: 00000039   ebx: cf65bb60   ecx: 00000000   edx: 00000002
 esi: dee3c780   edi: ddecbba0   ebp: dcc731a0   esp: ddcc3e54
 ds: 0018   es: 0018   ss: 0018
 Process netscape (pid: 9520, stackpage=ddcc3000)
 Stack: c02ef7e5 c02ef980 000000a7 00000000 ce5bbe00 ddecbba0 ce5bbfa4 00000000 
        00000000 00010202 00000000 00000000 c016dd61 ddecbba0 ce5bbe00 c14ed970 
        00000000 00001000 dfae1e20 c14ed970 ce5bbe00 ddecbba0 00000000 00001000 
 Call Trace: [<c016dd61>] [<c016e15d>] [<c016bb73>] [<c012b4c3>] [<c016bca1>] [<c013641a>] [<c010908b>] 

 Code: 0f 0b 83 c4 0c 89 6b 1c eb 35 6a 00 8b 44 24 30 8b 80 8c 00 
 kernel BUG at /usr/src/linux/include/linux/nfs_fs.h:167!
 invalid operand: 0000
 CPU:    0
 EIP:    0010:[<c016b15b>]
 EFLAGS: 00010296
 eax: 00000039   ebx: dcc731a0   ecx: 00000001   edx: 00000000
 esi: ddcc2000   edi: df19ae60   ebp: ddcc2000   esp: ddcc3ce8
 ds: 0018   es: 0018   ss: 0018
 Process netscape (pid: 9520, stackpage=ddcc3000)
 Stack: c02ee7e5 c02ee940 000000a7 d48de560 dec0d6e0 de546da0 c44a22e0 c0137035 
        de546da0 d48de560 ddcc2000 d48de560 00000000 00000001 c0135f10 d48de560 
        d84f4920 00000000 d48de560 00000000 0001bfff 0000000d d84f4920 c011b41d 
 Call Trace: [<c0137035>] [<c0135f10>] [<c011b41d>] [<c011bbef>] [<c01097b4>] [<c01095a2>] [<c0109833>] 
        [<c016d49c>] [<c01091bc>] [<c016d49c>] [<c016dd61>] [<c016e15d>] [<c016bb73>] [<c012b4c3>] [<c016bca1>] 
        [<c013641a>] [<c010908b>] 

 Code: 0f 0b 83 c4 0c 85 db 74 0a 53 57 e8 81 61 15 00 83 c4 08 8b 
 kernel BUG at /usr/src/linux/include/linux/nfs_fs.h:167!
 invalid operand: 0000
 CPU:    1
 EIP:    0010:[<c016d49c>]
 EFLAGS: 00010296
 eax: 00000039   ebx: d2bab7a0   ecx: 00000000   edx: 00000001
 esi: dee3c780   edi: df97baa0   ebp: dcc731a0   esp: cf94de88
 ds: 0018   es: 0018   ss: 0018
 Process tail (pid: 11777, stackpage=cf94d000)
 Stack: c02ef7e5 c02ef980 000000a7 00000000 df97baa0 ccc1b9a0 c17191c8 00000001 
        ccc1b9a0 00000004 00000000 00000002 c016c302 df97baa0 ccc1b9a0 c17191c8 
        00000000 00001000 ccc1b9a0 ffffffff c17191c8 df97baa0 c17191c8 df97baa0 
 Call Trace: [<c016c302>] [<c016cbc1>] [<c01294ce>] [<c0129787>] [<c01296d0>] [<c016b9b0>] [<c0136356>] 
        [<c010908b>] [<c010002b>] 

 Code: 0f 0b 83 c4 0c 89 6b 1c eb 35 6a 00 8b 44 24 30 8b 80 8c 00 
 kernel BUG at /usr/src/linux/include/linux/nfs_fs.h:167!
 invalid operand: 0000
 CPU:    1
 EIP:    0010:[<c016d49c>]
 EFLAGS: 00010292
 eax: 00000039   ebx: d9d07d80   ecx: 00000000   edx: 00000001
 esi: dee3c780   edi: df9cdd20   ebp: dcc731a0   esp: c3701dd4
 ds: 0018   es: 0018   ss: 0018
 Process mprime (pid: 28170, stackpage=c3701000)
 Stack: c02ef7e5 c02ef980 000000a7 00000000 df9cdd20 c387c440 c15d9f68 00000001 
        c387c440 00000004 00000000 00000002 c016c302 df9cdd20 c387c440 c15d9f68 
        00000000 00001000 c387c440 ffffffff c15d9f68 df9cdd20 c15d9f68 df9cdd20 
 Call Trace: [<c016c302>] [<c016cbc1>] [<c0128a2a>] [<c0129ca4>] [<c012691d>] [<c0126aaa>] [<c0120f63>] 
        [<c01154c7>] [<c0115368>] [<c010a806>] [<c010a9f9>] [<c010aa19>] [<c010a08a>] [<c01091bc>] [<e823a000>] 

 Code: 0f 0b 83 c4 0c 89 6b 1c eb 35 6a 00 8b 44 24 30 8b 80 8c 00 


Noting specioal about my kernel or setup, exept that FXSR is disabled
(nofxsr).  That solves a problem with permanent FPU register
corruption under high FPU register pressure, which I have reported to
the FXSR maintainer.

-- 
Sturle
~~~~~~
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
