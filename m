Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267189AbUJFFfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267189AbUJFFfJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 01:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267259AbUJFFfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 01:35:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:19595 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267189AbUJFFfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 01:35:01 -0400
Date: Tue, 5 Oct 2004 22:33:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: kenneth.w.chen@intel.com, mingo@redhat.com, linux-kernel@vger.kernel.org,
       judith@osdl.org
Subject: Re: Default cache_hot_time value back to 10ms
Message-Id: <20041005223307.375597ee.akpm@osdl.org>
In-Reply-To: <416380D7.9020306@yahoo.com.au>
References: <200410060042.i960gn631637@unix-os.sc.intel.com>
	<20041005205511.7746625f.akpm@osdl.org>
	<416374D5.50200@yahoo.com.au>
	<20041005215116.3b0bd028.akpm@osdl.org>
	<41637BD5.7090001@yahoo.com.au>
	<20041005220954.0602fba8.akpm@osdl.org>
	<416380D7.9020306@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Any thoughts about making -rc's into -pre's, and doing real -rc's?

I think what we have is OK.  The idea is that once 2.6.9 is released we
merge up all the well-tested code which is sitting in various trees and has
been under test for a few weeks.  As soon as all that well-tested code is
merged, we go into -rc.  So we're pipelining the development of 2.6.10 code
with the stabilisation of 2.6.9.

If someone goes and develops *new* code after the release of, say, 2.6.9
then tough tittie, it's too late for 2.6.9: we don't want new code - we
want old-n-tested code.  So your typed-in-after-2.6.9 code goes into
2.6.11.

That's the theory anyway.  If it means that it takes a long time to get
code into the kernel.org tree, well, that's a cost.  That latency may be
high but the bandwidth is pretty good.

There are exceptions of course.  Completely new
drivers/filesystems/architectures can go in any old time becasue they won't
break existing setups.  Although I do tend to hold back on even these in
the (probably overoptimistic) hope that people will then concentrate on
mainline bug fixing and testing.

>  It would have caught the NFS bug that made 2.6.8.1, and probably
>  the cd burning problems... Or is Linus' patching finger just too
>  itchy?

uh, let's say that incident was "proof by counter example".
