Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269813AbRHDQwx>; Sat, 4 Aug 2001 12:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269162AbRHDQwn>; Sat, 4 Aug 2001 12:52:43 -0400
Received: from imo-r05.mx.aol.com ([152.163.225.101]:719 "EHLO
	imo-r05.mx.aol.com") by vger.kernel.org with ESMTP
	id <S269018AbRHDQwc>; Sat, 4 Aug 2001 12:52:32 -0400
From: Floydsmith@aol.com
Message-ID: <c0.181ed0fb.289d8254@aol.com>
Date: Sat, 4 Aug 2001 12:52:36 EDT
Subject: can't get buffer cache to flush with /dev/ram with 2.2.4 using "update"/"sync"
To: linux-kernel@vger.kernel.org
CC: Floydsmith@aol.com
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: AOL 4.0 for Windows 95 sub 14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I boot linux using "loadlin" with an "initrd" ram disk image ("minix" type 
fs) of size 32 Meg with kernel 2.2.4. The /linuxrc (a C executable) runs and 
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
