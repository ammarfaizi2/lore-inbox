Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266611AbUHVJfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266611AbUHVJfs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 05:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266613AbUHVJfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 05:35:48 -0400
Received: from wasp.net.au ([203.190.192.17]:38318 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S266611AbUHVJfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 05:35:46 -0400
Message-ID: <41286915.9090209@wasp.net.au>
Date: Sun, 22 Aug 2004 13:36:21 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.7+ (X11/20040730)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Josan Kadett <corporate@superonline.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Entirely ignoring TCP and UDP checksum in kernel level
References: <S266609AbUHVJZE/20040822092504Z+202@vger.kernel.org>
In-Reply-To: <S266609AbUHVJZE/20040822092504Z+202@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josan Kadett wrote:
> Bad news... NAT does not work, but it should have worked. Where might be the
> mistake ? I put another machine connected next to the patched linux server,
> I sniff the traffic and see that:
> (I enabled SNAT);
> 
> Packet arrives from 192.168.0.30 (new machine to test nat)
> The packet is correctly translated and sent over the line
> With the patch, the new packet seems to arrive from correct source 77.1
> 
> *But this is where the problem begins, the system does not send the received
> packet to the address which is SNATted. I thought, the ip_input.c code would
> work in the lowest level so IPTABLES would naively use the changed source
> address...
> 
> I do not know if ever this problem will end... 
> 
> 
>>
>>Client A 192.168.0.20 -- connects to patched linux server
>>Linux 192.168.1.1 -- translates the source address 192.168.x.x to
> 
> 1.1(SNAT)

You have 192.168.0.x NAT to 192.168.1.1?
I thought you wanted to NAT to 192.168.77.1?

My understanding was you sent a packet to 192.168.77.1 and the device sent it back from 192.168.1.1

Can you send me your iptables configuration?
