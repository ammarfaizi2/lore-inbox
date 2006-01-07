Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030492AbWAGHyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030492AbWAGHyB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 02:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030484AbWAGHyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 02:54:01 -0500
Received: from mf00.sitadelle.com ([212.94.174.67]:20541 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1030345AbWAGHyB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 02:54:01 -0500
Message-ID: <43BF7390.6050005@cosmosbay.com>
Date: Sat, 07 Jan 2006 08:53:52 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
Cc: ak@suse.de, paulmck@us.ibm.com, alan@lxorguk.ukuu.org.uk,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       manfred@colorfullife.com, netdev@vger.kernel.org
Subject: Re: [PATCH, RFC] RCU : OOM avoidance and lower latency
References: <20060106.161721.124249301.davem@davemloft.net>	<200601070209.02157.ak@suse.de>	<43BF6F0B.4060108@cosmosbay.com> <20060106.234440.53993868.davem@davemloft.net>
In-Reply-To: <20060106.234440.53993868.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller a écrit :
> From: Eric Dumazet <dada1@cosmosbay.com>
> Date: Sat, 07 Jan 2006 08:34:35 +0100
> 
>> I agree, I do use a hashed spinlock array on my local tree for TCP,
>> mainly to reduce the hash table size by a 2 factor.
> 
> So what do you think about going to a single spinlock for the
> routing cache?

I have no problem with this, since the biggest server I have is 4 way, but are 
you sure big machines wont suffer from this single spinlock ?

Also I dont understand what you want to do after this single spinlock patch.
How is it supposed to help the 'ip route flush cache' problem ?

In my case, I have about 600.000 dst-entries :

# grep ip_dst /proc/slabinfo
ip_dst_cache      616250 622440    320   12    1 : tunables   54   27    8 : 
slabdata  51870  51870      0


Eric
