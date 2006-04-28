Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030319AbWD1IFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbWD1IFt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 04:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030320AbWD1IFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 04:05:49 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:8613 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1030319AbWD1IFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 04:05:48 -0400
Message-ID: <4451CEB7.6080509@sw.ru>
Date: Fri, 28 Apr 2006 12:13:43 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] Re: [PATCH 0/9] CPU controller
References: <20060428013730.9582.9351.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>	 <1146201936.7523.15.camel@homer>  <4451AEA4.1040108@sw.ru>	 <1146208288.7551.19.camel@homer> <1146210395.7551.37.camel@homer>
In-Reply-To: <1146210395.7551.37.camel@homer>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>I'm also pretty sure, that CPU controller based on timeslice tricks 
>>>behaves poorly on burstable load patterns as well and with interactive 
>>>tasks. So before commiting I propose to perform a good testing on 
>>>different load patterns.
>>
>>Yes, it can only react very slowly.
> 
> 
> Actually, this might not be that much of a problem.  I know I can
> traverse queue heads periodically very cheaply.  Traversing both active
> and expired arrays to requeue starving tasks once every 100ms costs max
> 4usecs (3GHz P4) for a typical distribution.

with fair scheduling with can be a big problem, as tasks working less 
then a tick are hard to account :/

Thanks,
Kirill


