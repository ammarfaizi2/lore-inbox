Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267396AbUHDT1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267396AbUHDT1L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 15:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267393AbUHDT0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 15:26:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:7094 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267398AbUHDTZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 15:25:51 -0400
Date: Wed, 4 Aug 2004 12:24:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: kernel@kolivas.org, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.8-rc2-mm2 performance improvements (scheduler?)
Message-Id: <20040804122414.4f8649df.akpm@osdl.org>
In-Reply-To: <7480000.1091632378@[10.10.2.4]>
References: <6560000.1091632215@[10.10.2.4]>
	<7480000.1091632378@[10.10.2.4]>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> SDET 8  (see disclaimer)
>                             Throughput    Std. Dev
>                      2.6.7       100.0%         0.2%
>                  2.6.8-rc2       100.2%         1.0%
>              2.6.8-rc2-mm2       117.4%         0.9%
> 
>  SDET 16  (see disclaimer)
>                             Throughput    Std. Dev
>                      2.6.7       100.0%         0.3%
>                  2.6.8-rc2        99.5%         0.3%
>              2.6.8-rc2-mm2       118.5%         0.6%

hum, interesting.  Can Con's changes affect the inter-node and inter-cpu
balancing decisions, or is this all due to caching effects, reduced context
switching etc?

I don't expect we'll be merging a new CPU scheduler into mainline any time
soon, but we should work to understand where this improvement came from,
and see if we can get the mainline scheduler to catch up.
