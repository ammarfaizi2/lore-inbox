Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbVIQOcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbVIQOcT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 10:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbVIQOcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 10:32:18 -0400
Received: from ozlabs.org ([203.10.76.45]:34182 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750848AbVIQOcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 10:32:18 -0400
Date: Sun, 18 Sep 2005 00:32:05 +1000
From: Anton Blanchard <anton@samba.org>
To: Tejun Heo <htejun@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [QUESTION] The cost of local interrupt enable/disable
Message-ID: <20050917143204.GA17639@krispykreme>
References: <432C2169.2090300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432C2169.2090300@gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

>  I'm curious about the cost of local_irq_enable/disable()'s on various 
> architectures.  I found a freebsd discussion thread by googling which 
> says that each takes 3 cycles on i386 (very cheap), but for Pentium4, 
> people are talking in the order of several hundreds cycles.  Are these 
> correct?  How about other architectures?

It varies on ppc64, but its in the order of 10s of cycles. 40-50 cycles
is probably a decent estimation.

Anton
