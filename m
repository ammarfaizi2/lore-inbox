Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVAMQgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVAMQgA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 11:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVAMQgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 11:36:00 -0500
Received: from mx1.mail.ru ([194.67.23.121]:12626 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S261211AbVAMQeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 11:34:19 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: 2.6.10-ck4
Date: Thu, 13 Jan 2005 19:33:21 +0200
User-Agent: KMail/1.6.2
Cc: <linux-kernel@vger.kernel.org>, <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200501131933.21021.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problems rebooting here. Don't have them in 2.6.10 and 2.6.11-rc1.

If you want complete messages, just ask. I will write them down into 
electronic form.

First time there was an unstoppable infinite loop of quickly moving USB 
related messages. I only saw "[uhci_hcd]" string reliably. Can't reproduce.

Third time:

[<c0113160>] do_page_fault+0x0/0x562
[<c010398f>] error_code+0x2b/0x30
[<c0113160>] do_page_fault+0x0/0x562
[<c01133fe>] do_page_fault+0x97/0x562
	[repeat several times to fit console]
Code: [snip]
 <0> Kernel panic - not syncing: Fatal exception in interrupt.

Second time:

[<c0113160>] do_page_fault+0x0/0x562
[<c0113160>] do_page_fault+0x0/0x562
[<c01133fe>] do_page_fault+0x29e/0x562
	[many tty related functions snipped]
[<c0113160>] do_page_fault+0x0/0x562
[<c0113160>] do_page_fault+0x0/0x562
[<c01133fe>] do_page_fault+0x29e/0x562
Code: [snip]
 <0> Kernel panic - not syncing: Fatal exception in interrupt.

Other than that everything seems to be ok. 

	Alexey
