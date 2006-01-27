Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422660AbWA0XHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422660AbWA0XHF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 18:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbWA0XHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 18:07:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49794 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422660AbWA0XHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 18:07:01 -0500
Date: Fri, 27 Jan 2006 15:08:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: kiran@scalex86.org, dada1@cosmosbay.com, davem@davemloft.net,
       linux-kernel@vger.kernel.org, shai@scalex86.org, netdev@vger.kernel.org,
       pravins@calsoftinc.com
Subject: Re: [patch 3/4] net: Percpufy frequently used variables --
 proto.sockets_allocated
Message-Id: <20060127150847.48c312c0.akpm@osdl.org>
In-Reply-To: <20060127150106.38b9e041.akpm@osdl.org>
References: <20060126185649.GB3651@localhost.localdomain>
	<20060126190357.GE3651@localhost.localdomain>
	<43D9DFA1.9070802@cosmosbay.com>
	<20060127195227.GA3565@localhost.localdomain>
	<20060127121602.18bc3f25.akpm@osdl.org>
	<20060127224433.GB3565@localhost.localdomain>
	<20060127150106.38b9e041.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Oh, and because vm_acct_memory() is counting a singleton object, it can use
> DEFINE_PER_CPU rather than alloc_percpu(), so it saves on a bit of kmalloc
> overhead.

Actually, I don't think that's true.  we're allocating a sizeof(long) with
kmalloc_node() so there shouldn't be memory wastage.

