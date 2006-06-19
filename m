Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964915AbWFSVyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbWFSVyK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 17:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbWFSVyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 17:54:10 -0400
Received: from userg501.nifty.com ([202.248.238.81]:14262 "EHLO
	userg501.nifty.com") by vger.kernel.org with ESMTP id S964915AbWFSVyI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 17:54:08 -0400
Message-ID: <44971ABD.3060202@jp.fujitsu.com>
Date: Tue, 20 Jun 2006 06:44:29 +0900
From: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Sam Vilain <sam@vilain.net>
CC: vatsa@in.ibm.com, Nick Piggin <nickpiggin@yahoo.com.au>,
       Kirill Korotaev <dev@openvz.org>, Mike Galbraith <efault@gmx.de>,
       Ingo Molnar <mingo@elte.hu>, Peter Williams <pwil3058@bigpond.net.au>,
       Andrew Morton <akpm@osdl.org>, sekharan@us.ibm.com,
       Balbir Singh <balbir@in.ibm.com>, linux-kernel@vger.kernel.org,
       kurosawa@valinux.co.jp, ckrm-tech@lists.sourceforge.net,
       MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Subject: Re: [RFC] CPU controllers?
References: <20060615134632.GA22033@in.ibm.com> <4493C1D1.4020801@yahoo.com.au> <20060617164812.GB4643@in.ibm.com> <4494DF50.2070509@yahoo.com.au> <4494EA66.8030305@vilain.net> <20060618071847.GA4988@in.ibm.com> <449606F5.6050909@vilain.net> <44964C89.6060003@jp.fujitsu.com> <44965E0C.9050508@vilain.net> <44966320.6080308@jp.fujitsu.com> <44966617.6040005@vilain.net>
In-Reply-To: <44966617.6040005@vilain.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain wrote:
> MAEDA Naoaki wrote:
>>> Ok, so that's not as bad as it looked.  So, while it is still O(N), the
>>> fact that it is O(N/HZ) makes this not a problem until you get to
>>> possibly impractical levels of runqueue length.
>>>     
>> Do you mean N is the size of the loop? for_each_cpu_mask() loops
>> the number of CPUs times. It is not directly related to runqueue length.
>>   
> 
> Ok, I mistook it for a per-task loop.
> 
> Well, let me know if you think it's worth trying it out anyway.

I don't think this loop would be a bottle neck, but test by third person
is always valuable.

Thanks,
MAEDA Naoaki

