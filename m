Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262938AbUCKBml (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 20:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262935AbUCKBml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 20:42:41 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:4527 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262933AbUCKBmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 20:42:38 -0500
Date: Thu, 11 Mar 2004 10:34:47 +0900 (JST)
Message-Id: <20040311.103447.10929472.t-kochi@bq.jp.nec.com>
To: kaneshige.kenji@jp.fujitsu.com
Cc: davidm@hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix PCI interrupt setting for ia64
From: Takayoshi Kochi <t-kochi@bq.jp.nec.com>
In-Reply-To: <MDEEKOKJPMPMKGHIFAMAEELHDGAA.kaneshige.kenji@jp.fujitsu.com>
References: <16463.30226.948230.439549@napali.hpl.hp.com>
	<MDEEKOKJPMPMKGHIFAMAEELHDGAA.kaneshige.kenji@jp.fujitsu.com>
X-Mailer: Mew version 3.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: RE: [PATCH] fix PCI interrupt setting for ia64
Date: Thu, 11 Mar 2004 09:34:06 +0900

> Hi,
> 
> I'm sorry that the report falls behind. I wanted to check out by using
> real device driver which uses a probe_irq_on(), but I don't have appropriate
> environment now.
> 
> Though I didn't check out on a real machine yet, I believe my patch doesn't
> have any influence on probe_irq_on() because current probe_irq_on() calls
> startup callback to unmask the RTEs as you said before.

My concern was that if there's a buggy PCI device that raises
interrupts all the time until it's initialized by some device driver,
probe_irq_on() would not work as expected regardless of whether
your patch is applied or not.  I thought masking the interrupt line
doesn't work around this case.

---
Takayoshi Kochi <t-kochi@bq.jp.nec.com>
