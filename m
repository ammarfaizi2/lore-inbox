Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269162AbRHDROb>; Sat, 4 Aug 2001 13:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269176AbRHDROV>; Sat, 4 Aug 2001 13:14:21 -0400
Received: from imo-m08.mx.aol.com ([64.12.136.163]:28629 "EHLO
	imo-m08.mx.aol.com") by vger.kernel.org with ESMTP
	id <S269162AbRHDROK>; Sat, 4 Aug 2001 13:14:10 -0400
From: Floydsmith@aol.com
Message-ID: <11f.2b1593f.289d8764@aol.com>
Date: Sat, 4 Aug 2001 13:14:12 EDT
Subject: can't get buffer cache to flush with /dev/ram with 2.4.4 using "update"/"sync" 
To: linux-kernel@vger.kernel.org
CC: Floydsmith@aol.com
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: AOL 4.0 for Windows 95 sub 14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the repeat - the kernel I am running is 2.4.4 (not 2.2.4 as 
reported originally) - also, this problem does occur with 2.2.18.

Hello all,

I boot linux using "loadlin" with an "initrd" ram disk image ("minix" type 
fs) of size 32 Meg with kernel 2.4.4. The /linuxrc (a C executable) runs and 
it shows that the mounted file sysem is of proper type and size. Then my 
"linuxrc" extracts a "tar" achrive (to populate the mounted /dev/ram [on 
"/"]) with a small subset of  "linux" about (18 Meg) (as a "rescue" floppy 
boot). Before the "extract", debug code shows that the "cached" entry in 
"/proc/meminfo" to be practically zero (and thus plenty of "freemem"). 
However, after the "extract", the "cached" line shows about "18Meg"  and I 
can find nothing that works to "flush" it. I have tried "spawing" 
"/sbin/update" and waiting several min. and running "/bin/sync" and also 
waiting - no change in the "cahed" entry (or and increase in the "freemem").  
(ps -ef shows a process "bdflush" running [spawned] on its own.) Thus, trying 
to bring up a "logon" shell (and its "init" scripts) results in that process 
being killed do to lack of "freemem". I have only 64M and less than 4 Meg 
free after the "extract". Any suggestions greatly appreciated in advance. If 
there any "syscall" I can make in "linuxrc" that will flush "all" buffers 
without knowing anything like "file descriptors"? Is this "syscall" 
"synchronus" - or do do I have wait several seconds for it to work?

Floyd,
