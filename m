Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271343AbTGWWAX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 18:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271345AbTGWWAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 18:00:22 -0400
Received: from diomedes.noc.ntua.gr ([147.102.222.220]:62283 "EHLO
	diomedes.noc.ntua.gr") by vger.kernel.org with ESMTP
	id S271343AbTGWWAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 18:00:16 -0400
Message-ID: <3F1F0995.4020300@gmx.net>
Date: Thu, 24 Jul 2003 01:17:57 +0300
From: jimis@gmx.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Feature proposal (scheduling related)
References: <3F1E6A25.5030308@gmx.net> <200307231417.h6NEHoqj010244@turing-police.cc.vt.edu>
In-Reply-To: <200307231417.h6NEHoqj010244@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Wed, 23 Jul 2003 13:57:41 +0300, jimis@gmx.net  said:
> 
>>1)I 'm connected to the internet via dial-up, therefore I only have 40 kbits of 
>>bandwidth available. What I want to do is listen to icecast radio via xmms (at
>>22 kbits), download the kernel sources with wget, and browse the web at the same
>>time. Currently I think that this is *impossible* (correct me if I'm wrong) as
>>the radio will be full of pauses and the browsing experience painfully slow.
> 
> 
> Basically, you're stuck.  The biggest part of the problem is that although you
> can certainly control the outbound packets, you have no real control over when
> inbound packets arrive at the other end of your dial-up.  One person suggested

But the incoming packets are those that I request to be sent to me (most times). 
When I know the packet size I will accept I may not request all packets now, but 
a bit later, to leave bandwidth for other requested packets of higher priority.

> using QoS to help things along - but that needs to be implemented at the OTHER
> end of the dial-up - which means unless your provider does QoS on the terminal
> server, you're basically stuck.  Packets will probably just get queued up in
> order of arrival.

This is what I don't like, but I bet there must be a way to slow down the other 
end, even if it has not QoS.

What might help, and needs only be implemented on my side of the connection, is 
requesting the packets of higher priorities first. And if I know my total 
bandwidth, perhaps I can request as many packets needed to fill it (and not 
flood it like it happens now).

Thank you all for your attention,
Dimitris



