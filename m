Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVDOE7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVDOE7R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 00:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbVDOE7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 00:59:17 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:50878 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261433AbVDOE7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 00:59:14 -0400
Subject: Re: 2.6.12-rc2: >100% memory usage
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: michael@ucc.gu.uwa.edu.au, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050415044806.GA12519@wibble>
References: <20050415044806.GA12519@wibble>
Content-Type: text/plain
Date: Fri, 15 Apr 2005 14:59:05 +1000
Message-Id: <1113541145.6517.22.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-15 at 12:48 +0800, Michael Deegan wrote:
> Hi folks,
> 
> I noticed something unusual on my home desktop machine (K6II, 448M RAM, runs
> KDE, samba, nfsd. 2.6.12-rc2 on Debian sarge). The machine seems to feel
> slightly sluggish; it seems to swap a fair bit more than it did under
> 2.6.11, but at the same time it's not actually using more swap that it used
> to. The large numbers are slowly growing larger too. The biggest spamd was
> only 156% of memory yesterday. Normally it's only my xserver (and
> occasionally konqueror) that manages to grab more than 10% of memory...

FWIW, me too :P

I think there is a memory leak in recent 2.6.12 kernels.
At least on my desktop there is (although it has some of
my own patches and I've been too lazy to do more work on
it so I haven't reported it).

It seems to be leaking `size-4096` slabs somewhere.

-- 
SUSE Labs, Novell Inc.


