Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262760AbVEGXjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbVEGXjw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 19:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbVEGXjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 19:39:52 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:30597 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262760AbVEGXju convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 19:39:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z20BAyl8EJUcqPIwEtRUTVDUa80Gfy0524/fhWY3MZg/xqaxv6/r2AZ+jYJZ2613dewtEp79AQ2SoTcsixTD9k1dtOC0yQl4Hy0Kw6gk9hcg4T3KzeoDfHDdZBvqj2MuMSJom5hdQ8PvMK7wFLKPJGGu3wesaJ4oh18fG/WBAUM=
Message-ID: <7d04ec5605050716393c5a71ca@mail.gmail.com>
Date: Sat, 7 May 2005 16:39:49 -0700
From: rajat swarup <rajats@gmail.com>
Reply-To: rajat swarup <rajats@gmail.com>
To: "J. Scott Kasten" <jscottkasten@yahoo.com>
Subject: Re: sending ICMP messages in kernel module
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <427D3E7E.2020405@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7d04ec5605050622006f3ad56c@mail.gmail.com>
	 <427D3E7E.2020405@yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/05, J. Scott Kasten <jscottkasten@yahoo.com> wrote:
> 
> rajat swarup wrote:
> 
> >I have placed a netfilter hook in which I grab the packets in the
> >pre-routing stage.
> >I need to send ICMP messages in response to certain messages in this hook.
> >I looked at alloc_skb(), skb_reserve() and skb_put() functions but it
> >is still not clear to me as to how to construct the packets using
> >these methods.
> >Since I am getting the packets in the Pre-routing stage should I
> >explicitly construct the MAC header, IP header & data & ICMP message?
> >Also, I'll need to calculate the checksum to be transmitted in the
> >ICMP packet...which method could I use to do that?
> >
> >
> 
> I had a similar problem once.  In the icmp.c file, look at how the ping
> echo reply works.  That is as close to a tutorial as you will find in
> the code.  I think you might find it strait forward from there.
>

Hi Scott,
I am trying to send ICMP messages but not in reply to anything else.
We have to generate ICMP messages from scratch.
So we do not have access to an existing sk_buff structure that has all
the parameters already set.
icmp_echo(struct skbuff*) assumes that you already have the sk_buff
structure and you are just assigning a few more fields.
Do you have an idea about how can we create ICMP messages from scratch?

Thanks for the help!

-Rajat.
http://rajatswarup.blogspot.com/
