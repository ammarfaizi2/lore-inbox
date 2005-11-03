Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030492AbVKCVW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030492AbVKCVW3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 16:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030493AbVKCVW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 16:22:29 -0500
Received: from gate.crashing.org ([63.228.1.57]:16833 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030492AbVKCVW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 16:22:28 -0500
Subject: Re: Nick's core remove PageReserved broke vmware...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gleb Natapov <gleb@minantech.com>
Cc: Hugh Dickins <hugh@veritas.com>, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20051103135542.GD22185@minantech.com>
References: <4368097A.1080601@yahoo.com.au> <4368139A.30701@vc.cvut.cz>
	 <Pine.LNX.4.61.0511021208070.7300@goblin.wat.veritas.com>
	 <1130965454.20136.50.camel@gaston>
	 <Pine.LNX.4.61.0511022112530.18174@goblin.wat.veritas.com>
	 <1130967936.20136.65.camel@gaston>
	 <Pine.LNX.4.61.0511022157130.18559@goblin.wat.veritas.com>
	 <1130970131.20136.73.camel@gaston> <20051103080341.GB22185@minantech.com>
	 <Pine.LNX.4.61.0511031327360.22826@goblin.wat.veritas.com>
	 <20051103135542.GD22185@minantech.com>
Content-Type: text/plain
Date: Fri, 04 Nov 2005 08:21:53 +1100
Message-Id: <1131052914.4680.80.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-03 at 15:55 +0200, Gleb Natapov wrote:
> On Thu, Nov 03, 2005 at 01:32:15PM +0000, Hugh Dickins wrote:
> > On Thu, 3 Nov 2005, Gleb Natapov wrote:
> > > On Thu, Nov 03, 2005 at 09:22:10AM +1100, Benjamin Herrenschmidt wrote:
> > > > Also, what do you suggest as a good threshold to use on the max amount
> > > > of memory I can let the X server "pin" that way ? I was thinking it as
> > > > equivalent to mlock, thus I could maybe hijack mm->locked_vm & use
> > > > RLIMIT_MEMLOCK or is that too gross ?
> > > > 
> > > This is what infiniband does, so it should be good for you too.
> > 
> > Yes, I noticed that code a couple of days ago, I think you're setting a
> > good example there, for long-term or large-area uses of get_user_pages():
> > Ben, take a look at drivers/infiniband/core/uverbs_mem.c

Ok, thanks guys, will have a look.

Ben.

