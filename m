Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbUK1Qvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbUK1Qvb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 11:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbUK1QpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 11:45:00 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:65247 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261506AbUK1Qej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 11:34:39 -0500
Message-ID: <41AA0C98.204B19CA@tv-sign.ru>
Date: Sun, 28 Nov 2004 20:36:24 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: dipankar@in.ibm.com
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] rcu: cosmetic, delete wrong comment, use HARDIRQ_OFFSET
References: <41A9E98C.2C1D07EF@tv-sign.ru> <20041128151925.GA20894@in.ibm.com> <41A9EDB7.8020304@colorfullife.com> <20041128154227.GC20894@in.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma wrote:
> 
> Hmm. I agree with Manfred.  hardirq_count() <= (1 << HARDIRQ_SHIFT)
> was the test I arrived at since it was most explicit - One level
> of (local timer) interrupt over idle task and no softirq in between
> is OK to indicate that the cpu had seen an idle task. A bigger
> hardirq_count() indicates reentrant hardirq over idle task and we
> are no longer safe.
> 
> So, let's drop the HARDIRQ_OFFSET change.

Ok. I am resending these two patches in one.

Oleg.
