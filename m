Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318529AbSH1BiF>; Tue, 27 Aug 2002 21:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318538AbSH1BiF>; Tue, 27 Aug 2002 21:38:05 -0400
Received: from cms1.etri.re.kr ([129.254.16.11]:51471 "EHLO cms1.etri.re.kr")
	by vger.kernel.org with ESMTP id <S318529AbSH1BiE>;
	Tue, 27 Aug 2002 21:38:04 -0400
Message-ID: <011401c24e34$382797e0$21abfe81@seong>
From: "Seong Moon" <seong@etri.re.kr>
To: <linux-kernel@vger.kernel.org>
Subject: sk_buff for frame fragmentation and reassembly
Date: Wed, 28 Aug 2002 10:42:50 +0900
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,there.

I'm writing virtual network device driver.
I want to write the function of fragmentation and reassembly of a frame
which is larger than physical MTU.

So, I've looked into the ip_fragment() and ip_defrag() and sk_buff.h .
But I couldn't understand the process of fragmentation and reassembly of
datagram.

My questions are as follows :

<fragmentation>
- ip_fragment() uses alloc_skb() and skb_copy_bit(),
Is the original sk_buff shared ? or Is another sk_buff created?
I want to know the meaning of alloc_skb() and skb_copy_bit().

<reassembly>
- ip_defrag() uses skb_shinfo(skb)->frag_list.
When I pass a reassembled frame to network layer, can I
use skb_shinfo(skb)->frag_list ?
If not, How can I pass the reassembled frame to upper layer?

<sk_buff>
what does the usage of pskb_pull() and pskb_trim()?

Thanks in advance.


