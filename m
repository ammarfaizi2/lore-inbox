Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbUCKTVg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 14:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbUCKTVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 14:21:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:21675 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261665AbUCKTVd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 14:21:33 -0500
Date: Thu, 11 Mar 2004 11:21:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rik Faith <faith@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Light-weight Auditing Framework
Message-Id: <20040311112132.6970a70c.akpm@osdl.org>
In-Reply-To: <16464.30442.852919.24605@neuro.alephnull.com>
References: <16464.30442.852919.24605@neuro.alephnull.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik Faith <faith@redhat.com> wrote:
>
> Below is a patch against 2.6.4 that provides a low-overhead system-call
>  auditing framework for Linux that is usable by LSM components (e.g.,
>  SELinux).

Thanks Rik.

This is not my area, but based on the earlier discussions, and on RH's
intent to distribute and support the code and on its overall footprint and
upon Stephen's words I shall proceed with this.

This patch gets non-trivial rejects against x86_64-update.patch, mainly in
thread_info.h.  Also note that arch/x86_64/ia32/ia32entry.S has gained
another usage of TIF_SYSCALL_TRACE.  Could you please rework and retest it
on top of

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4/2.6.4-mm1/broken-out/x86_64-update.patch

Or you can wait a day or so - we should merge the x86_64 patch into Linus's
tree later this week.

