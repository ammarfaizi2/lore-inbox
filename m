Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbVFHE5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbVFHE5s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 00:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbVFHE5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 00:57:48 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:3216 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S262078AbVFHE5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 00:57:46 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc6-mm1: cardmgr fails, 2.6.12-rc6 okay
Date: Wed, 08 Jun 2005 14:57:38 +1000
Organization: <http://scatter.mine.nu/>
Message-ID: <b0uca1d7s5g5a4scln4a26q7ms5ismq67a@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Toshiba 2210XCDS laptop, Celeron Coppermine, 440ZX, PIIX4E.

2.6.12-rc6-mm1 cardmgr fails, from /var/log/debug:

Jun  8 13:05:41 tosh kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
Jun  8 13:05:42 tosh kernel: PCI: Failed to allocate mem resource #1:800@10100000 for 0000:02:00.0
Jun  8 13:05:42 tosh kernel: PCI: Failed to allocate mem resource #2:800@10100000 for 0000:02:00.0
Jun  8 13:05:42 tosh kernel: PCI: Failed to allocate I/O resource #0:80@2000 for 0000:02:00.0
Jun  8 13:05:42 tosh cardmgr[641]: could not adjust resource: IO ports 0xc00-0xcff: Input/output error
Jun  8 13:05:42 tosh cardmgr[641]: could not adjust resource: IO ports 0x820-0x8ff: Input/output error
Jun  8 13:05:42 tosh cardmgr[641]: could not adjust resource: IO ports 0x800-0x80f: Input/output error
Jun  8 13:05:42 tosh cardmgr[641]: could not adjust resource: IO ports 0x3e0-0x4ff: Input/output error
Jun  8 13:05:42 tosh cardmgr[641]: could not adjust resource: IO ports 0x100-0x3af: Input/output error
Jun  8 13:05:42 tosh cardmgr[641]: could not adjust resource: memory 0xc0000-0xfffff: Input/output error
Jun  8 13:05:42 tosh cardmgr[641]: could not adjust resource: memory 0x60000000-0x60ffffff: Input/output error
Jun  8 13:05:42 tosh cardmgr[641]: could not adjust resource: memory 0xa0000000-0xa0ffffff: Input/output error
Jun  8 13:05:42 tosh cardmgr[641]: could not adjust resource: IO ports 0xa00-0xaff: Input/output error
Jun  8 13:05:42 tosh kernel: PCI: Device 0000:02:00.0 not available because of resource collisions

See: http://scatter.mine.nu/test/boxen/tosh/  for relevant dmesg, 
debug, syslog, 'grep = .config' and other info.

Apart from no network, laptop worked okay to copy dmesg and 
nicely reboot to different kernel.  'lapic' boot option made 
no difference.  More info, testing on request.

--Grant.

