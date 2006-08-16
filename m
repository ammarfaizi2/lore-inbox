Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWHPST7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWHPST7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 14:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWHPST7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 14:19:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45989 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750950AbWHPST6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 14:19:58 -0400
Date: Wed, 16 Aug 2006 11:18:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: rohitseth@google.com
Cc: Kirill Korotaev <dev@sw.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH 2/7] UBC: core (structures, API)
Message-Id: <20060816111818.de1e4339.akpm@osdl.org>
In-Reply-To: <1155751868.22595.65.camel@galaxy.corp.google.com>
References: <44E33893.6020700@sw.ru>
	<44E33BB6.3050504@sw.ru>
	<1155751868.22595.65.camel@galaxy.corp.google.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2006 11:11:08 -0700
Rohit Seth <rohitseth@google.com> wrote:

> > +struct user_beancounter
> > +{
> > +	atomic_t		ub_refcount;
> > +	spinlock_t		ub_lock;
> > +	uid_t			ub_uid;
> 
> Why uid?  Will it be possible to club processes belonging to different
> users to same bean counter.

hm.  I'd have expected to see a `struct user_struct *' here, not a uid_t.
