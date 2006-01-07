Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWAGHez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWAGHez (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 02:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWAGHez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 02:34:55 -0500
Received: from mf00.sitadelle.com ([212.94.174.67]:45427 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S932240AbWAGHez
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 02:34:55 -0500
Message-ID: <43BF6F0B.4060108@cosmosbay.com>
Date: Sat, 07 Jan 2006 08:34:35 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: "David S. Miller" <davem@davemloft.net>, paulmck@us.ibm.com,
       alan@lxorguk.ukuu.org.uk, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       manfred@colorfullife.com, netdev@vger.kernel.org
Subject: Re: [PATCH, RFC] RCU : OOM avoidance and lower latency
References: <43BEA693.5010509@cosmosbay.com> <200601062157.42470.ak@suse.de> <20060106.161721.124249301.davem@davemloft.net> <200601070209.02157.ak@suse.de>
In-Reply-To: <200601070209.02157.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen a écrit :
> 
> I always disliked the per chain spinlocks even for other hash tables like
> TCP/UDP multiplex - it would be much nicer to use a much smaller separately 
> hashed lock table and save cache. In this case the special case of using
> a one entry only lock hash table makes sense.
> 

I agree, I do use a hashed spinlock array on my local tree for TCP, mainly to 
reduce the hash table size by a 2 factor.

Eric
