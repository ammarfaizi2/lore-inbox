Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932794AbWAKGlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932794AbWAKGlB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 01:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932802AbWAKGlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 01:41:01 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:36484 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S932794AbWAKGlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 01:41:00 -0500
Message-ID: <43C4A867.7080408@colorfullife.com>
Date: Wed, 11 Jan 2006 07:40:39 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: paulmck@us.ibm.com
CC: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       vatsa@in.ibm.com
Subject: Re: [PATCH 3/3] rcu: join rcu_ctrlblk and rcu_state
References: <43C3BB12.B5523F2C@tv-sign.ru> <20060111043557.GM18252@us.ibm.com>
In-Reply-To: <20060111043557.GM18252@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney wrote:

>On Tue, Jan 10, 2006 at 04:48:02PM +0300, Oleg Nesterov wrote:
>  
>
>>This patch moves rcu_state into the rcu_ctrlblk. I think there
>>are no reasons why we should have 2 different variables to control
>>rcu state. Every user of rcu_state has also "rcu_ctrlblk *rcp" in
>>the parameter list.
>>    
>>
>
>Looks good to me, passes one-hour RCU torture test.
>
>Manfred, does the ____cacheline_internodealigned_in_smp take care
>of your cache-line alignment concerns?
>
>  
>
Yes.

--
    Manfred
