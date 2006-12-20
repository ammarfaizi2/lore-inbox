Return-Path: <linux-kernel-owner+w=401wt.eu-S965044AbWLTMod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbWLTMod (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 07:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbWLTMo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 07:44:29 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:47994 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965044AbWLTMoE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 07:44:04 -0500
X-Originating-Ip: 24.163.66.209
Date: Wed, 20 Dec 2006 07:39:05 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: anyone want to remove the remaining traces of "get_free_page"?
Message-ID: <Pine.LNX.4.64.0612200736150.6026@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=1.452, required 5, ALL_TRUSTED -1.80, BAYES_20 -0.74,
	RCVD_IN_NJABL_DUL 1.95, RCVD_IN_SORBS_DUL 2.05)
X-Net-Direct-Inc-MailScanner-SpamScore: s
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


given that "get_free_page" is dead:

  http://www.ussg.iu.edu/hypermail/linux/kernel/0210.1/1471.html

maybe someone wants to remove the final references to it from the
tree:

$ grep -rw get_free_page *
arch/sparc/kernel/ioport.c: * <rth> zait: remap_it_my_way(virt_to_phys(get_free_page()))
arch/sparc/kernel/ioport.c: * <zaitcev> Suppose I did this remap_it_my_way(virt_to_phys(get_free_page())).
arch/um/os-Linux/aio.c: * which needs get_free_page.  exit_aio is a __uml_exitcall because the generic
Documentation/nommu-mmap.txt:     allocate the buffer, not get_free_page().
drivers/net/wan/z85230.c: *     DMA now uses get_free_page as kmalloc buffers may span a 64K
include/asm-i386/kexec.h: * KEXEC_SOURCE_MEMORY_LIMIT maximum page get_free_page can return.
include/asm-sh/kexec.h: * KEXEC_SOURCE_MEMORY_LIMIT maximum page get_free_page can return.
include/asm-s390/kexec.h: * KEXEC_SOURCE_MEMORY_LIMIT maximum page get_free_page can return.
include/asm-x86_64/kexec.h: * KEXEC_SOURCE_MEMORY_LIMIT maximum page get_free_page can return.

rday
