Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbUKPOFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbUKPOFQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 09:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbUKPOFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 09:05:16 -0500
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:47292 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261967AbUKPOEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 09:04:13 -0500
Subject: And another bug report for UML in latest Linux 2.6-BK repository.
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: jdike@karaya.com
Cc: user-mode-linux-devel@lists.sourceforge.net,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: University of Cambridge Computing Service, UK
Message-Id: <1100613788.24599.45.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 16 Nov 2004 14:03:09 +0000
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With my .config (quoted in my first bug report), just disabling SKAS
mode, makes UML compile but not work at all.  It goes like this before
it locks up:

linux umid=uml0 mem=256m ubd0=ubd0 ubd1=/usr/src/ntfs_hdd10
eth0=tuntap,uml0,fe:fd:dd:f8:a6:4e ssl=none con=xterm
xterm=gnome-terminal,-t,-x root=/dev/ubda1
Set 'uml0' persistent and owned by uid 29847
Starting uml...
Checking PROT_EXEC mmap in /tmp...OK
Kernel virtual memory size shrunk to 243269632 bytes
tracing thread pid = 29367
Linux version 2.6.10-rc2 (aia21@imp) (gcc version 3.3.4 (pre 3.3.5
20040809)) #1 Tue Nov 16 13:59:36 GMT 2004
Built 1 zonelists
Kernel command line: mem=256m ubd0=ubd0 ubd1=/usr/src/ntfs_hdd10
eth0=tuntap,uml0,fe:fd:dd:f8:a6:4e ssl=none con=xterm root=/dev/ubda1
PID hash table entries: 2048 (order: 11, 32768 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 254592k available
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...check_ptrace : child
exited with exitcode 1, while expecting 0; status 0x100
missing
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with
errno 2)
NET: Registered protocol family 16
sleeping process 29410 got unexpected signal : 11

I now have to press Ctrl+C to get back to my shell.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

