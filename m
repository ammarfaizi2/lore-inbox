Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbVIMJol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbVIMJol (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 05:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbVIMJol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 05:44:41 -0400
Received: from web8501.mail.in.yahoo.com ([202.43.219.163]:52840 "HELO
	web8501.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S932472AbVIMJok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 05:44:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=nwuKksLaJlP/127SFiJN0J66ywlgYEnCAS0cCgvQjAChxPLbS+gf/iaLhgT4TXEpqrOiSye3GPqsy9SFknyuPn0xDOPmckE0OdoiXBaFlePpPU2j5ROxJOKDhRPC5Vx97Yh2Sz42ippCqwazz4TlVOy3qKex9B6NfhGqVSRMG88=  ;
Message-ID: <20050913094437.3252.qmail@web8501.mail.in.yahoo.com>
Date: Tue, 13 Sep 2005 10:44:37 +0100 (BST)
From: manomugdha biswas <manomugdhab@yahoo.co.in>
Subject: Re: how to use wait_event_interruptible_timeout
To: gaurav4lkg@gmail.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1e33f571050913023042b4c109@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
I am using the this function in the following way:

wait_queue_head_t     VNICClientWQHead;

/* Initialise the wait q head */
init_waitqueue_head(&VNICClientWQHead);

init_waitqueue_entry(&waitQ, current);
add_wait_queue(sock->sk->sk_sleep, waitQ));

/*
 my code, it reads data from socket
*/

wait_event_interruptible_timeout(VNICClientWQHead, 0,
HZ * 100000);

if no activity is to be done then this process sleeps.
When some data comes in socket i.e socket becomes
readable this process should wake up. In kernel 2.4 it
was working fine using interruptible_sleep_on_time().
But it is not working in kernel 2.6 even if data
arrives in socket! The sleeping process never wake up.
Could you please tell me what is the problem?

Regards,
Mano


--- Gaurav Dhiman <gaurav4lkg@gmail.com> wrote:

> On 9/13/05, manomugdha biswas
> <manomugdhab@yahoo.co.in> wrote:
> > Hi,
> > I was using interruptible_sleep_on_timeout() in
> kernel
> > 2.4. In kernel 2.6 I have use
> > wait_event_interruptible_timeout. But it is now
> > working!!. interruptible_sleep_on_timeout() was
> > working fine. Could anyone please help me in this
> > regard.
> 
> What problem are you facing with
> wait_event_interruptible_timeout() in 2.6
> Elaborate more on it.
> 
> -Gaurav
> 
> > Regards,
> > Mano
> > 
> > Manomugdha Biswas
> > 
> > 
> > 
> >
>
__________________________________________________________
> > Yahoo! India Matrimony: Find your partner now. Go
> to http://yahoo.shaadi.com
> > -
> > To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> 
> -- 
> - Gaurav
> my blog: http://lkdp.blogspot.com/
> --
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


Manomugdha Biswas


		
__________________________________________________________ 
Yahoo! India Matrimony: Find your partner now. Go to http://yahoo.shaadi.com
