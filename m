Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263050AbTJJQV2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 12:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263053AbTJJQV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 12:21:28 -0400
Received: from relay.pair.com ([209.68.1.20]:1037 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S263050AbTJJQVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 12:21:19 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3F86E516.7070004@kegel.com>
Date: Fri, 10 Oct 2003 09:57:58 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Ingo Oeser <ioe-lkml@rameria.de>
CC: "David S. Miller" <davem@redhat.com>, toby@cbcg.net, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       coreteam@netfilter.org, netfilter@lists.netfilter.org, akpm@zip.com.au,
       kuznet@ms2.inr.ac.ru, pekkas@netcore.fi, jmorris@intercode.com.au,
       yoshfuji@linux-ipv6.org, jgarzik@pobox.com
Subject: Re: [PATCH] kfree_skb() bug in 2.4.22
References: <1065617075.1514.29.camel@localhost> <200310101453.44353.ioe-lkml@rameria.de> <20031010060050.057aab50.davem@redhat.com> <200310101743.48483.ioe-lkml@rameria.de>
In-Reply-To: <200310101743.48483.ioe-lkml@rameria.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> On Friday 10 October 2003 15:00, David S. Miller wrote:
> 
>>Ingo Oeser <ioe-lkml@rameria.de> wrote:
>>
>>>Would you mind __attribute_nonnull__ for these functions, if we
>>>enable GCC 3.3 support for this[1]?
>>
>>I would say yes, but why?  All this attribute does is optimize
>>away tests for NULL which surprise surprise we don't have any
>>of in kfree_skb().
> 
> 
> And it wouldn't warn about passing NULL to these functions? That's bad...
> But maybe sparse/smatch are better for this...

Things like smatch, sparse, and checker can use the __attribute_nonnull__.
I'd say it's a good idea.  Should I submit the patch, then, since I'm
the one who like the idea?
- Dan

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

