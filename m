Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129228AbQKYMXs>; Sat, 25 Nov 2000 07:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129183AbQKYMX2>; Sat, 25 Nov 2000 07:23:28 -0500
Received: from mx.oau.org ([208.46.16.50]:53262 "EHLO mx.oau.org")
        by vger.kernel.org with ESMTP id <S129153AbQKYMXW>;
        Sat, 25 Nov 2000 07:23:22 -0500
Message-Id: <m13zdEM-000QAFC@nevets.oau.org>
Date: Sat, 25 Nov 2000 06:10:54 -0500 (EST)
From: ssd@nevets.oau.org (Steven S. Dick)
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test11 (pre1, final) OOPS during boot/modprobe
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.0-test11-pre1 seems to have broken something.
I have no problems with test10, but test11-pre1 gives three oops
messages during boot.  test11-final gives the exact same OOPS messages...

Of the three, only the first one decodes to anything useful:

Unable to handle kernel paging request at virtual address c86bd1e0 
 printing eip: 
c4890060 
*pde = 00000000 
Oops: 0000 
CPU:    0 
EIP:    0010:[nfsd:__insmod_nfsd_O/lib/modules/2.4.0-test11/kernel/fs/nfsd/nfs+-12192/80] 
EFLAGS: 00010a82 
eax: c4890050   ebx: c3fcb400   ecx: c489101c   edx: ffffffff 
esi: c4891160   edi: c4891160   ebp: c48912d4   esp: c36fbee8 
ds: 0018   es: 0018   ss: 0018 
Process modprobe (pid: 201, stackpage=c36fb000) 
Stack: c01b74fc c3fcb400 c489101c c3fcb400 00000000 c01b7554 c4891160 c3fcb400  
       c4890000 c489098c 00000001 c4890996 c4891160 c0117d2d c36fa000 08065490  
       08061760 bfffe164 00000001 c488d000 c488d000 c36fbf60 0000004c c48912c0  
Call Trace: [pci_announce_device+44/64] [nfsd:__insmod_nfsd_O/lib/modules/2.4.0-test11/kernel/fs/nfsd/nfs+-8164/80] [pci_register_driver+68/92] [nfsd:__insmod_nfsd_O/lib/modules/2.4.0-test11/kernel/fs/nfsd/nfs+-7840/80] [nfsd:__insmod_nfsd_O/lib/modules/2.4.0-test11/kernel/fs/nfsd/nfs+-12288/80] [nfsd:__insmod_nfsd_O/lib/modules/2.4.0-test11/kernel/fs/nfsd/nfs+-9844/80] [nfsd:__insmod_nfsd_O/lib/modules/2.4.0-test11/kernel/fs/nfsd/nfs+-9834/80]  
       [nfsd:__insmod_nfsd_O/lib/modules/2.4.0-test11/kernel/fs/nfsd/nfs+-7840/80] [sys_init_module+1409/1568] [nfsd:__insmod_nfsd_O/lib/modules/2.4.0-test11/kernel/fs/nfsd/nfs+-24576/80] [nfsd:__insmod_nfsd_O/lib/modules/2.4.0-test11/kernel/fs/nfsd/nfs+-24576/80] [nfsd:__insmod_nfsd_O/lib/modules/2.4.0-test11/kernel/fs/nfsd/nfs+-7488/80] [nfsd:__insmod_nfsd_O/lib/modules/2.4.0-test11/kernel/fs/nfsd/nfs+-24576/80] [nfsd:__insmod_nfsd_O/lib/modules/2.4.0-test11/kernel/fs/nfsd/nfs+-12192/80] [system_call+51/64]  
Code: 12 89 c4 c1 e2 03 89 44 24 18 89 54 24 1c 40 8b 8a c8 0f 89  

The addresses are different, but the stack trace is identical,
between test-11(pre1) and test11(final).

I think the oops's each correspond to a modprobe.

Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/specs
gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
