Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWFMWJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWFMWJU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 18:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWFMWJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 18:09:20 -0400
Received: from relay02.pair.com ([209.68.5.16]:34316 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S932365AbWFMWJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 18:09:18 -0400
X-pair-Authenticated: 71.197.50.189
Date: Tue, 13 Jun 2006 17:09:16 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: John Heffner <jheffner@psc.edu>
cc: Linus Torvalds <torvalds@osdl.org>, Mark Lord <lkml@rtr.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       davem@davemloft.net
Subject: Re: 2.6.17: networking bug??
In-Reply-To: <448F03B3.5040501@psc.edu>
Message-ID: <Pine.LNX.4.64.0606131706040.4856@turbotaz.ourhouse>
References: <448EC6F3.3060002@rtr.ca> <448ECB09.3010308@rtr.ca>
 <448ED2FC.2040704@rtr.ca> <448ED9B3.8050506@rtr.ca> <448EEE9D.10105@rtr.ca>
 <448EF45B.2080601@rtr.ca> <448EF85E.50405@psc.edu> <Pine.LNX.4.64.0606131048550.5498@g5.osdl.org>
 <448F03B3.5040501@psc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2006, John Heffner wrote:

>
> In the last couple years, we've added code that can automatically size the 
> buffers as appropriate for each connection, but it's completely crippled 
> unless you use a window scale.  Personally, I think it's not a question of 
> *whether* we have to start using a window scale by default, but *when*.  I 
> don't know that we want to let a small number of unambiguously broken 
> middleboxes kill our forward progress.

Another example - Same thing happened with ECN. I recall setting up a mail 
server at the time and noticing that I had to disable ECN because some 
dumbass PIX routers out there were dropping packets with a _reserved bit_ 
set! Sure, there was a firmware upgrade, but the dingbat admins I tried to 
alert didn't seem (at the time) too interested in fixing their problem.

Does anyone have any interesting statistics on how often end-users are 
likely to run into this crap? It really is a shame when you have to suck just 
because someone else does.

>
> Thanks,
>  -John

Cheers,
Chase
