Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268526AbUIXHjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268526AbUIXHjo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 03:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268535AbUIXHjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 03:39:44 -0400
Received: from [211.155.249.251] ([211.155.249.251]:32014 "EHLO
	nnt.neonetech.com") by vger.kernel.org with ESMTP id S268526AbUIXHjJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 03:39:09 -0400
Date: Fri, 24 Sep 2004 15:39:07 +0800
From: "xuhaoz" <xuhaoz@neonetech.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: printk can't display %d, but can display %u, %x, ......, why?
X-mailer: Foxmail 5.0 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Message-ID: <NNTIbnZQ9qGeyEBFztZ00000016@nnt.neonetech.com>
X-OriginalArrivalTime: 24 Sep 2004 07:43:01.0312 (UTC) FILETIME=[1E310C00:01C4A20A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	
 Hi:

	Yesterday, I found a strangeous problem that printk in my OS can't print %d format number, but can print %u, %x ...

	why?

    let's see an example:

			unsigned int memsize;
		
			memsize=64;
		
			printk("memsize unknown: setting to %dMB\n",memsize);

			if I use %d to display, the result of memsize is -18446744073709551552MB

            printk("memsize unknown: setting to %uMB\n",memsize);

			if I use %u to display ,the result of memsize is 64MB

	Would you please tell me what leads to this problem?

