Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262478AbUKLA4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbUKLA4E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 19:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbUKLAvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 19:51:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:1006 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262468AbUKLAuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 19:50:04 -0500
Date: Thu, 11 Nov 2004 16:49:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Christian Kujau <evil@g-house.de>
cc: Matt Domsch <Matt_Domsch@dell.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pekka Enberg <penberg@gmail.com>, Greg KH <greg@kroah.com>
Subject: Re: Oops in 2.6.10-rc1 (almost solved)
In-Reply-To: <41940384.1000409@g-house.de>
Message-ID: <Pine.LNX.4.58.0411111645110.2301@ppc970.osdl.org>
References: <Pine.LNX.4.58.0411080951390.2301@ppc970.osdl.org>
 <418FDE1F.7060804@g-house.de> <419005F2.8080800@g-house.de>
 <41901DF0.8040302@g-house.de> <84144f02041108234050d0f56d@mail.gmail.com>
 <4190B910.7000407@g-house.de> <20041109164238.M12639@g-house.de>
 <Pine.LNX.4.58.0411091026520.2301@ppc970.osdl.org> <4191530D.8020406@g-house.de>
 <20041109234053.GA4546@lists.us.dell.com> <20041111224331.GA31340@lists.us.dell.com>
 <41940384.1000409@g-house.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Nov 2004, Christian Kujau wrote:
> 
> nevermind then. as nobody else seem to be bothered by this i am happy with
> the workarund (CONFIG_EDD=n) and since the lkml-archives exist we could
> get back to it when it's bothering more people (n>1)

The problem with that approach is that very few people are willing to 
spend the time and effort to really try to figure out where the problem 
triggers for them. Thanks again for testing lots of kernels, and different 
configurations.

Basically, if it's a problem that only happens for a smallish percentage
of people, and an even smaller percentage of those is willing to dig down
and find it, it's not a problem we can afford to ignore. Ignoring it just
means that there will be "a few" error reports that we will either waste
time on, or (even worse) we'll dismiss as "known problems" and then
possibly miss _another_ bug.

This is why I take random unexplained (but pinpointed) problems so 
seriously. If it wasn't as apparently random, we could file it under 
"known problem" and decide to try to fix it later. As it is, it's filed 
under "known cause", but since we don't know _why_, it might cause totally 
different problems on another machine, and that just makes it too painful 
for words. 

So the changeset is reverted for now in the current -bk tree, and I'll 
make a -rc2 this weekend and hope that we can stabilize for 2.6.10.

		Linus
