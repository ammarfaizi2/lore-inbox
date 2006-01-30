Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWA3KW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWA3KW2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 05:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWA3KW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 05:22:27 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:11146 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1751269AbWA3KW1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 05:22:27 -0500
Message-ID: <43DDE8D1.6060503@cosmosbay.com>
Date: Mon, 30 Jan 2006 11:22:09 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: bcrl@kvack.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Questions about alloc_large_system_hash() and TLB entries
References: <20060129200504.GD28400@kvack.org>	<43DD2C15.1090800@cosmosbay.com>	<43DDD66C.4060201@cosmosbay.com> <20060130.012259.78361400.davem@davemloft.net>
In-Reply-To: <20060130.012259.78361400.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Mon, 30 Jan 2006 11:22:09 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller a écrit :
> From: Eric Dumazet <dada1@cosmosbay.com>
> Date: Mon, 30 Jan 2006 10:03:40 +0100
> 
>> What would be the needed changes in the code to get both :
>>
>>    - Allocate ram equally from all the nodes of the machine
>>
>>    - Use large pages (2MB) to lower TLB stress
> 
> These two desires are mutually exclusive, I think.
> 
> If you want an 8MB hash table, for example, with 2MB mappings
> you could use memory from a maximum of 4 nodes since the
> 2MB chunks have to be physically 2MB aligned and 2MB contiguous.

Yes of course, but as those hash tables are very big (their size is bigger 
than 2MB * number_of_nodes if you have at least 4GB per node), this could be 
done ?

Eric

