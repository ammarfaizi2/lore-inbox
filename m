Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315259AbSGJNt7>; Wed, 10 Jul 2002 09:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315265AbSGJNt6>; Wed, 10 Jul 2002 09:49:58 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.21]:42058 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id <S315259AbSGJNt5>; Wed, 10 Jul 2002 09:49:57 -0400
Message-ID: <3D2C3C24.8090402@users.sf.net>
Date: Wed, 10 Jul 2002 15:52:36 +0200
From: Thomas Tonino <ttonino@users.sf.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020610
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Thomas Tonino <ttonino@users.sourceforge.net>,
       linux-kernel@vger.kernel.org, "J.A. Magallon" <jamagallon@able.es>
Subject: Re: Terrible VM in 2.4.11+?
References: <20020709001137.A1745@mail.muni.cz> <1026167822.16937.5.camel@UberGeek> <20020709005025.B1745@mail.muni.cz> <20020708225816.GA1948@werewolf.able.es> <3D2BF3CC.3040409@users.sf.net> <20020710084904.GH3185@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> That's probably not just a mm issue, if you use stock 2.4.18 with 4GB
> ram you will spend oodles of time bounce buffering i/o. 2.4.19-pre9-aa2
> includes the block-highmem stuff, which enables direct-to-highmem i/o,
> if you enabled the CONFIG_HIGHIO option.

Indeed, highio seemed a feature I wanted, so I enabled it. But in the 
'stuck' state on the 2 GB 2.4.18 machine, the load is 75 while there is 
no disk activity according to iostat, but shells perform slowly anyway 
and the CPU is idle. A reboot command doesn't work, but logging in over 
ssh is still possible.

> In short, not an apples-to-apples comparison :-)

I agree a lot has changed in that kernel. And I wanted the O(1) 
scheduler as well, as I expect a lot of processes on the server.

The 2.4.18 behaviour stays strange: the server has a fairly constant 
workload, but the cpu load, normally averaging around 2, sometimes rises 
to 75 in about an hour, and usually the load also winds down again.

None of the strange effects above have been noticed on 2.4.19-pre9-aa2. 
BTW, the qlogic patch is great in preventing the handle slots issue.


Thomas


