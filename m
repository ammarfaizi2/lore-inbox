Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261474AbSIZAdJ>; Wed, 25 Sep 2002 20:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261497AbSIZAdI>; Wed, 25 Sep 2002 20:33:08 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:1196 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261474AbSIZAdG> convert rfc822-to-8bit; Wed, 25 Sep 2002 20:33:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: nf@hipac.org
To: "David S. Miller" <davem@redhat.com>
Subject: Re: [ANNOUNCE] NF-HIPAC: High Performance Packet Classification for Netfilter
Date: Thu, 26 Sep 2002 02:38:06 +0200
User-Agent: KMail/1.4.3
References: <200209260041.56374.nf@hipac.org> <20020925.155246.41632313.davem@redhat.com>
In-Reply-To: <20020925.155246.41632313.davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209260238.06400.nf@hipac.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> You missed the real trick, extending the routing tables to
> do packet filter rule lookup.  That's where the real
> performance gains can be found, ...

Yes, that's certainly true. But we have to take step by step.
We started our project in August 2001 and up to now almost all our work went 
into developing and optimizing the algorithm and not into an optimal 
integration into the linux kernel. We chose the netfilter integration as a 
first step, because it was easy and fast to do. It doesn't break anything in 
the kernel, no kernel patch is needed, it can be used together with other 
existing netfilter/iptables modules and switching from the iptables filter 
module to nf-hipac is really easy.

We have now basically finished the work on the algorithm itself. We can now 
concentrate on porting the algorithm to other fields and on a better 
integration into the kernel. We designed the algorithm code in a way that 
allows to port it to other fields than packetfiltering without much work.  
We were aware from the beginning that combining several fields (e.g. routing 
and filtering) is THE way to go and it is no problem to support this with our 
algorithm.
Our algorithm is already fast with a small number of rules, but what makes it 
really interesting is, that it is possible to use huge rulesets/routing 
tables/qos ... without much slowing down performance. In practical use people 
won't notice much of a difference between using 25 or 25000 rules.  

The nf-hipac team
	Michael Bellion, Thomas Heinz

