Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131319AbRCHLDb>; Thu, 8 Mar 2001 06:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131320AbRCHLDW>; Thu, 8 Mar 2001 06:03:22 -0500
Received: from 13dyn210.delft.casema.net ([212.64.76.210]:29708 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S131319AbRCHLDH>; Thu, 8 Mar 2001 06:03:07 -0500
Message-Id: <200103081102.MAA14864@cave.bitwizard.nl>
Subject: Ooops on 2.2.18...
To: linux-kernel@vger.kernel.org
Date: Thu, 8 Mar 2001 12:02:36 +0100 (MET)
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I misconfigured my Linux 2.2.18 kernel: forgot to include the network
device, which is kind of essential for a machine with nfs-root.....
So it just sat there waiting for the root floppy... Then I recompiled
my kernel, but when I came back to the console I saw:

Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
scsi : 0 hosts.
scsi : detected total.
IP-Config: No network devices available
Root-NFS: No NFS server available, giving up.
VFS: Unable to mount root fs via NFS, trying floppy.
(Warning, this kernel has no ramdisk support)
VFS: Insert root floppy and press ENTER
end_request: I/O error, dev 02:00 (floppy), sector 0
Unable to handle kernel NULL pointer dereference at virtual address 00000008
current->tss.cr3 = 00101000, %cr3 = 00101000

If someone has some desire to fix something, you can try to find/fix
this. 

The recompile of course overwrote the symbol table from the kernel
that I was running...

					Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
