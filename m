Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263651AbTHZGMG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 02:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263644AbTHZGMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 02:12:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:44688 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263638AbTHZGME (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 02:12:04 -0400
Date: Mon, 25 Aug 2003 23:14:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix
Message-Id: <20030825231449.7de28ba6.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0308260155490.1912-100000@devserv.devel.redhat.com>
References: <20030825225011.2ad47c85.akpm@osdl.org>
	<Pine.LNX.4.44.0308260155490.1912-100000@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@redhat.com> wrote:
>
> The
>  kernel doesnt in fact know about the first use of a futex: no-contention
>  futexes have zero kernel footprint. This is the big plus of them. So i'd
>  really favor some sort of hashing method and no limits, that way the Linux
>  VM is extended and every VM address is waitable and wakable on - a pretty
>  powerful concept.

What about the option of not pinning the pages at all: just fault
them in when required?

