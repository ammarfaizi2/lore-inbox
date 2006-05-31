Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751747AbWEaRXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbWEaRXB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 13:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751748AbWEaRXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 13:23:01 -0400
Received: from wx-out-0102.google.com ([66.249.82.193]:41510 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751744AbWEaRXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 13:23:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JaW/o8t4sqxeKEef0KbS6oIkrqrFWxFmBwGrDTdf5+Fg2JOQcWrZCCqVpeM+quuDth+JCGVq63kRwz/CHeFibneoUjXl234uG84n77IBoSRO4ZcfcUK9WnHCUgytvIJHUMius/XjcioQju/PIZPkLW0CAOo8MkLQx1w/cFU0Tfk=
Message-ID: <a44ae5cd0605311022j6c9d3128ya726d2d2f21b32a3@mail.gmail.com>
Date: Wed, 31 May 2006 13:22:59 -0400
From: "Miles Lane" <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
Subject: 2.6.17-rc5-mm1 -- BUG: warning at kernel/softirq.c:86/local_bh_disable()
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PM: Adding info for No Bus:pci0000:00
Boot video device is 0000:00:02.0
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#02)
(try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently

BUG: warning at kernel/softirq.c:86/local_bh_disable()
 <c010424b> show_trace+0xd/0x10  <c0104265> dump_stack+0x17/0x1a
 <c011a4c8> local_bh_disable+0x38/0x45  <c030c682> _read_lock_bh+0xb/0x1f
 <c02b5ef9> sock_def_readable+0x15/0x66  <c02c87fd>
netlink_broadcast+0x1b7/0x2a7
 <c02c4fa7> wireless_send_event+0x271/0x283  <f8944827>
ipw_rx+0x13e5/0x1977 [ipw2200]
 <f8948c72> ipw_irq_tasklet+0xc9/0x5c4 [ipw2200]  <c011a292>
tasklet_action+0x3a/0x60
 <c011a828> __do_softirq+0x41/0x86  <c0104549> do_softirq+0x47/0x92
 =======================
 <c011a6fa> irq_exit+0x30/0x3c  <c01044f5> do_IRQ+0x98/0xa5
 <c0102bbe> common_interrupt+0x1a/0x20  <c010198e> cpu_idle+0x47/0x73
 <c0100257> rest_init+0x37/0x39  <c044e62a> start_kernel+0x25c/0x25e
