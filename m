Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVFJSm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVFJSm6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 14:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVFJSmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 14:42:55 -0400
Received: from karma.reboot.ca ([67.15.48.17]:60549 "EHLO karma.reboot.ca")
	by vger.kernel.org with ESMTP id S261169AbVFJSmq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 14:42:46 -0400
X-ClientAddr: 70.67.196.121
Message-ID: <00fb01c56dec$91f0e440$6702a8c0@niro>
From: "Andre" <andre@rocklandocean.com>
To: <linux-kernel@vger.kernel.org>
Subject: ZFx86 support broken?
Date: Fri, 10 Jun 2005 11:45:27 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-Reboot-MailScanner-Information: Please contact the ISP for more information
X-Reboot-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-Reboot-MailScanner-SpamCheck: not spam, SpamAssassin (score=-0.728,
	required 5, autolearn=spam, AWL -0.12, BAYES_00 -2.60,
	RCVD_IN_SORBS_DUL 1.99)
X-MailScanner-From: andre@rocklandocean.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to boot LFS6.0.1 livecd which has 2.6.8.1, but the kernel hangs
at:
Freeing unused kernel memory: 456k freed

My system is a pc/104 board based on ZFx86 with 64M ram
I also found this posting:
http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-03/5939.html
Looking at the console output, the cpu gets recognized as 486, whereas
2.4.22 detects the cpu as Cyrix Cx486DX4

Looking at the kernel source, it seems to get stuck after the call to
free_initmem and when I tried to specify init=/bin/sh it still got stuck at
the same place so I figured it doesn't even get to the run_init_process
calls in ..../init/main.c. Could the call to unlock_kernel get stuck?
