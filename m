Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270867AbTGNTm7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 15:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270878AbTGNTm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 15:42:57 -0400
Received: from franka.aracnet.com ([216.99.193.44]:31657 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S270867AbTGNTk3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 15:40:29 -0400
Date: Mon, 14 Jul 2003 12:55:06 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 923] New: sis900 causes Badness in pci_find_subsys at drivers/pci/search.c:132 
Message-ID: <223960000.1058212506@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=923

           Summary: sis900 causes Badness in pci_find_subsys at
                    drivers/pci/search.c:132
    Kernel Version: 2.6.0-test1
            Status: NEW
          Severity: normal
             Owner: jgarzik@pobox.com
         Submitter: runner@mail.tele.dk


Hardware Environment:
sis900 network card

Problem Description:
when booting I get:

Badness in pci_find_subsys at drivers/pci/search.c:132
Call Trace:
 [<c01c14f1>] pci_find_subsys+0xd1/0xe0
 [<c01c152f>] pci_find_device+0x2f/0x40
 [<c021371c>] sis630_set_eq+0x5c/0x2a0
 [<c0213a13>] sis900_timer+0xb3/0x1f0
 [<c0213960>] sis900_timer+0x0/0x1f0
 [<c011fba0>] run_timer_softirq+0xb0/0x170
 [<c011bc9a>] do_softirq+0x9a/0xa0
 [<c010ae49>] do_IRQ+0xc9/0xf0
 [<c0106f40>] default_idle+0x0/0x40
 [<c0106f40>] default_idle+0x0/0x40
 [<c010929c>] common_interrupt+0x18/0x20
 [<c0106f40>] default_idle+0x0/0x40
 [<c0106f40>] default_idle+0x0/0x40
 [<c0106f64>] default_idle+0x24/0x40
 [<c0106ffa>] cpu_idle+0x3a/0x50
 [<c0105000>] _stext+0x0/0x30
 [<c0350702>] start_kernel+0x132/0x140
 [<c0350470>] unknown_bootoption+0x0/0x120


Steps to reproduce:
boot the system up


