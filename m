Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbUCQXxt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 18:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbUCQXxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 18:53:48 -0500
Received: from ns.suse.de ([195.135.220.2]:12171 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262213AbUCQXxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 18:53:47 -0500
Date: Thu, 18 Mar 2004 00:53:45 +0100
From: Andi Kleen <ak@suse.de>
To: jim.houston@comcast.net
Cc: akpm@osdl.org, amitkale@emsyssoft.com, linux-kernel@vger.kernel.org
Subject: Re: Fixes for .cfi directives for x86_64 kgdb
Message-Id: <20040318005345.330abf19.ak@suse.de>
In-Reply-To: <m33c8788ac.fsf@new.localdomain>
References: <m33c8788ac.fsf@new.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Mar 2004 16:37:15 -0500
Jim Houston <jim.houston@comcast.net> wrote:

> 
> Hi Andi, Andrew, Amit,
> 
> The attached patch fixes the .cfi directives for the common_interrupt
> path for opteron.  It seems that the existing .cfi directives in this
> path only work by accident.
> 
> I spent yesterday decoding a stack by hand and looking at the
> dwarf unwind data using "readelf -wF".  I found that the  existing
> .cfi directives describe registers sharing the same stack addresses
> (not a good thing).
> 
> This patch makes the unwind data make sense and makes gdb/kgdb more
> likely to produce a useful stack traces.

Thanks. I applied it. The calling.h part gave rejects, but I applied it
by hand. It would be nice if you could check in the final kernel if I didn't
make a mistake.

-Andi


