Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbVHDOjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbVHDOjD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 10:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVHDOjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 10:39:01 -0400
Received: from tim.rpsys.net ([194.106.48.114]:15775 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262565AbVHDOhu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 10:37:50 -0400
Subject: Re: 2.6.13-rc3-mm3
From: Richard Purdie <rpurdie@rpsys.net>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
In-Reply-To: <Pine.LNX.4.62.0508040703300.3277@graphe.net>
References: <20050728025840.0596b9cb.akpm@osdl.org>
	 <1122860603.7626.32.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508010908530.3546@graphe.net>
	 <1122926537.7648.105.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011335090.7011@graphe.net>
	 <1122930474.7648.119.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011414480.7574@graphe.net>
	 <1122931637.7648.125.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011438010.7888@graphe.net>
	 <1122933133.7648.141.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011517300.8498@graphe.net>
	 <1122937261.7648.151.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508031716001.24733@graphe.net>
	 <1123154825.8987.33.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508040703300.3277@graphe.net>
Content-Type: text/plain
Date: Thu, 04 Aug 2005 15:37:32 +0100
Message-Id: <1123166252.8987.50.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-04 at 07:04 -0700, Christoph Lameter wrote:
> On Thu, 4 Aug 2005, Richard Purdie wrote:
> 
> > On Wed, 2005-08-03 at 17:19 -0700, Christoph Lameter wrote:
> > > Could you try the following patch? I think the problem was that higher 
> > > addressses were not mappable via the page fault handler. This patch 
> > > inserts the pmd entry into the pgd as necessary if the pud level is 
> > > folded.
> > 
> > I tried this patch against 2.6.13-rc4-mm1 and there was no change - X
> > still hung in memcpy as before and the cmpxchg_fail_flag_update just
> > increases...
> 
> Is there some way you can give us more information about the problem? 
> Something that would allow us to determine where the thing is looping?

I'm at a disadvantage here as the linux mm system is one area I've
avoided getting too deeply involved with so far. My knowledge is
therefore limited and I won't know what correct or incorrect behaviour
would look like.

We know the the failure case can be identified by the
cmpxchg_fail_flag_update condition being met. Can you provide me with a
patch to dump useful debugging information when that occurs?

Richard

