Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263442AbUC3ISl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 03:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263436AbUC3ISl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 03:18:41 -0500
Received: from [193.141.139.228] ([193.141.139.228]:18059 "EHLO
	mail01.hpce.nec.com") by vger.kernel.org with ESMTP id S263375AbUC3ISi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 03:18:38 -0500
From: Erich Focht <efocht@hpce.nec.com>
To: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
Subject: Re: Migrate pages from a ccNUMA node to another
Date: Tue, 30 Mar 2004 01:16:01 +0200
User-Agent: KMail/1.5.4
References: <4063F188.66DB690A@nospam.org>
In-Reply-To: <4063F188.66DB690A@nospam.org>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403300116.01877.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Szia Zoltan,

I like the aproach very much and was hoping that someone will bring
on-demand page migration to Linux. 

> - Migrate pages identified by their physical addresses to another NUMA node
You want this only for your "AI" keeping track of the hw counters in
the chipset? I hope you can teach it to keep track of the bandwidth of
all processes on the machine, otherwise it might disturb the processes
more than it helps them... and waste the machine's bandwidth with
migrating pages.

> - Migrate pages of a virtual user address range to another NUMA node
This is good. I'm thinking about the rss/node patches, they would tell
you when you should think about migrating something for a process. My
current usage model would be simpler: for a given mm migrate all pages
currently on node A to node B. But the flexibility of your API will
certainly not remain unused.

...

> BTW Has someone a machine with a chip set other than i82870 ?
??? As far as I know SGI, HP, NEC and IBM have all their own NUMA
chipsets for IA64. Was this the question? Are you looking for hardware
counters?

Regards,
Erich


