Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310647AbSCHCBQ>; Thu, 7 Mar 2002 21:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310646AbSCHCBG>; Thu, 7 Mar 2002 21:01:06 -0500
Received: from maillog.promise.com.tw ([210.244.60.166]:22520 "EHLO
	maillog.promise.com.tw") by vger.kernel.org with ESMTP
	id <S310640AbSCHCA5>; Thu, 7 Mar 2002 21:00:57 -0500
Message-ID: <00cd01c1c644$f6da4520$59cca8c0@hank>
From: "Hank Yang" <hanky@promise.com.tw>
To: "Martin Dalecki" <dalecki@evision-ventures.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
        "Linus Chen" <linusc@promise.com.tw>
In-Reply-To: <014701c1c5b6$a0dfb620$59cca8c0@hank> <3C876199.5000107@evision-ventures.com>
Subject: Re: [PATCH] Submitting PROMISE IDE Controllers Driver Patch
Date: Fri, 8 Mar 2002 10:00:04 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1. Are there any praticular reasons for the fact that you
>     define the PCI_VENDOR_ID_PROMISE in ide-disk.c instead of
>     the kernel global ID header.

I find out it's already defined in pci_ids.h so shouldnt be needed here.
We will update this point later.
 
> 2. Why are you gurading all lba48 accesses by the promise
>     vendor id?

That's because we don't want to influence the on-board IDE and other IDE
controller's R/W routine. So it will just works on PROMISE controllers.
 
> 3. Are there any reasons for enabling the IDEDMA_TIMEOUT handling
>     unconditionally?

If we enable IDEDMA_TIMEOUT, kernel will look for
ide_dma_timeout_revovery() to retry again when drive's DMA timeout.

Thank you for yours efforts to look at this patch.

Best Regards
Hank Yang


