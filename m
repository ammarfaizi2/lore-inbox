Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWFMRvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWFMRvH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 13:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbWFMRvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 13:51:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11699 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750792AbWFMRvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 13:51:05 -0400
Date: Tue, 13 Jun 2006 10:50:51 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: John Heffner <jheffner@psc.edu>
cc: Mark Lord <lkml@rtr.ca>, Linux Kernel <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, davem@davemloft.net
Subject: Re: 2.6.17: networking bug??
In-Reply-To: <448EF85E.50405@psc.edu>
Message-ID: <Pine.LNX.4.64.0606131048550.5498@g5.osdl.org>
References: <448EC6F3.3060002@rtr.ca> <448ECB09.3010308@rtr.ca>
 <448ED2FC.2040704@rtr.ca> <448ED9B3.8050506@rtr.ca> <448EEE9D.10105@rtr.ca>
 <448EF45B.2080601@rtr.ca> <448EF85E.50405@psc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Jun 2006, John Heffner wrote:
> 
> The best thing you can do is try to find this broken box and inform its owner
> that it needs to be fixed.  (If you can find out what it is, I'd be interested
> to know.)  In the meantime, disabling window scaling will work around the
> problem for you.

Well, arguably, we shouldn't necessarily have defaults that use window 
scaling, or we should have ways to recognize automatically when it 
doesn't work (which may not be possible).

It's not like there aren't broken boxes out there, and it might be better 
to make the default buffer sizes just be low enough that window scaling 
simply isn't an issue.

I suspect that the people who really want/need window scaling know about 
it, and could be assumed to know enough to raise their limits, no?

		Linus
