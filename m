Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265667AbTBJXD4>; Mon, 10 Feb 2003 18:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265589AbTBJXD4>; Mon, 10 Feb 2003 18:03:56 -0500
Received: from packet.digeo.com ([12.110.80.53]:13822 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265532AbTBJXDz>;
	Mon, 10 Feb 2003 18:03:55 -0500
Date: Mon, 10 Feb 2003 15:12:44 -0800
From: Andrew Morton <akpm@digeo.com>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@transmeta.com, dhowells@redhat.com, jgarzik@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: extra PG_* bits for page->flags
Message-Id: <20030210151244.7e42d3fb.akpm@digeo.com>
In-Reply-To: <20459.1044874267@warthog.cambridge.redhat.com>
References: <20459.1044874267@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Feb 2003 23:13:35.0691 (UTC) FILETIME=[098729B0:01C2D15A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> 
> Hi Linus,
> 
> I'm writing a cache filesystem for primarily for caching AFS pages, but that
> also can be used for caching other network FS pages (such as NFSv4, which Jeff
> Garzik and Trond Myklebust are interested in, I think).

Is a new fs needed?  Is it not possible to use an existing filesystem of the
user's choice for local caching?

> ...
> 
>  (*) PG_journal
>  (*) PG_journalmark

Well.  If you new fs goes in then yes, we can spare those bits (just).  If
possible, consider making them "opaque address_space-private", so this prime
real estate can be shared with other filesystems (eg, PG_checked).

