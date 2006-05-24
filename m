Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbWEXWr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWEXWr5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 18:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWEXWr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 18:47:57 -0400
Received: from outgoing.tpinternet.pl ([193.110.120.20]:50796 "EHLO
	outgoing.tpinternet.pl") by vger.kernel.org with ESMTP
	id S964780AbWEXWr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 18:47:56 -0400
In-Reply-To: <20060506180551.GB22474@thunk.org>
References: <8.420169009@selenic.com> <65CF7F44-0452-4E94-8FC1-03B024BCCAE7@mac.com> <20060505172424.GV15445@waste.org> <20060505191127.GA16076@thunk.org> <20060505203436.GW15445@waste.org> <20060506115502.GB18880@thunk.org> <20060506164808.GY15445@waste.org> <20060506180551.GB22474@thunk.org>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6935C0D2-528C-47B5-A7A8-7FCA2672FCD7@neostrada.pl>
Cc: Matt Mackall <mpm@selenic.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       davem@davemloft.net
Content-Transfer-Encoding: 7bit
From: Marcin Dalecki <dalecki.marcin@neostrada.pl>
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Date: Thu, 25 May 2006 00:47:18 +0200
To: Theodore Tso <tytso@mit.edu>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2006-05-06, at 20:05, Theodore Tso wrote:

> Agreed, but I'd an additional point of nuance; this assumes that the
> attacker (call him Boris for the sake of argument) can actually gain
> access to enough /dev/random or /dev/urandom outputs, and be
> knowledgable about all other calls to /dev/random and exactly when
> they happen (since entropy extractions cause the TSC to be mixed into
> the pool) so Boris can can actually determine the contents of the
> pool.  Note that simply "breaking" a cryptographic hash, in the sense
> of finding two input values that collide to the same output value,
> does not mean that the hash has been sufficiently analyzed that it
> would be possible to accomplish this feat.  And given that it took
> 80,000 CPU hours to determine find this collision, and the complexity
> of the attack was 2**51, it seems highly likely that with a poolsize
> of 4096 bits, that it would take a huge amount of /dev/random
> extractions, complete with the exact TSC timestamp when the
> extractions were happening, such that an attacker would be able to
> have enough information to break the pool.

Anytime you start to make unquantified assumptions in the context of / 
dev/random
the issue turns up that this whole thing is not worth the trouble  
because much
simpler approaches will be sufficient enough to acomplish what it  
does. On the other
hand you can't provide any actual full analysis of it's behaviour -  
which is just
*not acceptable* for anybody trully concerned. And this in  
conjunction makes the WHOLE
idea behind it questionable.

