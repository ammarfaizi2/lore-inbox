Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262337AbUKKUdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbUKKUdR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 15:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbUKKUdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 15:33:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:28299 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262337AbUKKUdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 15:33:14 -0500
Date: Thu, 11 Nov 2004 12:32:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, davidm@snapgear.com, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org
Subject: Re: [PATCH] Bit operations
Message-Id: <20041111123251.653eb082.akpm@osdl.org>
In-Reply-To: <29033.1100177349@redhat.com>
References: <200411081432.iA8EWfnc023411@warthog.cambridge.redhat.com>
	<29033.1100177349@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> 
> Hi Andrew,
> 
> > The attached patch provides an out-of-line implementation of find_next_bit()
> > and rearranges linux/bitops.h to avoid a dependency loop between inline
> > functions in there and in asm/bitops.h trying to include one another.
> 
> Is there any reason you dropped the part of this patch that rearranged
> linux/bitops.h? asm/bitops.h may need generic_ffs() for implementing
> sched_find_first_bit(), and obviously asm/bitops.h can't include
> linux/bitops.h.

I was doing a reject fixup and restored the thing back in what seemed a
better place.  Of course, had it been commented, that wouldn't have
happened.  It is commented now.

