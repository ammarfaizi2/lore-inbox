Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263243AbTHVQ7d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 12:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263892AbTHVQ4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 12:56:54 -0400
Received: from evrtwa1-ar2-4-33-045-084.evrtwa1.dsl-verizon.net ([4.33.45.84]:62168
	"EHLO grok.yi.org") by vger.kernel.org with ESMTP id S263784AbTHVQxw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 12:53:52 -0400
Message-ID: <3F464A96.3070408@candelatech.com>
Date: Fri, 22 Aug 2003 09:53:42 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Sodre Carlos <klist@i-a-i.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Reinjecting IP Packets
References: <1061563295.824.4.camel@iai68>	 <3F464177.1020709@candelatech.com> <1061569442.2060.2.camel@iai68>
In-Reply-To: <1061569442.2060.2.camel@iai68>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Sodre Carlos wrote:
>    My mistake... I forgot to mention that the packet will be coming from
> user-space.
> 
> Patrick

Maybe net_queue_xmit() then?

If not, you need to explain more where the pkt is coming from, and
where you want it re-injected into the stack.

Ben

> 
> On Fri, 2003-08-22 at 12:14, Ben Greear wrote:
> 
>>Patrick Sodre Carlos wrote:
>>
>>>Hi Guys,
>>>   I'm trying to figure out what is the best way to reinject IP packets
>>>into the stack. Does anyone have good/right/left ideas on this?
>>
>>Maybe netif_rx() in net/core/dev.c ?
>>
>>Ben
>>
>>
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


