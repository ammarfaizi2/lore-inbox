Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbUKPNln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbUKPNln (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 08:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbUKPNln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 08:41:43 -0500
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:5083 "EHLO
	ppsw-3.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261736AbUKPNlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 08:41:23 -0500
Subject: Another bug report for UML in latest Linux 2.6-BK repository.
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: jdike@karaya.com
Cc: user-mode-linux-devel@lists.sourceforge.net,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: University of Cambridge Computing Service, UK
Message-Id: <1100612471.24599.42.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 16 Nov 2004 13:41:11 +0000
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I enable HIGHMEM in my .config (see my previous bug report for my
.config and just change HIGHMEM to enabled) compilation fails:

[snip]
  CC      arch/um/kernel/mem.o
arch/um/kernel/mem.c: In function `mem_init':
arch/um/kernel/mem.c:71: warning: implicit declaration of function
`phys_page'
arch/um/kernel/mem.c:71: warning: assignment makes pointer from integer
without a cast
arch/um/kernel/mem.c: In function `kmap_init':
arch/um/kernel/mem.c:151: warning: implicit declaration of function
`pte_offset'arch/um/kernel/mem.c:151: warning: assignment makes pointer
from integer without a cast
[snip]
  LD      .tmp_vmlinux1
arch/um/kernel/built-in.o(.text+0x2ca9): In function `mem_init':
arch/um/kernel/mem.c:71: undefined reference to `phys_page'
arch/um/kernel/built-in.o(.init.text+0x1d2): In function `kmap_init':
include/asm/pgtable.h:394: undefined reference to `pte_offset'
collect2: ld returned 1 exit status
  KSYM    .tmp_kallsyms1.S
nm: '.tmp_vmlinux1': No such file
make: *** [.tmp_kallsyms1.S] Error 139

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

