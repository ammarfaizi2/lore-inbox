Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268755AbUJEDM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268755AbUJEDM0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 23:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268753AbUJEDMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 23:12:25 -0400
Received: from main.gmane.org ([80.91.229.2]:27083 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268755AbUJEDMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 23:12:08 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andrew Rodland <arodland@entermail.net>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm1-S9
Date: Mon, 04 Oct 2004 23:09:29 -0400
Message-ID: <cjt3e2$pr3$1@sea.gmane.org>
References: <20040919122618.GA24982@elte.hu> <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu> <20041004215315.GA17707@elte.hu> <20041005034223.70ae4af7@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: port146.public4.resnet.ucf.edu
User-Agent: KNode/0.8.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Schmidt wrote:

> On Mon, 4 Oct 2004 23:53:15 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
>> 
>> i've released the -S9 VP patch:
>> 
>>  
http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm2-S9
>> 
> 
> Something is fishy for me from S8 on. I justbooted into S9 and i see
> many many xruns under load in jackd [as i saw in S8]. Since all my ll
> settings are enabled as usual, something else must be wrong.
> 
> I find the following very interesting:
> 
> mango:~# ps aux|grep IRQ
> root        12  0.0  0.0     0    0 ?        S<   04:28   0:00 [IRQ 8]
> root        14  0.0  0.0     0    0 ?        S<   04:28   0:00 [IRQ 12]
> root        15  0.0  0.0     0    0 ?        S<   04:28   0:00 [IRQ 14]
> root        16  0.0  0.0     0    0 ?        S<   03:17   0:00 [IRQ 15]
> root        17  0.0  0.0     0    0 ?        S<   03:17   0:00 [IRQ 1]
> root       314  0.0  0.0     0    0 ?        S<   03:17   0:00 [IRQ 10]
> root      7983  0.6  0.0     0    0 ?        S<   03:26   0:03 [IRQ 5]
> root     14617  0.0  0.0  1576  464 pts/2    R+   03:35   0:00 grep IRQ
> mango:~# chrt -p 7938
> sched_getscheduler: No such process
> failed to get pid 7938's policy
> 
> For other irq threads i get normal values [SCHED_OTHER].
> 

Looks like a case of minor dyslexia to me. 7983 != 7938 :)

--hobbs


