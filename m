Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbVFPVCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbVFPVCN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 17:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbVFPVCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 17:02:13 -0400
Received: from mail.dif.dk ([193.138.115.101]:41661 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261828AbVFPVCI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 17:02:08 -0400
Date: Thu, 16 Jun 2005 23:07:34 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "Richard B. Johnson" <linux-os@analogic.com>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Andrew Morton <akpm@osdl.org>,
       David Mosberger-Tang <davidm@hpl.hp.com>,
       Stephane Eranian <eranian@hpl.hp.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [resend][PATCH] avoid signed vs unsigned comparison in
 efi_range_is_wc()
In-Reply-To: <Pine.LNX.4.61.0506161629220.3712@chaos.analogic.com>
Message-ID: <Pine.LNX.4.62.0506162306300.2477@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0506162219040.2477@dragon.hyggekrogen.localhost>
 <Pine.LNX.4.61.0506161629220.3712@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2005, Richard B. Johnson wrote:

> 
> Well long and int are the same size on ix86. What you really need
> is 'size_t' for counters. That's the largest unsigned integer that
> will fit in a register on the target platform. It is platform-
> specific, therefore defined in stddef.h. No index or return-value
> is supposed to be larger than what can be represented in size_t,
> therefore it is a good type to use.
> 
> Note that on 64-bit platforms, size_t will be larger than an unsigned
> int. This is good.
> 
Good info, thanks Richard.

-- 
Jesper


