Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbTEFEOH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 00:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbTEFEOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 00:14:07 -0400
Received: from [12.47.58.20] ([12.47.58.20]:3083 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262336AbTEFEOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 00:14:06 -0400
Date: Mon, 5 May 2003 21:28:16 -0700
From: Andrew Morton <akpm@digeo.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: davem@redhat.com, dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc_percpu
Message-Id: <20030505212816.7cb0ec49.akpm@digeo.com>
In-Reply-To: <20030506040856.8B3712C36E@lists.samba.org>
References: <1052187119.983.5.camel@rth.ninka.net>
	<20030506040856.8B3712C36E@lists.samba.org>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 May 2003 04:26:30.0877 (UTC) FILETIME=[AB1C30D0:01C31387]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> > I think the fixed size pool is perfectly reasonable.
> 
> Yes.  It's a tradeoff.  I think it's worth it at the moment (although
> I'll add a limited printk to __alloc_percpu if it fails).
> 

It's OK as long as nobody uses the feature!  Once it starts to be commonly
used (say, in driver ->open() methods) then we'll get into the same problems
as with vmalloc exhaustion, vmalloc fragmentation, large physically-contig
allocations, etc.

Ho-hum.  Can the magical constant become a __setup thing?
