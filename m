Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbWBQGm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWBQGm0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 01:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbWBQGm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 01:42:26 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:46732 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932357AbWBQGm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 01:42:26 -0500
Date: Thu, 16 Feb 2006 22:42:07 -0800
From: Paul Jackson <pj@sgi.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: Robust futexes
Message-Id: <20060216224207.98526b40.pj@sgi.com>
In-Reply-To: <1140152271.25078.42.camel@localhost.localdomain>
References: <1140152271.25078.42.camel@localhost.localdomain>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty wrote:
>  having futex
> calls which tell the kernel that the u32 value is in fact the holder's
> TID?

Huh - I must be dense.  When would these calls be made?
Once per task creation, once per allocation of memory
for the lock, once per contested lock attempt, once per
uncontested lock attempt, ... ?

With Ingo's robust_futexes, you could have a task that
has taken and released a gazillion futex locks, and is
still at the present moment holding 47 of them, drop dead
and be able to initiate cleanup of exactly those 47 locks,
never having made but one system call at the birth of the
thread.

Can your idea do that?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
