Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbUBGW7O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 17:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbUBGW7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 17:59:14 -0500
Received: from may.nosdns.com ([207.44.240.96]:54680 "EHLO may.nosdns.com")
	by vger.kernel.org with ESMTP id S261188AbUBGW7M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 17:59:12 -0500
Date: Sat, 7 Feb 2004 16:00:43 -0700
From: Elikster <elik@webspires.com>
X-Mailer: The Bat! (v2.02.3 CE) Personal
Reply-To: Elikster <elik@webspires.com>
Organization: WebSpires Technologies
X-Priority: 3 (Normal)
Message-ID: <169747427.20040207160043@webspires.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.2 Compile Failure - Redhat 7.3 Distro
In-Reply-To: <20040207222148.GA3209@bitwiser.org>
References: <20040207222148.GA3209@bitwiser.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - may.nosdns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - webspires.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Folks,

	It seems that the compile of 2.6.2 is sort of hit and miss depending on the configuration among various Redhat 7.3 distros with gcc 2.96 compiler.  The most common miscompile usually shows up when it reaches this point here:

  CC      fs/proc/task_mmu.o
  CC      fs/proc/inode.o
  CC      fs/proc/root.o
  CC      fs/proc/base.o
  CC      fs/proc/generic.o
  CC      fs/proc/array.o
fs/proc/array.c: In function `proc_pid_stat':
fs/proc/array.c:398: Unrecognizable insn:
(insn/i 721 1009 1003 (parallel[
            (set (reg:SI 0 eax)
                (asm_operands ("") ("=a") 0[
                        (reg:DI 1 edx)
                    ]
                    [
                        (asm_input:DI ("A"))
                    ]  ("include/linux/times.h") 38))
            (set (reg:SI 1 edx)
                (asm_operands ("") ("=d") 1[
                        (reg:DI 1 edx)
                    ]
                    [
                        (asm_input:DI ("A"))
                    ]  ("include/linux/times.h") 38))
            (clobber (reg:QI 19 dirflag))
            (clobber (reg:QI 18 fpsr))
            (clobber (reg:QI 17 flags))
        ] ) -1 (insn_list 715 (nil))
    (nil))
fs/proc/array.c:398: confused by earlier errors, bailing out
make[2]: *** [fs/proc/array.o] Error 1
make[1]: *** [fs/proc] Error 2
make: *** [fs] Error 2
root@longmont [/usr/src/linux-2.6.2]#

   Any ideas?  I have 2 Redhat 7.3 compiled with no problem and some compiles with errors.  It seems to be sort of hit and miss since they are all identical as far the distro goes, but with various hardware.

   This error is coming up with this hardware specs as shown:

 root@longmont [/usr/src/linux-2.6.2]# lspci
00:00.0 Host bridge: Intel Corp. e7500 [Plumas] DRAM Controller (rev 03)
00:00.1 Class ff00: Intel Corp. e7500 [Plumas] DRAM Controller Error Reporting (rev 03)
00:02.0 PCI bridge: Intel Corp. e7500 [Plumas] HI_B Virtual PCI Bridge (F0) (rev 03)
00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub  (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub  (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub  (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 42)
00:1f.0 ISA bridge: Intel Corp. 82801CA ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801CA IDE U100 (rev 02)
00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus (rev 02)
01:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 03)
01:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 03)
01:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 03)
01:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 03)
04:04.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
04:05.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)

   Got Dual Xeons 2.4 on it with 3Ware IDE RAID Controller.


-- 
Best regards,
 Elikster                            mailto:elik@webspires.com

