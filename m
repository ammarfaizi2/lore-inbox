Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbVKCW3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbVKCW3Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 17:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbVKCW3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 17:29:25 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:19640 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750982AbVKCW3Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 17:29:25 -0500
Subject: PROBLEM: potential null-pointer dereference in fs/bfs/inode.c
From: Nic Volanschi <nic.volanschi@free.fr>
To: tigran@veritas.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1131057113.5733.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9.1.aur.2) 
Date: Thu, 03 Nov 2005 23:31:54 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tigran,

While looking into the BFS code of kernel 2.6.13, I noticed what seems
to be a potential null-pointer dereference bug in file fs/bfs/inode.c,
function bfs_fill_super(), within the following piece of code:

		inode = iget(s,i);
		if (BFS_I(inode)->i_dsk_ino == 0)
			info->si_freei++;

Is it correct that iget() may return a Null value, and in that case, we
have a null-pointer exception on the subsequent line?

Please let me know if you confirm or not this diagnostics.
Best regards,
Nic.


[1.] One line summary of the problem:    
 potential null-pointer dereference in fs/bfs/inode.c
[2.] Full description of the problem/report:
  see above
[3.] Keywords (i.e., modules, networking, kernel): 
 BFS file system
[4.] Kernel version (from /proc/version): 2.6.13
[5.] Most recent kernel version which did not have the bug:
[6.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
[7.] A small shell script or example program which triggers the
     problem (if possible)
[8.] Environment
[8.1.] Software (add the output of the ver_linux script here)
[8.2.] Processor information (from /proc/cpuinfo): AMD athlon XP 2800+
[8.3.] Module information (from /proc/modules):
[8.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)
[8.5.] PCI information ('lspci -vvv' as root)
[8.6.] SCSI information (from /proc/scsi/scsi)
[8.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:


