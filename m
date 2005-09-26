Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbVIZMlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbVIZMlE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 08:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbVIZMlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 08:41:04 -0400
Received: from mx02.cybersurf.com ([209.197.145.105]:60806 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S932112AbVIZMlB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 08:41:01 -0400
Subject: Re: [ANNOUNCE] Release of nf-HiPAC 0.9.0
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Emmanuel Fleury <fleury@cs.aau.dk>
Cc: Michael Bellion <mbellion@hipac.org>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <4337E601.1070208@cs.aau.dk>
References: <200509260445.46740.mbellion@hipac.org>
	 <4337DA7C.2000804@cs.aau.dk>
	 <1127735881.6215.294.camel@localhost.localdomain>
	 <4337E601.1070208@cs.aau.dk>
Content-Type: text/plain
Organization: unknown
Date: Mon, 26 Sep 2005 08:40:49 -0400
Message-Id: <1127738450.6215.331.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-26-09 at 14:13 +0200, Emmanuel Fleury wrote:

> That is right, the add/remove/modifying policies was still an issue when
> we stopped working on this. But, I think we can solve this problem by
> working on an incremental compiler. I have to admit that this require a
> proof of concept. This issue is quite critical on our method.
> 

I think if you solve the lookup issue (which you seem to have) and this
you will be in good shape. 

> > Several comments:
> > - Am i mistaken that your source of data is from somewhere in the
> > backbone? Would it be fair to say that something in the edge would be
> > more appropriate?
> 
> The source of the data has been recorded from a backbone but all the
> clients in the experimental setting are replaying part of it and sending
> it to the gigabit switch.
> 

Ok, makes sense.


> > - Is tcpreplay the right tool? What does it give you that you cant use
> > a better blaster like pktgen?
> 
> The idea was to replay a realistic traffic. So we used a slightly
> modified version of the tcpreplay (I don't remember what modifications
> have been done, my co-author did it). I should definitely take a look at
> pktgen.
> 

Both are useful tests. Benchmarking typically doesnt factor in realistic
- the rule of thumb being if you can win a benchmark you can do better.
The exception is when you make complex changes to win a benchmark; there
has to be a balance.

> > If you are going to run these tests in stateless firewalling as you
> > did, please consider using tc filter as well.
> 
> The spirit was to test a totally new idea, the plan was not really to
> get integrated (yet) into any tool, so we did it like this. We might
> have been wrong.

I think the methodology was fine enough for what you were doing then;
academic time constraints apply and you can be forgiven for that ;->
Now that you have gone beyond academia and have some company behind your
work, it is only fair to compare against tc filter because it is in the
kernel and being used by some people. 
I am willing to help consult for the tc filter side if you need help.

cheers,
jamal

