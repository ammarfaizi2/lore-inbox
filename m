Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbTJAG7S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 02:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbTJAG7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 02:59:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:59034 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262011AbTJAG7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 02:59:14 -0400
Date: Wed, 1 Oct 2003 00:00:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: jamie@shareable.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata 
 patch
Message-Id: <20031001000015.69007e85.akpm@osdl.org>
In-Reply-To: <p73k77pzc69.fsf@oldwotan.suse.de>
References: <7F740D512C7C1046AB53446D3720017304AFCF@scsmsx402.sc.intel.com.suse.lists.linux.kernel>
	<20031001053833.GB1131@mail.shareable.org.suse.lists.linux.kernel>
	<20030930224853.15073447.akpm@osdl.org.suse.lists.linux.kernel>
	<20031001061348.GE1131@mail.shareable.org.suse.lists.linux.kernel>
	<20030930233258.37ed9f7f.akpm@osdl.org.suse.lists.linux.kernel>
	<p73k77pzc69.fsf@oldwotan.suse.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
> > Looking at Andi's patch, it is also a dead box if the fault happens inside
> > down_write(mmap_sem).  That should be fixed, methinks.
> 
> The only way to fix all that would be to move the instruction checks early
> into the fast path.

Well the deadlock avoidance only needs to happen if the fault occured in
kernel mode.  Presumably most faults are in userspace, so most of the
overhead can be avoided.


