Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130024AbRAWMOv>; Tue, 23 Jan 2001 07:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130030AbRAWMOl>; Tue, 23 Jan 2001 07:14:41 -0500
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:65424 "EHLO
	tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S130024AbRAWMOb>; Tue, 23 Jan 2001 07:14:31 -0500
To: linux-kernel@vger.kernel.org
Subject: [OOPS] 
Reply-To: Daniel Stodden <stodden@in.tum.de>
From: Daniel Stodden <stodden@informatik.tu-muenchen.de>
Message-ID: <87ae8isbyr.fsf@bitch.localnet>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 23 Jan 2001 13:14:16 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi all.

apart from an immediate reboot and having lost a few blocks on sda7,
that's pretty much all i can say about it:

------------------------------


ksymoops 2.3.4 on i586 2.4.0.  Options used
     -V (default)
     -k /var/log/ksymoops/20010123074515.ksyms (specified)
     -l /var/log/ksymoops/20010123074515.modules (specified)
     -o /lib/modules/2.4.0/ (default)
     -m /boot/System.map-2.4.0 (default)

Warning (expand_objects): object /lib/modules/2.4.0/misc/3dfx.o for module 3dfx has changed since load
Warning (compare_maps): mismatch on symbol resetmtrr_3dfx  , 3dfx says cd952ba0, /lib/modules/2.4.0/misc/3dfx.o says cd952be4.  Ignoring /lib/modules/2.4.0/misc/3dfx.o entry
Warning (compare_maps): mismatch on symbol setmtrr_3dfx  , 3dfx says cd9529f4, /lib/modules/2.4.0/misc/3dfx.o says cd952a48.  Ignoring /lib/modules/2.4.0/misc/3dfx.o entry
Jan 23 10:49:50 bitch kernel: Unable to handle kernel paging request at virtual address e28820c6
Jan 23 10:49:50 bitch kernel: c0142856
Jan 23 10:49:50 bitch kernel: *pde = 00000000
Jan 23 10:49:50 bitch kernel: Oops: 0000
Jan 23 10:49:50 bitch kernel: CPU:    0
Jan 23 10:49:50 bitch kernel: EIP:    0010:[find_inode+30/88]
Jan 23 10:49:50 bitch kernel: EFLAGS: 00013202
Jan 23 10:49:50 bitch kernel: eax: cbfc0000   ebx: e28820a6   ecx: 0000001c   edx: 0003301d
Jan 23 10:49:50 bitch kernel: esi: e28820a6   edi: 00000000   ebp: cbfca6d0   esp: c534be80
Jan 23 10:49:50 bitch kernel: ds: 0018   es: 0018   ss: 0018
Jan 23 10:49:50 bitch kernel: Process X (pid: 7694, stackpage=c534b000)
Jan 23 10:49:50 bitch kernel: Stack: 0003301d 00000000 0003301d cb896800 c0142c28 cb896800 0003301d cbfca6d0 
Jan 23 10:49:50 bitch kernel:        00000000 00000000 0003301d c483ccc0 c7268a00 c7268a5c cbfca6d0 c014f63f 
Jan 23 10:49:50 bitch kernel:        cb896800 0003301d 00000000 00000000 fffffff4 c483ccc0 c7268a00 c735e43c 
Jan 23 10:49:50 bitch kernel: Call Trace: [iget4+76/216] [ext2_lookup+91/132] [real_lookup+83/196] [path_walk+576/2096] [open_namei+120/1480] [do_munmap+609/624] [filp_open+48/80] 
Jan 23 10:49:50 bitch kernel: Code: 39 53 20 75 24 8b 54 24 14 39 93 8c 00 00 00 75 18 85 ff 74 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   39 53 20                  cmp    %edx,0x20(%ebx)
Code;  00000003 Before first symbol
   3:   75 24                     jne    29 <_EIP+0x29> 00000029 Before first symbol
Code;  00000005 Before first symbol
   5:   8b 54 24 14               mov    0x14(%esp,1),%edx
Code;  00000009 Before first symbol
   9:   39 93 8c 00 00 00         cmp    %edx,0x8c(%ebx)
Code;  0000000f Before first symbol
   f:   75 18                     jne    29 <_EIP+0x29> 00000029 Before first symbol
Code;  00000011 Before first symbol
  11:   85 ff                     test   %edi,%edi
Code;  00000013 Before first symbol
  13:   74 00                     je     15 <_EIP+0x15> 00000015 Before first symbol


3 warnings issued.  Results may not be reliable.


misc proc stuff:
------------------------------

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 551.270
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow k6_mtrr
bogomips        : 1101.00


bitch[3]:/usr/local/src/linux-2.4/fs$ cat /proc/scsi/ncr53c8xx/0 
  Chip NCR53C810a, device id 0x1, revision id 0x12
  On PCI bus 0, device 11, function 0, IRQ 10
  Synchronous period factor 25, max commands per lun 32
  Debug flags 0x200, verbosity level 1

bitch[3]:/usr/local/src/linux-2.4/fs$ cat /proc/scsi/scsi 
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DCAS-34330W      Rev: S65A
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DCAS-34330       Rev: S65A
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: PLEXTOR  Model: CD-ROM PX-32TS   Rev: 1.03
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: TEAC     Model: CD-R55S          Rev: 1.0L
  Type:   CD-ROM                           ANSI SCSI revision: 02


bitch:/proc# cat /proc/ide/ali 

                                Ali M15x3 Chipset.
                                ------------------
PCI Clock: 33.
CD_ROM FIFO:No , CD_ROM DMA:Yes
FIFO Status: contains 0 Words, runs.

-------------------primary channel-------------------secondary channel---------

channel status:       On                                On 
both channels togth:  Yes                               Yes
Channel state:        error DRQ busy                    OK            
Add. Setup Timing:    8T                                1T
Command Act. Count:   8T                                8T
Command Rec. Count:   16T                               16T

----------------drive0-----------drive1------------drive0-----------drive1------

DMA enabled:      No               No                Yes              No 
FIFO threshold:    8 Words          8 Words           8 Words          8 Words
FIFO mode:        FIFO On          FIFO On           FIFO On          FIFO On 
Dt RW act. Cnt     8T               8T                3T               8T
Dt RW rec. Cnt    16T              16T                1T              16T

-----------------------------------UDMA Timings--------------------------------

UDMA:             No               No                OK               No
UDMA timings:     3.5T             3.5T              2.5T             3.5T

bitch:/proc# cat /proc/ide/hdc/model 
IBM-DTLA-307030

-- 
___________________________________________________________________________
 mailto:stodden@in.tum.de
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
