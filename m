Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266545AbUF0EKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266545AbUF0EKQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 00:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266548AbUF0EKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 00:10:16 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:51651 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S266545AbUF0EKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 00:10:10 -0400
Message-ID: <40DD06C1.9080908@conectiva.com.br>
Date: Sat, 26 Jun 2004 02:16:49 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Reply-To: acme@conectiva.com.br
Organization: Conectiva S.A.
User-Agent: Mozilla Thunderbird 0.6 (X11/20040506)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Collins <bcollins@debian.org>
Cc: Sushant Sharma <sushant@cs.unm.edu>, linux-kernel@vger.kernel.org
Subject: Re: when is alloc_skb called
References: <40C4DE2A.1070008@cs.unm.edu> <20040607225744.GA26253@phunnypharm.org>
In-Reply-To: <20040607225744.GA26253@phunnypharm.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter, spamicity=0.059953, version=0.16.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins wrote:
> On Mon, Jun 07, 2004 at 03:29:14PM -0600, Sushant Sharma wrote:
> 
>>Hi All
>>
>>I want to know which are the evnets
>>that can lead to the calling of alloc_skb
>>function which is used to allocate sk_buff.
>>Arrival and departure of packet are 2 events
>>which I know. Are there any other events/cases
>>which can lead to alloc_skb(...) function call in kernel.
> 
> 
> Some non-network related drivers use skb's for non-network related
> things (ieee1394 is one such abuser).
> 

And some network protocol stacks use it to report events, like
connection requests, etc see the x25 code, for instance 
(x25_establish_link, x25_terminate_link), sometimes allocating
1 byte, sometimes using the skb->cb scratch area.

- Arnaldo
