Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262236AbVBQGds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbVBQGds (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 01:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbVBQGds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 01:33:48 -0500
Received: from mail.tyan.com ([66.122.195.4]:1286 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S262236AbVBQGdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 01:33:45 -0500
Message-ID: <3174569B9743D511922F00A0C94314230808598B@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: interrupt 
Date: Wed, 16 Feb 2005 22:47:07 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Interrupts always go to CPU 11.

If dual core is diabled,  it always go to CPU5. It is OK on 32bit mode.

           CPU0       CPU1       CPU2       CPU3       CPU4       CPU5
CPU6       CPU7       CPU8       CPU9       CPU10       CPU11       CPU12
CPU13       CPU14       CPU15       
  0:        409          0          0          0          0          0
0          0          0          0        229      37399          0
0          0          0    IO-APIC-edge  timer
  2:          0          0          0          0          0          0
0          0          0          0          0          0          0
0          0          0          XT-PIC  cascade
  4:          0          0          0          0          0          0
0          0          0          0          0       4915          0
0          0          0    IO-APIC-edge  serial
  8:          0          0          0          0          0          0
0          0          0          0          0          0          0
0          0          0    IO-APIC-edge  rtc
 14:          0          0          0          0          0          0
0          0          0          0          0         10          0
0          0          0    IO-APIC-edge  ide0
 19:          0          0          0          0          0          0
0          0          0          0          0          0          0
0          0          0   IO-APIC-level  ohci1394
 20:          0          0          0          0          0          0
0          0          0          0          0          0          0
0          0          0   IO-APIC-level  libata
 21:          0          0          0          0          0          0
0          0          0          0          0          0          0
0          0          0   IO-APIC-level  libata
 22:          0          0          0          0          0          0
0          0          0          0          0          0          0
0          0          0   IO-APIC-level  ohci_hcd
 23:          0          0          0          0          0          0
0          0          0          0          0          0          0
0          0          0   IO-APIC-level  ehci_hcd
NMI:          1          0          0          0          0          0
0          0          0          0          0          1          0
0          0          0 
LOC:      37688      37965      37965      37965      37965      37965
37965      37965      37965      37965      37965      37446      37965
37965      37965      37966 
ERR:        447
MIS:          0
