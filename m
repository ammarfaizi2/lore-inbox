Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbTIOOvc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 10:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbTIOOvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 10:51:32 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:33772 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S261432AbTIOOva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 10:51:30 -0400
Date: Mon, 15 Sep 2003 07:50:32 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: erlid@dtek.chalmers.se
Subject: [Bug 1232] New: Wont build without DMA support enabled
Message-ID: <1506940000.1063637432@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1232

           Summary: Wont build without DMA support enabled
    Kernel Version: 2.6.0-test5
            Status: NEW
          Severity: normal
             Owner: bzolnier@elka.pw.edu.pl
         Submitter: perlid@dtek.chalmers.se


Distribution: Debian testing
Hardware Environment:
ASUS P4C800 Deluxe, i875 chipset
2.80 GHz P4 CPU
hda: quantum fireball lct08
hdc: plextor cd-writer
hde: Seagate Barracuda V S-ATA, 120GB (ST3120023AS)
Software Environment:
glibc 2.3.1
gcc 3.3 (but kernel compiled with gcc 2.95
Problem Description:
I'm unable to compile the kernel if I dont select generic PCI bus-master DMA
support, BLK_DEV_IDEDMA_PCI. If that's not selected, on the line after
  LD      .tmp_vmlinux1
I get this error message:
drivers/built-in.o(.text+0x1f52d): In function `init_dma_generic':
: undefined reference to `ide_setup_dma'
drivers/built-in.o(.text+0x2b5a5): In function `ide_hwif_setup_dma':
: undefined reference to `ide_setup_dma'
make: *** [.tmp_vmlinux1] Error 1

Steps to reproduce:
configure the kernel without BLK_DEV_IDEDMA_PCI and execute make


