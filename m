Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264591AbTDPVB1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 17:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264593AbTDPVB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 17:01:27 -0400
Received: from jordan.pp.org.pl ([213.186.82.147]:31648 "EHLO jordan.pp.org.pl")
	by vger.kernel.org with ESMTP id S264591AbTDPVB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 17:01:26 -0400
Date: Wed, 16 Apr 2003 22:14:07 +0200
From: Bartlomiej Czardybon <bart@czardybon.net>
To: linux-kernel@vger.kernel.org
Subject: uhci_hcd kernel panic in 2.5.67
Message-ID: <20030416201407.GA8570@pik-net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I find uhci_hcd module behaving very strangely on my system (Fujitsu Siemens
Lifebook S-4546).

When I do (rmmod uhci_hcd ; modprobe uhci_hcd) I _always_ get kernel panic.
Call Trace is different from panic to panic but it always ends in
do_IRQ -> do_softirq.

dmesg | grep uhci - from my system:
--
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
uhci-hcd 00:07.2: Intel Corp. 82440MX USB Universa
uhci-hcd 00:07.2: irq 15, io base 00001ca0
uhci-hcd 00:07.2: new USB bus registered, assigned bus number 1
--

Additionaly sometimes the kernel hangs on boot while loading uhci_hcd module.

Exactly the same effects I've been experiencing in 2.5.66.

In default RedHat8 kernel (2.4.21 with patches) everything seems to be ok.

Best regards,
--
Bart
