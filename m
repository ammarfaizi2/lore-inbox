Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbUCPSSn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 13:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbUCPSSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 13:18:43 -0500
Received: from mailhost.cs.auc.dk ([130.225.194.6]:47089 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP id S261160AbUCPSSk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 13:18:40 -0500
Subject: Problem with ohci module
From: Emmanuel Fleury <fleury@cs.auc.dk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Aalborg University -- Computer Science Dept.
Message-Id: <1079461007.24676.11.camel@rade7.s.cs.auc.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 16 Mar 2004 19:16:47 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed today that I got several time the following error log in my
/var/log/messages:

Mar 16 13:37:26 hermes vmunix: ohci_hcd 0000:00:0f.0: remove, state 1
Mar 16 13:37:26 hermes kernel: usb usb1: USB disconnect, address 1
Mar 16 13:37:26 hermes vmunix: usb 1-1: USB disconnect, address 2
Mar 16 13:37:27 hermes vmunix: ohci_hcd 0000:00:0f.0: USB bus 1
deregistered
Mar 16 13:37:27 hermes vmunix: ohci_hcd 0000:00:14.0: remove, state 1
Mar 16 13:37:27 hermes kernel: usb usb2: USB disconnect, address 1
Mar 16 13:37:27 hermes vmunix: ohci_hcd 0000:00:14.0: USB bus 2
deregistered
Mar 16 13:37:27 hermes vmunix:  printing eip:
Mar 16 13:37:27 hermes vmunix: d7063251
Mar 16 13:37:27 hermes vmunix: Oops: 0000 [#1]
Mar 16 13:37:27 hermes vmunix: PREEMPT
Mar 16 13:37:27 hermes vmunix: CPU:    0
Mar 16 13:37:27 hermes vmunix: EIP:    0060:[<d7063251>]    Not tainted
Mar 16 13:37:27 hermes vmunix: EFLAGS: 00010206
Mar 16 13:37:27 hermes vmunix: EIP is at 0xd7063251
Mar 16 13:37:27 hermes vmunix: eax: 1efa52a0   ebx: 00008008   ecx:
1efa4f10   edx: 00008008
Mar 16 13:37:27 hermes vmunix: esi: d64ec0b0   edi: c0105000   ebp:
d64ec000   esp: c03b9fbc
Mar 16 13:37:27 hermes vmunix: ds: 007b   es: 007b   ss: 0068
Mar 16 13:37:27 hermes vmunix: Process swapper (pid: 0,
threadinfo=c03b8000 task=c03475e0)
Mar 16 13:37:27 hermes vmunix: Stack: 0009b600 00000001 c03b8000
0009b600 c0105000 0008e000 c0107264 c03b8000
Mar 16 13:37:27 hermes vmunix:        c03ba724 c03475e0 00000000
c03d5b00 00000014 c03ba470 c03dba80 00000000
Mar 16 13:37:27 hermes vmunix:        c010017e
Mar 16 13:37:27 hermes vmunix: Call Trace:
Mar 16 13:37:27 hermes vmunix:  [<c0105000>] _stext+0x0/0x60
Mar 16 13:37:27 hermes vmunix:  [<c0107264>] cpu_idle+0x34/0x40
Mar 16 13:37:27 hermes vmunix:  [<c03ba724>] start_kernel+0x164/0x190
Mar 16 13:37:27 hermes vmunix:  [<c03ba470>]
unknown_bootoption+0x0/0x120
Mar 16 13:37:27 hermes vmunix:
Mar 16 13:37:27 hermes vmunix: Code:  Bad EIP value.


Is it a known bug ?

Regards
-- 
Emmanuel Fleury

Computer Science Department, |  Office: B1-201
Aalborg University,          |  Phone:  +45 96 35 72 23
Fredriks Bajersvej 7E,       |  Fax:    +45 98 15 98 89
9220 Aalborg East, Denmark   |  Email:  fleury@cs.auc.dk

