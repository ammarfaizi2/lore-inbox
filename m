Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264487AbTLMHs4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 02:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264496AbTLMHsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 02:48:55 -0500
Received: from ip213-185-39-113.laajakaista.mtv3.fi ([213.185.39.113]:23424
	"HELO dag.newtech.fi") by vger.kernel.org with SMTP id S264487AbTLMHsy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 02:48:54 -0500
Message-ID: <20031213074852.3111.qmail@dag.newtech.fi>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-0.27
To: linux-kernel@vger.kernel.org
cc: dag@newtech.fi
Subject: uhci driver looping in 2.6-test10
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Sat, 13 Dec 2003 09:48:52 +0200
From: Dag Nygren <dag@newtech.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I installed 2.6-test10 on one system here some time ago
and had my first crash tonight.
The system was completely frozen and the console in X window
state and didn't respond to SysRq, so I didn't get an OOPS.
But the kernellog shows one irregularity:

Dec 12 16:25:57 dag kernel: drivers/usb/host/uhci-hcd.c: 1080: wakeup_hc
Dec 12 16:25:59 dag kernel: drivers/usb/host/uhci-hcd.c: 1080: suspend_hc
.......
Dec 13 02:01:59 dag kernel: drivers/usb/host/uhci-hcd.c: 1080: suspend_hc
Dec 13 02:01:59 dag kernel: drivers/usb/host/uhci-hcd.c: 1080: wakeup_hc
Dec 13 02:02:02 dag kernel: drivers/usb/host/uhci-hcd.c: 1080: suspend_hc
Dec 13 02:02:02 dag kernel: drivers/usb/host/uhci-hcd.c: 1080: wakeup_hc
(This was obviously the  time of the crash)

It seems to have been looping with about 3 sec intervals.

The system is a 2x500MHz Pentium3, Intel N440BX motherboard
and it was very busy yesterday compiling a lot of software (still was
when it crashed)
There was absolutely NO activity on the USB yesterday.

BRGDS

-- 
Dag Nygren                               email: dag@newtech.fi
Oy Espoon NewTech Ab                     phone: +358 9 8024910
Träsktorpet 3                              fax: +358 9 8024916
02360 ESBO                              Mobile: +358 400 426312
FINLAND


