Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932615AbVHSKVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932615AbVHSKVM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 06:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbVHSKVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 06:21:11 -0400
Received: from [80.71.243.242] ([80.71.243.242]:10458 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S932615AbVHSKVJ (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Fri, 19 Aug 2005 06:21:09 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17157.45712.877795.437505@gargle.gargle.HOWL>
Date: Fri, 19 Aug 2005 14:21:04 +0400
To: Howard Chu <hyc@symas.com>
Cc: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: Re: sched_yield() makes OpenLDAP slow
In-Reply-To: <43057641.70700@symas.com>
References: <43057641.70700@symas.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howard Chu <hyc@symas.com> writes:

[...]

> concurrency. It is the nature of such a system to encounter deadlocks
> over the normal course of operations. When a deadlock is detected, some
> thread must be chosen (by one of a variety of algorithms) to abort its
> transaction, in order to allow other operations to proceed to
> completion. In this situation, the chosen thread must get control of the
> CPU long enough to clean itself up,

What prevents transaction monitor from using, say, condition variables
to "yield cpu"? That would have an additional advantage of blocking
thread precisely until specific event occurs, instead of blocking for
some vague indeterminate load and platform dependent amount of time.

>                                     and then it must yield the CPU in
> order to allow any other competing threads to complete their
> transaction.

Again, this sounds like thing doable with standard POSIX synchronization
primitives.

>
> -- 
>   -- Howard Chu

Nikita.
