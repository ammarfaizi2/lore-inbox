Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312308AbSCYF5j>; Mon, 25 Mar 2002 00:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312309AbSCYF52>; Mon, 25 Mar 2002 00:57:28 -0500
Received: from pizda.ninka.net ([216.101.162.242]:42380 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312308AbSCYF5N>;
	Mon, 25 Mar 2002 00:57:13 -0500
Date: Sun, 24 Mar 2002 21:52:39 -0800 (PST)
Message-Id: <20020324.215239.61846157.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: akpm@zip.com.au, marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [patch] smaller kernels
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020325165605.7d9c1d6e.rusty@rustcorp.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Mon, 25 Mar 2002 16:56:05 +1100

   And I'm not sure DaveM'll appreciate this:
   
   >  static inline char *__skb_pull(struct sk_buff *skb, unsigned int len)
   >  {
   >  	skb->len-=len;
   > -	if (skb->len < skb->data_len)
   > -		BUG();
   >  	return 	skb->data+=len;
   >  }

Rusty's right, I definitely won't take this, it catches problems
%99 of the time in the place that causes it.
