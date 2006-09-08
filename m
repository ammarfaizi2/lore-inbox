Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWIHH0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWIHH0b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 03:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWIHH0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 03:26:31 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:56879 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750764AbWIHH0a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 03:26:30 -0400
Message-ID: <45011B2A.6000102@openvz.org>
Date: Fri, 08 Sep 2006 11:26:34 +0400
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: sekharan@us.ibm.com
CC: Kirill Korotaev <dev@sw.ru>, Dave Hansen <haveblue@us.ibm.com>,
       Rik van Riel <riel@redhat.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org,
       Hugh Dickins <hugh@veritas.com>, Matt Helsley <matthltc@us.ibm.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added user
 memory)
References: <44FD918A.7050501@sw.ru>	 <1157478392.3186.26.camel@localhost.localdomain>  <44FED3CA.7000005@sw.ru>	 <1157579641.31893.26.camel@linuxchandra>  <44FFCA4D.9090202@openvz.org> <1157657355.19884.44.camel@linuxchandra>
In-Reply-To: <1157657355.19884.44.camel@linuxchandra>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra Seetharaman wrote:
> On Thu, 2006-09-07 at 11:29 +0400, Pavel Emelianov wrote:
> <snip>
>
>   
>>>> BUT: I remind you the talks at OKS/OLS and in previous UBC discussions.
>>>> It was noted that having a separate interfaces for CPU, I/O bandwidth
>>>>     
>>>>         
>>> But, it will be lot simpler for the user to configure/use if they are
>>> together. We should discuss this also.
>>>   
>>>       
>> IMHO such unification may only imply that one syscall is used to pass
>> configuration info into kernel.
>> Each controller has specific configurating parameters different from the
>> other ones. E.g. CPU controller must assign a "weight" to each group to
>> share CPU time accordingly, but what is a "weight" for memory controller?
>> IO may operate on "bandwidth" and it's not clear what is a "bandwidth" in
>> Kb/sec for CPU controller and so on.
>>     
>
> CKRM/RG handles this by eliminating the units from the interface and
> abstracting them to be "shares". Each resource controller converts the
> shares to its own units and handles properly. 
>   
That's what I'm talking about - common syscall/ioct/etc and each controller
parses its input itself. That's OK for us.

[snip]
