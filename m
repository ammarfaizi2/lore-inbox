Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUIZWQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUIZWQm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 18:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbUIZWQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 18:16:42 -0400
Received: from dhcp-129-114-141-243.i2.utexas.edu ([129.114.141.243]:57483
	"EHLO debian") by vger.kernel.org with ESMTP id S264377AbUIZWQk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 18:16:40 -0400
Date: Mon, 27 Sep 2004 00:16:14 +0200
From: Lukas Hejtmanek <xhejtman@fi.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc2-mm2 pcmcia oops
Message-ID: <20040926221614.GB1466@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unable to handle kernel paging request at virtual address 0000ffff
 printing eip:
c0402097
*pde = 00000000
Oops: 0002 [#1]
PREEMPT 
Modules linked in: yenta_socket pcmcia_core i830 ehci_hcd uhci_hcd rtc
CPU:    0
EIP:    0060:[<c0402097>]    Tainted:  P   VLI
EFLAGS: 00010246   (2.6.9-rc2-mm2) 
EIP is at quirk_usb_early_handoff+0x0/0x3e
eax: 0000ffff   ebx: c035d954   ecx: c6866000   edx: 00020000
esi: c6866000   edi: c035da4c   ebp: ceede380   esp: c7f4bed8
ds: 007b   es: 007b   ss: 0068
Process pccardd (pid: 3386, threadinfo=c7f4a000 task=c5ea2d70)
Stack: c01d2076 c6866000 c6866000 ceede380 00000000 c01d20ba c6866000 c035d81c 
       c035da4c c01d01ce 00000000 c6866000 00000000 00000000 c01d0214 ceede380 
       00000000 c686642c ceede380 ceede394 c7f4a000 cfbdd0de ceede380 00000000 
Call Trace:
 [<c01d2076>] pci_do_fixups+0x49/0x4b
 [<c01d20ba>] pci_fixup_device+0x42/0x50
 [<c01d01ce>] pci_scan_single_device+0x37/0x5e
 [<c01d0214>] pci_scan_slot+0x1f/0x60
 [<cfbdd0de>] cb_alloc+0x27/0xe5 [pcmcia_core]
 [<cfbda264>] socket_insert+0xb4/0x151 [pcmcia_core]
 [<cfbda54d>] socket_detect_change+0x58/0x82 [pcmcia_core]
 [<cfbda740>] pccardd+0x1c9/0x245 [pcmcia_core]
 [<c0117179>] default_wake_function+0x0/0x12
 [<c0104ff6>] ret_from_fork+0x6/0x14
 [<c0117179>] default_wake_function+0x0/0x12
 [<cfbda577>] pccardd+0x0/0x245 [pcmcia_core]
 [<c01032a9>] kernel_thread_helper+0x5/0xb
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


-- 
Luká¹ Hejtmánek
