Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263173AbUFBP2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbUFBP2f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 11:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263182AbUFBP2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 11:28:35 -0400
Received: from CS2075.cs.fsu.edu ([128.186.122.75]:45216 "EHLO mail.cs.fsu.edu")
	by vger.kernel.org with ESMTP id S263173AbUFBP2a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 11:28:30 -0400
Message-ID: <1086190109.a0ea5ca71914e@system.cs.fsu.edu>
Date: Wed,  2 Jun 2004 11:28:29 -0400
From: khandelw@cs.fsu.edu
To: jyotiraditya@softhome.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Select/Poll
References: <courier.40BD66BD.00006D7D@softhome.net>
In-Reply-To: <courier.40BD66BD.00006D7D@softhome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 12.151.80.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
   Can you give more details - Like which machine which vendor etc.,
On a sony vaio pcg frv31 laptop/ redhat 9.0/ after firing some 36,000+ request
my select multiplexed server used to fail. With select I believe you not get
any packet loss...

- Amit

PS. If you can post the code that will be great...


Quoting jyotiraditya@softhome.net:

> Hello All,
>
> In one of the threads named: "Linux's implementation of poll() not
> scalable?'
> Linus has stated the following:
> **************
> Neither poll() nor select() have this problem: they don't get more
> expensive as you have more and more events - their expense is the number
> of file descriptors, not the number of events per se. In fact, both poll()
> and select() tend to perform _better_ when you have pending events, as
> they are both amenable to optimizations when there is no need for waiting,
> and scanning the arrays can use early-out semantics.
> **************
>
> Please help me understand the above.. I'm using select in a server to read
> on multiple FDs and the clients are dumping messages (of fixed size) in a
> loop on these FDs and the server maintainig those FDs is not able to get all
> the messages.. Some of the last messages sent by each client are lost.
> If the number of clients and hence the number of FDs (in the server) is
> increased the loss of data is proportional.
> eg: 5 clients send messages (100 each) to 1 server and server receives
>    96 messages from each client.
>    10 clients send messages (100 by each) to 1 server and server again
>    receives 96 from each client.
>
> If a small sleep in introduced between sending messages the loss of data
> decreases.
> Also please explain the algorithm select uses to read messages on FDs and
> how does it perform better when number of FDs increases.
>
> Thanks and Regards,
> Jyotiraditya
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


