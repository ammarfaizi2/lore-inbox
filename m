Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271632AbTGRDQG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 23:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271683AbTGRDQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 23:16:06 -0400
Received: from franka.aracnet.com ([216.99.193.44]:25757 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S271632AbTGRDQD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 23:16:03 -0400
Date: Thu, 17 Jul 2003 20:30:45 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 954] New: link failure for arch/ppc/mm/built-in.o, function mem_pieces_find 
Message-ID: <5310000.1058499045@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=954

           Summary: link failure for arch/ppc/mm/built-in.o, function
                    mem_pieces_find
    Kernel Version: 2.6.0-test1 + cset-20030717_2009
            Status: NEW
          Severity: blocking
             Owner: bugme-janitors@lists.osdl.org
         Submitter: barryn@pobox.com


Distribution: Gentoo
Hardware Environment: 400MHz Apple PowerMac G4 (AGP Graphics model)
Software Environment: gcc 2.95.3, binutils 2.12.90.0.7 20020423
Problem Description:
When I try to compile linux-2.6.0-test1 + the cset-20030719_2009 patch (i.e.,
the latest BitKeeper snapshot on kernel.org as of this writing), I get this
compile error:
  LD      .tmp_vmlinux1
arch/ppc/mm/built-in.o: In function `mem_pieces_find':
arch/ppc/mm/built-in.o(.init.text+0x8f8): undefined reference to `__va'
arch/ppc/mm/built-in.o(.init.text+0x8f8): relocation truncated to fit:
R_PPC_REL24 __va
make: *** [.tmp_vmlinux1] Error 1

Steps to reproduce:
1. Download
ftp://ftp.kernel.org/pub/linux/kernel/v2.5/testing/cset/cset-20030717_2009.txt.gz
and apply it to linux-2.6.0-test1.

2. Configure it and try to build it.


