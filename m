Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751602AbWCXJQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbWCXJQN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 04:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbWCXJQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 04:16:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15538 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751602AbWCXJQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 04:16:11 -0500
Date: Fri, 24 Mar 2006 01:12:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: vgoyal@in.ibm.com
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org, torvalds@osdl.org,
       ebiederm@xmission.com, galak@kernel.crashing.org, gregkh@suse.de,
       bcrl@kvack.org, dave.jiang@gmail.com, arjan@infradead.org,
       maneesh@in.ibm.com, muralim@in.ibm.com
Subject: Re: [RFC][PATCH 0/10] 64 bit resources
Message-Id: <20060324011217.7b8aade1.akpm@osdl.org>
In-Reply-To: <20060323195752.GD7175@in.ibm.com>
References: <20060323195752.GD7175@in.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> wrote:
>
> Hi,
> 
> Here is an attempt to implement support for 64 bit resources. This will
> enable memory more than 4G to be exported through /proc/iomem, which is used
> by kexec/kdump to determine the physical memory layout of the system.
> 
> ...
> 
> We used "make allyesconfig" with CONFIG_DEBUG_INFO=n on 2.6.16-mm1.
> 
> i386
> ----
> 
> vmlinux size without patch: 40191425
> vmlinux size with path: 40244677
> vmlinux size bloat: 52K (.13%)

ugh, that's actually a surprising amount of growth.  Could you look into it
a bit more please?  Where's it coming from?  text?  data?

A bit of growth in drivers is probably OK, as all machines load a tiny
subset of them.  But if it's core kernel, not so good.  What is the effect
on allnoconfig?
