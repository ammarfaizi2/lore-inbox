Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbWBJUHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWBJUHv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 15:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWBJUHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 15:07:50 -0500
Received: from uproxy.gmail.com ([66.249.92.194]:20150 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751369AbWBJUHu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 15:07:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LaOng7N/iEEq34/x05EhBxOr124sfuWk9R3OeQVsz3rSygEsBhezJut3jrtKHQU+NJpAOq5U7zY7Z1hCsbrgaKqzkW2SIkMSh04attVk9kUhJR79I3zgleIfm0CswBkrX44kQmj9iP09iy56DligRckgPvdzu0oLDpwis9w/rN0=
Message-ID: <a44ae5cd0602101207s4b2d61d7nc6705067b7913322@mail.gmail.com>
Date: Fri, 10 Feb 2006 15:07:48 -0500
From: Miles Lane <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: 2.6.16-rc2-mm1 -- BUG: warning at drivers/ieee1394/ohci1394.c:235/get_phy_reg()
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BUG: warning at drivers/ieee1394/ohci1394.c:235/get_phy_reg()
 <c0103a85> show_trace+0xd/0xf   <c0103a9c> dump_stack+0x15/0x17
 <f931b977> get_phy_reg+0x76/0xed [ohci1394]   <f931ba34>
ohci_devctl+0x46/0x524 [ohci1394]
 <f931cc2a> ohci_irq_handler+0x2e4/0x69e [ohci1394]   <c013b91a>
handle_IRQ_event+0x26/0x51
 <c013b9d2> __do_IRQ+0x8d/0xe3   <c0104c7f> do_IRQ+0x65/0x84
 =======================
 <c0103166> common_interrupt+0x1a/0x20   <c0104ce7> do_softirq+0x49/0x52
 =======================
 <c01209ed> irq_exit+0x36/0x38   <c010d679> smp_apic_timer_interrupt+0x5c/0x5f
 <c01031f4> apic_timer_interrupt+0x1c/0x24   <f931b8f9>
set_phy_reg+0xe7/0xef [ohci1394]
 <f931ba47> ohci_devctl+0x59/0x524 [ohci1394]   <f9419079>
hpsb_reset_bus+0x1f/0x26 [ieee1394]
 <f941af08> delayed_reset_bus+0xb7/0xbb [ieee1394]   <c012a0ac>
run_workqueue+0x7a/0xbb
 <c012a247> worker_thread+0xce/0x100   <c012ce31> kthread+0xa6/0xd3
 <c0100bcd> kernel_thread_helper+0x5/0xb
BUG: warning at drivers/ieee1394/ohci1394.c:264/set_phy_reg()
 <c0103a85> show_trace+0xd/0xf   <c0103a9c> dump_stack+0x15/0x17
 <f931b89f> set_phy_reg+0x8d/0xef [ohci1394]   <f931ba47>
ohci_devctl+0x59/0x524 [ohci1394]
 <f931cc2a> ohci_irq_handler+0x2e4/0x69e [ohci1394]   <c013b91a>
handle_IRQ_event+0x26/0x51
 <c013b9d2> __do_IRQ+0x8d/0xe3   <c0104c7f> do_IRQ+0x65/0x84
 =======================
 <c0103166> common_interrupt+0x1a/0x20   <c0104ce7> do_softirq+0x49/0x52
 =======================
 <c01209ed> irq_exit+0x36/0x38   <c010d679> smp_apic_timer_interrupt+0x5c/0x5f
 <c01031f4> apic_timer_interrupt+0x1c/0x24   <f931b8f9>
set_phy_reg+0xe7/0xef [ohci1394]
 <f931ba47> ohci_devctl+0x59/0x524 [ohci1394]   <f9419079>
hpsb_reset_bus+0x1f/0x26 [ieee1394]
 <f941af08> delayed_reset_bus+0xb7/0xbb [ieee1394]   <c012a0ac>
run_workqueue+0x7a/0xbb
 <c012a247> worker_thread+0xce/0x100   <c012ce31> kthread+0xa6/0xd3
 <c0100bcd> kernel_thread_helper+0x5/0xb
