Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265939AbUBKQs6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 11:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265941AbUBKQs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 11:48:58 -0500
Received: from dictum-ext.geekmail.cc ([204.239.179.245]:20958 "EHLO
	mailer01.geekmail.cc") by vger.kernel.org with ESMTP
	id S265939AbUBKQsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 11:48:55 -0500
Message-ID: <402A5CEC.2030603@swapped.cc>
Date: Wed, 11 Feb 2004 08:48:44 -0800
From: Alex Pankratov <ap@swapped.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.6] [2/2] hlist: remove IFs from hlist functions
References: <4029CB7E.4030003@swapped.cc.suse.lists.linux.kernel>	<4029CF24.1070307@osdl.org.suse.lists.linux.kernel>	<4029D2D5.7070504@swapped.cc.suse.lists.linux.kernel> <p73y8ra5721.fsf@nielsen.suse.de>
In-Reply-To: <p73y8ra5721.fsf@nielsen.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi Kleen wrote:

> Alex Pankratov <ap@swapped.cc> writes:
> 
>>
>>No, because its 'pprev' field *is* getting modified.
> 
> I didn't notice this before, sorry. But this could end up 
> being a scalability problem on big SMP systems. Even though
> the cache line of this is never read it will bounce all the
> time between all CPUs using hlists and add considerably 
> latency and cross node traffic. Remember Linux is supposed
> to run well on 128 CPU machines now.

That's a bit above my head. How does this potential latency
compare to the speed up due to not having CMPs ? My cycle
counting skills are a bit dusty :)

> 
> Maybe you can make it UP only, but I'm still not sure it's 
> worth it.
> 

Sorry, I didn't the 'UP' part.
