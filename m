Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUCHJ0N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 04:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbUCHJ0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 04:26:13 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:31693 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262425AbUCHJ0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 04:26:10 -0500
Date: Mon, 08 Mar 2004 18:25:52 +0900 (JST)
Message-Id: <20040308.182552.55855095.t-kochi@bq.jp.nec.com>
To: benjamin.liu@intel.com
Cc: iod00d@hp.com, kaneshige.kenji@jp.fujitsu.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix PCI interrupt setting for ia64
From: Takayoshi Kochi <t-kochi@bq.jp.nec.com>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401B1A017@PDSMSX403.ccr.corp.intel.com>
References: <3ACA40606221794F80A5670F0AF15F8401B1A017@PDSMSX403.ccr.corp.intel.com>
X-Mailer: Mew version 3.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

From: "Liu, Benjamin" <benjamin.liu@intel.com>
Subject: RE: [PATCH] fix PCI interrupt setting for ia64
Date: Mon, 8 Mar 2004 15:44:16 +0800

> ISA is legacy to IA64. The configuration script of 2.4.23 has
> CONFIG_ISA off explicitly for IA64, 2.6.2 doesn't have this
> option for IA64. I just wonder whether the legacy probing
> method still exists on IA64.

I think that's still true for IDE / serial port drivers.
Kaneshige-san, could you confirm your changes are compatible
with probe_irq_on()?

Itanium-generation machines (such as BigSur) depends on
probe_irq_on() for finding serial port IRQ.

---
Takayoshi Kochi <t-kochi@bq.jp.nec.com>
