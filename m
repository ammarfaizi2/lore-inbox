Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbWHYRqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWHYRqk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 13:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWHYRqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 13:46:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62169 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750847AbWHYRqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 13:46:39 -0400
Date: Fri, 25 Aug 2006 10:46:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Josh Triplett <josht@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Pass sparse the lock expression given to lock
 annotations
Message-Id: <20060825104632.df1fd26b.akpm@osdl.org>
In-Reply-To: <1156521234.3420.19.camel@josh-work.beaverton.ibm.com>
References: <1156466936.3418.58.camel@josh-work.beaverton.ibm.com>
	<20060824210531.6264f285.akpm@osdl.org>
	<1156521234.3420.19.camel@josh-work.beaverton.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2006 08:53:53 -0700
Josh Triplett <josht@us.ibm.com> wrote:

> On Thu, 2006-08-24 at 21:05 -0700, Andrew Morton wrote:
> > On Thu, 24 Aug 2006 17:48:56 -0700
> > Josh Triplett <josht@us.ibm.com> wrote:
> > 
> > > The lock annotation macros __acquires, __releases, __acquire, and __release
> > > all currently throw the lock expression passed as an argument.  Now that
> > > sparse can parse __context__ and __attribute__((context)) with a context
> > > expression, pass the lock expression down to sparse as the context expression.
> > 
> > What is the dependency relationship between your kernel changes and your
> > proposed change to sparse?
> 
> Sparse with my multi-context patch will continue to parse versions of
> the kernel without this kernel patch, since I made the context
> expression optional in sparse.  Versions of sparse without my
> multi-context patch will not parse kernels with this kernel patch (since
> previous versions of sparse will not support the extra argument).

OK.  Is this patch the only one which will break current sparse versions? 
If not, please identify the others.

I'll keep the non-back-compatible kernel patches in -mm until you've
informed me that a suitable version of sparse has been released.  Then we
can include that sparse version number in the kernel changelogs so things
are nice and organised.

