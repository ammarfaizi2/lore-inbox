Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWA2Ba0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWA2Ba0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 20:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWA2Ba0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 20:30:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59563 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750801AbWA2BaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 20:30:25 -0500
Date: Sat, 28 Jan 2006 17:29:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: dada1@cosmosbay.com, kiran@scalex86.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, shai@scalex86.org, netdev@vger.kernel.org,
       pravins@calsoftinc.com
Subject: Re: [patch 3/4] net: Percpufy frequently used variables --
 proto.sockets_allocated
Message-Id: <20060128172956.54bcdb19.akpm@osdl.org>
In-Reply-To: <20060129011944.GB24099@kvack.org>
References: <20060126190357.GE3651@localhost.localdomain>
	<43D9DFA1.9070802@cosmosbay.com>
	<20060127195227.GA3565@localhost.localdomain>
	<20060127121602.18bc3f25.akpm@osdl.org>
	<20060127224433.GB3565@localhost.localdomain>
	<43DAA586.5050609@cosmosbay.com>
	<20060127151635.3a149fe2.akpm@osdl.org>
	<43DABAA4.8040208@cosmosbay.com>
	<20060129004459.GA24099@kvack.org>
	<20060128165549.262f2b90.akpm@osdl.org>
	<20060129011944.GB24099@kvack.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise <bcrl@kvack.org> wrote:
>
> On Sat, Jan 28, 2006 at 04:55:49PM -0800, Andrew Morton wrote:
> > local_t isn't much use until we get rid of asm-generic/local.h.  Bloaty,
> > racy with nested interrupts.
> 
> The overuse of atomics is horrific in what is being proposed.

Well yeah, it wasn't really a very serious proposal.  There's some
significant work yet to be done on this stuff.

> Perhaps it's time to add a #error in asm-generic/local.h?

heh, or #warning "you suck" or something.
