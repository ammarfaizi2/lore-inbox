Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276302AbRJCOLn>; Wed, 3 Oct 2001 10:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276314AbRJCOLd>; Wed, 3 Oct 2001 10:11:33 -0400
Received: from web11903.mail.yahoo.com ([216.136.172.187]:34053 "HELO
	web11903.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S276302AbRJCOLQ>; Wed, 3 Oct 2001 10:11:16 -0400
Message-ID: <20011003141144.98896.qmail@web11903.mail.yahoo.com>
Date: Wed, 3 Oct 2001 07:11:44 -0700 (PDT)
From: Kirill Ratkin <kratkin@yahoo.com>
Subject: Netfilter problem
To: linux-kernel@vger.kernel.org
In-Reply-To: <m1k7yc3ky5.fsf@frodo.biederman.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I've a strange error when I try to check protocol type
in netfilter hook function. 

I see this message:
kping.c: In function `knet_hook':
kping.c:116: dereferencing pointer to incomplete type
make: *** [kping.o] Error 1

This is part of my code:
static
unsigned int knet_hook(unsigned int hooknum,
                      struct sk_buff** p_skb,
                      const struct net_device* p_in,
                      const struct net_device* p_out,
                      int (*okfn)(struct sk_buff* ))
{
  ...
  if((*p_skb)->nh.iph->protocol==
	(unsigned char)IPPROTO_ICMP)
  {
    printk("<1>ICMP Packet killed\n");
    return NF_DROP;
  }
  ...
}

It had compiled on 2.4.1 version.

I don't understand why ... .


__________________________________________________
Do You Yahoo!?
Listen to your Yahoo! Mail messages from any phone.
http://phone.yahoo.com
