Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbTJAA1a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 20:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbTJAA1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 20:27:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:17331 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261827AbTJAA12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 20:27:28 -0400
Date: Tue, 30 Sep 2003 17:27:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: davej@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       richard.brunner@amd.com
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata
 patch
Message-Id: <20030930172715.18acace9.akpm@osdl.org>
In-Reply-To: <20030930235528.GA32209@mail.shareable.org>
References: <20030930073814.GA26649@mail.jlokier.co.uk>
	<20030930132211.GA23333@redhat.com>
	<20030930133936.GA28876@mail.shareable.org>
	<20030930135324.GC5507@redhat.com>
	<20030930144526.GC28876@mail.shareable.org>
	<20030930150825.GD5507@redhat.com>
	<20030930165450.GF28876@mail.shareable.org>
	<20030930172618.GE5507@redhat.com>
	<20030930235528.GA32209@mail.shareable.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> wrote:
>
> What I'd really like your opinion on is the appropriate userspace
> behaviour.  If we don't care about fixing up userspace, then
> __ex_table is a much tidier workaround for the prefetch bug.

I think we should fix up userspace.

>  If we do
> care about fixing up userspace, then do we need a policy decision that
> says it's not acceptable to run on AMD without userspace fixups from
> 2.6.0 onwards - it must fixup userspace or refuse to run?

If you're saying that the kernel should refuse to boot if it discovers that
a) the CPU needs the workaround and b) the kernel does not implement the
workaround then yup.

