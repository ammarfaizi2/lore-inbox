Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312525AbSCYTwa>; Mon, 25 Mar 2002 14:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312524AbSCYTwU>; Mon, 25 Mar 2002 14:52:20 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:57102 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S312525AbSCYTwC>; Mon, 25 Mar 2002 14:52:02 -0500
Date: Mon, 25 Mar 2002 14:49:24 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "David S. Miller" <davem@redhat.com>
cc: rusty@rustcorp.com.au,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] smaller kernels
In-Reply-To: <20020324.215239.61846157.davem@redhat.com>
Message-ID: <Pine.LNX.3.96.1020325144812.4219D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Mar 2002, David S. Miller wrote:

>    From: Rusty Russell <rusty@rustcorp.com.au>
>    Date: Mon, 25 Mar 2002 16:56:05 +1100
> 
>    And I'm not sure DaveM'll appreciate this:
>    
>    >  static inline char *__skb_pull(struct sk_buff *skb, unsigned int len)
>    >  {
>    >  	skb->len-=len;
>    > -	if (skb->len < skb->data_len)
>    > -		BUG();
>    >  	return 	skb->data+=len;
>    >  }
> 
> Rusty's right, I definitely won't take this, it catches problems
> %99 of the time in the place that causes it.

  But, it makes the kernel smaller. And faster! ;-)

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

