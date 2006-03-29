Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWC2AzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWC2AzO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 19:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWC2AzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 19:55:14 -0500
Received: from mail.sw-soft.com ([69.64.46.34]:11426 "EHLO mail.sw-soft.com")
	by vger.kernel.org with ESMTP id S1750724AbWC2AzM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 19:55:12 -0500
Message-ID: <4429DAE5.3040606@openvz.org>
Date: Wed, 29 Mar 2006 04:55:01 +0400
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: devel@openvz.org
CC: akpm@osdl.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
       sam@vilain.net, linux-kernel@vger.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>, serue@us.ibm.com,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, herbert@13thfloor.at
Subject: Re: [Devel] Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru> <44242D4D.40702@yahoo.com.au>	<4428FB90.5000601@sw.ru> <44295AE8.7010200@tektonic.net>
In-Reply-To: <44295AE8.7010200@tektonic.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Kirill Korotaev wrote:
>>> Oh, after you come to an agreement and start posting patches, can you
>>> also outline why we want this in the kernel (what it does that low
>>> level virtualization doesn't, etc, etc), and how and why you've agreed
>>> to implement it. Basically, some background and a summary of your
>>> discussions for those who can't follow everything. Or is that a faq
>>> item?
>> Nick, will be glad to shed some light on it.
>>
>> First of all, what it does which low level virtualization can't:
>> - it allows to run 100 containers on 1GB RAM
>>   (it is called containers, VE - Virtual Environments,
>>    VPS - Virtual Private Servers).
>> - it has no much overhead (<1-2%), which is unavoidable with hardware
>>   virtualization. For example, Xen has >20% overhead on disk I/O.
> 
> I think the Xen guys would disagree with you on this.  Xen claims <3% 
> overhead on the XenSource site.
> 
> Where did you get these figures from?  What Xen version did you test? 
> What was your configuration? Did you have kernel debugging enabled? You 
> can't just post numbers without the data to back it up, especially when 
> it conflicts greatly with the Xen developers statements.  AFAIK Xen is 
> well on it's way to inclusion into the mainstream kernel.
I have no exact numbers in the hands as I'm in another country right now.
But! We tested Xen not long ago with iozone test suite and it gave 
~20-30% disk I/O overhead. Recently we were testing CPU scheduler and 
EDF scheduler gave me 33% overhead on some very simple loads with almost 
busy loops inside VMs. It also was not providing any good fairness on 
2CPU SMP system to my suprise. You can object to me, but better simply 
retest it if interested yourself. There were other tests as well, which 
reported very different overheads on Xen 3. I suppose Xen guys do such 
measurements themself, no?
And I'm sure, they are constantly improving it, they are doing a good 
work on it.

Thanks,
Kirill
