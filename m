Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267254AbUJFExP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267254AbUJFExP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 00:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267259AbUJFExP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 00:53:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:50647 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267254AbUJFExN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 00:53:13 -0400
Date: Tue, 5 Oct 2004 21:51:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: kenneth.w.chen@intel.com, mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Default cache_hot_time value back to 10ms
Message-Id: <20041005215116.3b0bd028.akpm@osdl.org>
In-Reply-To: <416374D5.50200@yahoo.com.au>
References: <200410060042.i960gn631637@unix-os.sc.intel.com>
	<20041005205511.7746625f.akpm@osdl.org>
	<416374D5.50200@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
>  Andrew Morton wrote:
>  > "Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>  > 
>  >>This value was default to 10ms before domain scheduler, why does domain
>  >> scheduler need to change it to 2.5ms? And on what bases does that decision
>  >> take place?  We are proposing change that number back to 10ms.
>  > 
>  > 
>  > It sounds like this needs to be runtime tunable?
>  > 
> 
>  I'd say it is probably too low level to be a useful tunable (although
>  for testing I guess so... but then you could have *lots* of parameters
>  tunable).

This tunable caused an 11% performance difference in (I assume) TPCx. 
That's a big deal, and people will want to diddle it.

If one number works optimally for all machines and workloads then fine.

But yes, avoiding a tunable would be nice, but we need a tunable to work
out whether we can avoid making it tunable ;)

Not that I'm soliciting patches or anything.  I'll duck this one for now.
