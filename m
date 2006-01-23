Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbWAWHwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbWAWHwG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 02:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbWAWHwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 02:52:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39563 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964885AbWAWHwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 02:52:05 -0500
Date: Sun, 22 Jan 2006 23:51:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: agk@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] device-mapper log bitset: fix endian
Message-Id: <20060122235130.0b8788df.akpm@osdl.org>
In-Reply-To: <1138002267.2977.19.camel@laptopd505.fenrus.org>
References: <20060120211300.GC4724@agk.surrey.redhat.com>
	<20060122213741.7d2ed8ef.akpm@osdl.org>
	<1138002267.2977.19.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
>
> On Sun, 2006-01-22 at 21:37 -0800, Andrew Morton wrote:
> > Alasdair G Kergon <agk@redhat.com> wrote:
> > >
> > >  -	set_bit(bit, (unsigned long *) bs);
> > >  +	ext2_set_bit(bit, (unsigned long *) bs);
> > 
> > We really should give those things a more appropriate name.
> 
> or... kill them in favor of the real set_bit/__set_bit ?

No, they do different things on little-endian machines.
