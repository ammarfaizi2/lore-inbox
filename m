Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264596AbTDPUYy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 16:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264597AbTDPUYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 16:24:54 -0400
Received: from [12.47.58.203] ([12.47.58.203]:64563 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264596AbTDPUYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 16:24:52 -0400
Date: Wed, 16 Apr 2003 13:35:39 -0700
From: Andrew Morton <akpm@digeo.com>
To: Matthew Wilcox <willy@debian.org>
Cc: ak@muc.de, willy@debian.org, davem@redhat.com,
       linux-kernel@vger.kernel.org, anton@samba.org, schwidefsky@de.ibm.com,
       davidm@hpl.hp.com, matthew@wil.cx, ralf@linux-mips.org, rth@redhat.com
Subject: Re: Reduce struct page by 8 bytes on 64bit
Message-Id: <20030416133539.0ac01968.akpm@digeo.com>
In-Reply-To: <20030416151112.GB1505@parcelfarce.linux.theplanet.co.uk>
References: <20030415112430.GA21072@averell>
	<20030416.054521.26525548.davem@redhat.com>
	<20030416140715.GA2159@averell>
	<20030416.072638.65480350.davem@redhat.com>
	<20030416144312.GA2327@averell>
	<20030416145532.GA1505@parcelfarce.linux.theplanet.co.uk>
	<20030416150427.GA2496@averell>
	<20030416151112.GB1505@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Apr 2003 20:36:39.0933 (UTC) FILETIME=[E22642D0:01C30457]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@debian.org> wrote:
>
> Jacob's would break if we hashed to different spinlocks.  But we don't, we
> shift right by 8, so we get the same spinlock for atomic things that are on
> the same "cacheline" (i think PA cachelines are actually 64 or 128 bytes,
> depending on model).
> 

Are you prepared to cast this in stone?

If so then I think Jacob's approach would be preferable, don't you agree?

It needs some compiler-detection magic around the anon union though.
