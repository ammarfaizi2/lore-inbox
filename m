Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbUK2K7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbUK2K7z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 05:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbUK2K6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 05:58:42 -0500
Received: from smarthost2.mail.uk.easynet.net ([212.135.6.12]:30736 "EHLO
	smarthost2.mail.uk.easynet.net") by vger.kernel.org with ESMTP
	id S261656AbUK2K5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 05:57:36 -0500
Message-ID: <41AB0077.5020508@treblig.org>
Date: Mon, 29 Nov 2004 10:56:55 +0000
From: "Dave Gilbert (Home)" <gilbertd@treblig.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040804
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.28: dma_timer_expiry/__ide_dma_test_irq ServerWorks CSB5
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-TL-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   Kernel: Standard 2.4.28
   Hardware: IBM xSeries 305 with ServerWorks CSB5 IDE controller and a 
pair of IC35L090AVV207-0 drives; one per channel.  IDE CD-ROM as slave
on first channel, no slave on the second.
   Symptom: dma_timer_expiry occasionally (~ once/week)

-----------------------------------------
hdc: dma_timer_expiry: dma status == 0x20
hdc: timeout waiting for DMA
hdc: timeout waiting for DMA
hdc: (__ide_dma_test_irq) called while not waiting
hdc: status timeout: status=0xd0 { Busy }

hdc: drive not ready for command
ide1: reset: success

----------------------------------------

it then seems to recover - (this is better than the 2.4.21
we had on there previously which died after that).

Any ideas? Dying disk?

Dave
