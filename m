Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316982AbSF0WHf>; Thu, 27 Jun 2002 18:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316994AbSF0WHe>; Thu, 27 Jun 2002 18:07:34 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:13961 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S316982AbSF0WHd>;
	Thu, 27 Jun 2002 18:07:33 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200206272207.CAA16913@sex.inr.ac.ru>
Subject: Re: Fragment flooding in 2.4.x/2.5.x
To: trond.myklebust@fys.uio.no (Trond Myklebust)
Date: Fri, 28 Jun 2002 02:07:45 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200206272245.45505.trond.myklebust@fys.uio.no> from "Trond Myklebust" at Jun 27, 2 10:45:45 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Are you seriously saying that all 'right' user applications should be testing 
> the socket buffer congestion before sending a non-blocking UDP message rather 
> than just testing sendmsg() for an EWOULDBLOCK return value???

I am saying absolutely seriously that there is nothing more stupid
than preparation of skbs only to drop them and to return you EAGAIN.
_Nothing_, do you hear this?

Repeating the third time in hope you eventually read the mail to the end:

>>>Better way exists. Just use forced sock_wmalloc instead of
>>>sock_alloc_send_skb on non-blocking send of all the fragments
>>>but the first.


And, yes, until this is done, I have to be serious when saying
that any application using nonblocking sockets have to use select()
or even SIOCOUTQ. Your patch does not change anything in this.

Alexey
