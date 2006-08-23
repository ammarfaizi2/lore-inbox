Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965297AbWHWXEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965297AbWHWXEi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 19:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965299AbWHWXEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 19:04:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16074 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965297AbWHWXEh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 19:04:37 -0400
Date: Wed, 23 Aug 2006 15:54:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Stephane Eranian <eranian@frankl.hpl.hp.com>, linux-kernel@vger.kernel.org,
       eranian@hpl.hp.com
Subject: Re: [PATCH 9/18] 2.6.17.9 perfmon2 patch for review: kernel-level
 interface support
Message-Id: <20060823155447.a9eaf7fa.akpm@osdl.org>
In-Reply-To: <20060823152959.GD32725@infradead.org>
References: <200608230806.k7N860es000444@frankl.hpl.hp.com>
	<20060823152959.GD32725@infradead.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006 16:29:59 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Aug 23, 2006 at 01:06:00AM -0700, Stephane Eranian wrote:
> > This patch contains the kernel-level API support.
> > 
> > 
> > Some users have requested the ability to create a monitoring session
> > with perfmon2 from iside the kernel using a kernel thread. Perfmon2
> > leverages a lot of kernel mechanisms which are not easy to use for
> > inside the kernel: e.g. file descriptor, signals, system calls.
> 
> Again, please drop this.  There are no planned intree kernel users
> so far, and once we add them we can architect a proper API for them.
> Getting rid of this should also help to collapse the tons of useless
> abstractions layers in the current perfmon code.
> 

Yes, I think we either need a stronger argument for including this code, or
we drop it.

It is especially worrisome that the exports which are added here are plain
old EXPORT_SYMBOL().

