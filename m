Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbWBFEfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbWBFEfD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 23:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbWBFEfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 23:35:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1992 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750966AbWBFEfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 23:35:01 -0500
Date: Sun, 5 Feb 2006 20:33:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: pj@sgi.com, dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-Id: <20060205203358.1fdcea43.akpm@osdl.org>
In-Reply-To: <20060204154944.36387a86.akpm@osdl.org>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<20060204154944.36387a86.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Paul Jackson <pj@sgi.com> wrote:
>  >
>  > From: Paul Jackson <pj@sgi.com>
>  > 
>  > This patch provides the implementation and cpuset interface for
>  > an alternative memory allocation policy that can be applied to
>  > certain kinds of memory allocations, such as the page cache (file
>  > system buffers) and some slab caches (such as inode caches).
>  > 
>  > ...
>  >
>  > A new per-cpuset file, "memory_spread", is defined.  This is
>  > a boolean flag file, containing a "0" (off) or "1" (on).
>  > By default it is off, and the kernel allocation placement
>  > is unchanged.  If it is turned on for a given cpuset (write a
>  > "1" to that cpusets memory_spread file) then the alternative
>  > policy applies to all tasks in that cpuset.
> 
>  I'd have thought it would be saner to split these things apart:
>  "slab_spread", "pagecache_spread", etc.

This, please.   It impacts the design of the whole thing.

