Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbWILKfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbWILKfr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 06:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030189AbWILKfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 06:35:47 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:9740 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1030185AbWILKfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 06:35:46 -0400
Message-ID: <45068D81.5000606@openvz.org>
Date: Tue, 12 Sep 2006 14:35:45 +0400
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: vatsa@in.ibm.com, balbir@in.ibm.com, sekharan@us.ibm.com
CC: Rik van Riel <riel@redhat.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Matt Helsley <matthltc@us.ibm.com>,
       Hugh Dickins <hugh@veritas.com>, Alexey Dobriyan <adobriyan@mail.ru>,
       Kirill Korotaev <dev@sw.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added	user
 memory)
References: <44FDAB81.5050608@in.ibm.com> <44FEC7E4.7030708@sw.ru> <44FF1EE4.3060005@in.ibm.com> <1157580371.31893.36.camel@linuxchandra> <45011CAC.2040502@openvz.org> <1157730221.26324.52.camel@localhost.localdomain> <4501B5F0.9050802@in.ibm.com> <450508BB.7020609@openvz.org> <4505161E.1040401@in.ibm.com> <45051AC7.2000607@openvz.org> <20060911102152.GC17182@in.ibm.com>
In-Reply-To: <20060911102152.GC17182@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> On Mon, Sep 11, 2006 at 12:13:59PM +0400, Pavel Emelianov wrote:
>   
>> If I set up 9 groups to have 100Mb limit then I have 100Mb assured (on
>> 1Gb node)
>> for the 10th one exactly. And I do not have to set up any guarantee as
>> it won't affect
>> anything. So what a guarantee parameter is needed for?
>>     
>
> I presume you are talking of hard-limiting each group to 100 MB here. In
> which case, wont the 100MB (reserved for 10th group) be unutilized
> untill 10th group is started (it may never be started for that matter!).
>
> IMO it would be better to go and use that free 100 MB for reclaimable memory
> and give that up when 10th group is started.
>   
Sure. I've talked about the unreclaimable memory.
Sorry, for not specifying it explicitly.
