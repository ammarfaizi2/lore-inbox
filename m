Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264989AbTGHDh4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 23:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266531AbTGHDh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 23:37:56 -0400
Received: from franka.aracnet.com ([216.99.193.44]:48801 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264989AbTGHDhz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 23:37:55 -0400
Date: Mon, 07 Jul 2003 20:52:18 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 886] New: On mipsel linker says, .o file build with wrong byte order.
Message-ID: <33460000.1057636338@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=886

           Summary: On mipsel linker says, .o file build with wrong byte
                    order.
    Kernel Version: 2.5.74
            Status: NEW
          Severity: blocking
             Owner: bugme-janitors@lists.osdl.org
         Submitter: willi@goesgens.de


Distribution:Debian/Sarge
Hardware Environment:Cobalt Cube

  HOSTCC  usr/gen_init_cpio
  CPIO    usr/initramfs_data.cpio
  GZIP    usr/initramfs_data.cpio.gz
  LD      usr/initramfs_data.o
  LD      usr/built-in.o
ld: usr/initramfs_data.o: compiled for a big endian system and target is little
endian
File in wrong format: failed to merge target specific data of file
usr/initramfs_data.o
make[1]: *** [usr/built-in.o] Error 1
make: *** [usr] Error 2

tot:/usr/src/linux# file usr/initramfs_data.o
usr/initramfs_data.o: ELF 32-bit MSB MIPS-I relocatable, MIPS, version 1 (SYSV),
not stripped
tot:/usr/src/linux# file init/do_mounts.o    
init/do_mounts.o: ELF 32-bit LSB MIPS-II relocatable, MIPS, version 1 (SYSV),
not stripped
tot:/usr/src/linux# uname -a
Linux tot 2.4.18 #11 Fri Aug 30 13:03:03 CEST 2002 mips GNU/Linux
tot:/usr/src/linux# cat /proc/cpuinfo
system type             : MIPS Cobalt
cpu model               : Nevada V10.0  FPU V10.0


