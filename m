Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVESTFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVESTFI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 15:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVESTFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 15:05:07 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:21514 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261223AbVESTEz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 15:04:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:from:to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole;
        b=IKN93iobxLm8guadNEEIzyJiZjKJzP8R2u9ekvLHoh9d853IEwh5xGFKRMSN1tzeclfSeD8pZl2btl74kpKP1XZcS3GIxGTYYNntwBUSlQ7fE4HeEVfquUqLr+uKAF/3ePXA+PXOaXCAAeKcJlMqL8XrtmLhg5G5TuSjWHp6YRc=
Message-ID: <02e801c55ca5$7a9d1000$1a4da8c0@NELSON2>
From: "Gianluca Varenni" <gianluca.varenni@gmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: Problem mapping small PCI memory space.
Date: Thu, 19 May 2005 12:03:43 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I'm writing a driver for a PCI board that exposes two memory spaces (out of
the 6 IO address regions).

One of them is 1MB, and I can map it to user level without problems. The
other one is only 512 bytes.
If I try to open it with /dev/mem, it returns EINVAL (the 1MB memory space
is opened without any problem). If I try to expose it through mmap, mmap
succeeds, but I only see garbage at user level. At kernel level, I can
access that 512 bytes memory by using ioremap() on the physical address
returned by pci_resource_start().

Are there any lower limits on the size of a PCI memory region?

Have a nice day
GV


