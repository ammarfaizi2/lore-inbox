Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965195AbWHWUy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965195AbWHWUy7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 16:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965196AbWHWUy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 16:54:59 -0400
Received: from zcars04e.nortel.com ([47.129.242.56]:13213 "EHLO
	zcars04e.nortel.com") by vger.kernel.org with ESMTP id S965195AbWHWUy6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 16:54:58 -0400
Message-ID: <44ECC09A.7090909@nortel.com>
Date: Wed, 23 Aug 2006 14:54:50 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rparedes@gmail.com
CC: linux-kernel@vger.kernel.org
Subject: Re: SMP Affinity and nice
References: <38798.127.0.0.1.1156346673.squirrel@forexproject.com>
In-Reply-To: <38798.127.0.0.1.1156346673.squirrel@forexproject.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Aug 2006 20:54:54.0654 (UTC) FILETIME=[62AF2DE0:01C6C6F6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rich Paredes wrote:

> So since cpumax5 has a lower nice value and thus a higher priority (25 in
> this case), shouldn't it be given it's own cpu.   If I give cpumax5 a nice
> value of -20, it does start using it's own cpu.
> 
> My explanation would be that since the scheduler tries to limit cpu
> affinity, the nice value of 0 isn't enough to get the scheduler to move
> this process to another processors run queue.  I could be totally wrong
> here though.

I think you are correct.  The load balancer doesn't think that this is 
enough of an imbalance to go through the effort of swapping two 
processes around.

Chris
