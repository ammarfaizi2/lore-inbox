Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267478AbUI1CV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267478AbUI1CV5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 22:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267483AbUI1CV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 22:21:57 -0400
Received: from [211.155.249.251] ([211.155.249.251]:41762 "EHLO
	nnt.neonetech.com") by vger.kernel.org with ESMTP id S267478AbUI1CVz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 22:21:55 -0400
Date: Tue, 28 Sep 2004 10:21:57 +0800
From: "xuhaoz" <xuhaoz@neonetech.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: printk can't display %d number , but can display %u, %s, ....
X-mailer: Foxmail 5.0 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Message-ID: <NNTD5euwdUTaGmvSVMu000001e7@nnt.neonetech.com>
X-OriginalArrivalTime: 28 Sep 2004 02:25:51.0406 (UTC) FILETIME=[7922D4E0:01C4A502]
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



			xuhaoz@neonetech.com

