Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWHRFdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWHRFdT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 01:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWHRFdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 01:33:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7910 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964796AbWHRFdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 01:33:18 -0400
Date: Thu, 17 Aug 2006 22:31:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: rohitseth@google.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH 2/7] UBC: core (structures, API)
Message-Id: <20060817223137.ca4951ff.akpm@osdl.org>
In-Reply-To: <44E458C4.9030902@sw.ru>
References: <44E33893.6020700@sw.ru>
	<44E33BB6.3050504@sw.ru>
	<1155751868.22595.65.camel@galaxy.corp.google.com>
	<44E458C4.9030902@sw.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2006 15:53:40 +0400
Kirill Korotaev <dev@sw.ru> wrote:

> >>+struct user_beancounter
> >>+{
> >>+	atomic_t		ub_refcount;
> >>+	spinlock_t		ub_lock;
> >>+	uid_t			ub_uid;
> > 
> > 
> > Why uid?  Will it be possible to club processes belonging to different
> > users to same bean counter.
> oh, its a misname. Should be ub_id. it is ID of user_beancounter
> and has nothing to do with user id.

But it uses a uid_t.  That's more than a misnaming?
