Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136493AbREBBwd>; Tue, 1 May 2001 21:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136574AbREBBwY>; Tue, 1 May 2001 21:52:24 -0400
Received: from pizda.ninka.net ([216.101.162.242]:15745 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S136493AbREBBwT>;
	Tue, 1 May 2001 21:52:19 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15087.26704.689029.360584@pizda.ninka.net>
Date: Tue, 1 May 2001 18:52:16 -0700 (PDT)
To: tpepper@vato.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.4 breaks VMware
In-Reply-To: <20010501184240.A28442@cb.vato.org>
In-Reply-To: <20010501184240.A28442@cb.vato.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


tpepper@vato.org writes:
 > --- skbuff.h.orig       Tue May  1 18:41:50 2001
 > +++ skbuff.h    Tue May  1 18:41:55 2001
 > @@ -244,6 +244,11 @@
 >  
 >  /* Internal */
 >  #define skb_shinfo(SKB)                ((struct skb_shared_info *)((SKB)->end))
 > +/* for vmware */
 > +static inline atomic_t *skb_datarefp(struct sk_buff *skb)
 > +{
 > +	return (atomic_t *)(skb->end);
 > +}

No, the equivalent is &skb_shinfo(skb)->dataref

Later,
David S. Miller
davem@redhat.com
