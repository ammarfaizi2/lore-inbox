Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263935AbTICBQu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 21:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263940AbTICBQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 21:16:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:14550 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263935AbTICBQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 21:16:48 -0400
Date: Tue, 2 Sep 2003 18:16:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: jamie@shareable.org, hugh@veritas.com, mingo@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix
Message-Id: <20030902181653.721a41ea.akpm@osdl.org>
In-Reply-To: <20030903010318.0A46B2C0FC@lists.samba.org>
References: <20030902065144.GC7619@mail.jlokier.co.uk>
	<20030903010318.0A46B2C0FC@lists.samba.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
>  I don't know of a rule which says "thou shalt not wake a random thread
>  in the kernel": for all I know wierd things like CPU hotplug or
>  software suspend may do this in the future.

pdflush is sensitive to that.  It emits angry squeaks if unexpectedly woken.

And up until a couple of months ago there were sporadic squeaking reports,
but they seem to have gone away.

Yes, we should treat a random wakeup like that as a bug.

