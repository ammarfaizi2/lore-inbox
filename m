Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265990AbSKOODa>; Fri, 15 Nov 2002 09:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266153AbSKOODa>; Fri, 15 Nov 2002 09:03:30 -0500
Received: from home.deeptown.org ([205.150.192.50]:18562 "HELO deeptown.org")
	by vger.kernel.org with SMTP id <S265990AbSKOOD3> convert rfc822-to-8bit;
	Fri, 15 Nov 2002 09:03:29 -0500
Message-ID: <007e01c28cb0$bde52900$9c094d8e@wcom.ca>
From: "Serge Kuznetsov" <sk@deeptown.org>
To: "Arnaldo Carvalho de Melo" <acme@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>
References: <015301c28c00$f6287390$34c096cd@toybox> <20021114180022.GF14579@conectiva.com.br>
Subject: Re: [NET] Possible bug in netif_receive_skb
Date: Fri, 15 Nov 2002 09:10:24 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Em Thu, Nov 14, 2002 at 12:12:07PM -0500, Serge Kuznetsov escreveu:
> 
> > PS: BTW, how to check if skb has been freed ? I didn't found any function for
> > it. Is it possible to add the flag, like skb->freed ?
> 
> Enable slab poisoning.
> 

  Can I check if skb->users is not zero, it mean function hasn't been freed? Or just forget about it?

  But what's happen if someone's ->func will return NET_RX_DROP, but not called the kfree_skb ? Is it not good to check for it?
Why should we trust for that function, may be someone forget to do it? 

PS: Sorry, if my this questions hurts anyone, but for last almost 10 years, I'm using the Linux, I like it so much, and I want improve it and make it better, as much as possible.


All the Best!
Serge.
