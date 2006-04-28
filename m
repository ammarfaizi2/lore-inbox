Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030362AbWD1I3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030362AbWD1I3i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 04:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030361AbWD1I3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 04:29:38 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:33964 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030362AbWD1I3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 04:29:37 -0400
Date: Fri, 28 Apr 2006 17:28:48 +0900
From: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: efault@gmx.de, akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net, maeda.naoaki@jp.fujitsu.com
Subject: Re: [ckrm-tech] Re: [PATCH 0/9] CPU controller
Message-Id: <20060428172848.df4baead.maeda.naoaki@jp.fujitsu.com>
In-Reply-To: <4451AEA4.1040108@sw.ru>
References: <20060428013730.9582.9351.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
	<1146201936.7523.15.camel@homer>
	<4451AEA4.1040108@sw.ru>
Organization: FUJITSU LIMITED
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2006 09:56:52 +0400
Kirill Korotaev <dev@sw.ru> wrote:

> Also, as it turned out these doesn't do good fair scheduling under some 
> curcemstances (with busy loops on SMP) :(. Which was reported to MAEDA.

Although it has buggy behaviour under some circumstances, 
the foundamental problem of load unfairness on SMP comes from
the fact that a single task can not use more than one CPU at a time.
On condtion that there aren't enough number of runnable tasks on SMP,
achievable shares very depend on how tasks are allocated to CPU. 

So a few busy loops on SMP is a tough case. It is alleviated
by increasing the number of runnable tasks.

Thanks,
MAEDA Naoaki
