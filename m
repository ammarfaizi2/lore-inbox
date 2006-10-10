Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965080AbWJJHpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080AbWJJHpi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 03:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965081AbWJJHpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 03:45:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27362 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965080AbWJJHpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 03:45:38 -0400
Date: Tue, 10 Oct 2006 00:45:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-mm@kvack.org
Subject: Re: 2.6.19-rc1-mm1
Message-Id: <20061010004526.c7088e79.akpm@osdl.org>
In-Reply-To: <1160464800.3000.264.camel@laptopd505.fenrus.org>
References: <20061010000928.9d2d519a.akpm@osdl.org>
	<1160464800.3000.264.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 09:20:00 +0200
Arjan van de Ven <arjan@infradead.org> wrote:

> On Tue, 2006-10-10 at 00:09 -0700, Andrew Morton wrote:
> > +htlb-forget-rss-with-pt-sharing.patch

Which I didn't write.  cc's added.

> if it's ok to ignore RSS,

We'd prefer not to.  But what's the alternative?

> can we consider the shared pagetables for
> normal pages patch?

Has been repeatedly considered, but Hugh keeps finding bugs in it.

> It saves quite a bit of memory on even desktop
> workloads as well as avoiding several (soft) pagefaults.
> 
> So.. what does RSS actually mean? Can we ignore it somewhat for
> shared-readonly mappings ? 

We'd prefer to go the other way, and implement RLIMIT_RSS wouldn't we?
