Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263400AbTDCOeK>; Thu, 3 Apr 2003 09:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263401AbTDCOeK>; Thu, 3 Apr 2003 09:34:10 -0500
Received: from franka.aracnet.com ([216.99.193.44]:23783 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263400AbTDCOeI>; Thu, 3 Apr 2003 09:34:08 -0500
Date: Thu, 03 Apr 2003 06:45:28 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 536] New: snd_ens1371 does not load anymore
Message-ID: <42120000.1049381128@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=536

           Summary: snd_ens1371 does not load anymore
    Kernel Version: 2.5.66
            Status: NEW
          Severity: high
             Owner: bugme-janitors@lists.osdl.org
         Submitter: ctron@dentrassi.de


Distribution: redhat-80-i386
Hardware Environment: Ensoniq ES1371 [AudioPCI-97] (rev 6).
Software Environment: linux-kernel, module
Problem Description: The snd_ens1371 module does not load although the card is
working under 2.4.19

Steps to reproduce:
insmod snd_ens1371

See the attachment of /var/log/messages!

Apr  1 08:54:21 segfault kernel: Badness in kobject_register at lib/kobject.c:152
Apr  1 08:54:21 segfault kernel: Call Trace:
Apr  1 08:54:21 segfault kernel:  [<e0951c38>] driver+0x58/0xa0 [snd_ens1371]
Apr  1 08:54:21 segfault kernel:  [<c024e718>] kobject_register+0x58/0x70
Apr  1 08:54:21 segfault kernel:  [<e0951c28>] driver+0x48/0xa0 [snd_ens1371]
Apr  1 08:54:21 segfault kernel:  [<c0275ca7>] bus_add_driver+0x57/0xf0
Apr  1 08:54:21 segfault kernel:  [<e0951c28>] driver+0x48/0xa0 [snd_ens1371]
Apr  1 08:54:21 segfault kernel:  [<e0951c80>] +0x0/0x4e0 [snd_ens1371]
Apr  1 08:54:21 segfault kernel:  [<c0253bcd>] pci_register_driver+0x4d/0x60
Apr  1 08:54:21 segfault kernel:  [<e0951c08>] driver+0x28/0xa0 [snd_ens1371]
Apr  1 08:54:21 segfault kernel:  [<e08c501a>] +0x1a/0x5a [snd_ens1371]
Apr  1 08:54:21 segfault kernel:  [<e0951be0>] driver+0x0/0xa0 [snd_ens1371]
Apr  1 08:54:21 segfault kernel:  [<e0951c80>] +0x0/0x4e0 [snd_ens1371]
Apr  1 08:54:21 segfault kernel:  [<c01378e1>] sys_init_module+0x171/0x260
Apr  1 08:54:21 segfault kernel:  [<c010968f>] syscall_call+0x7/0xb
Apr  1 08:54:21 segfault kernel:


