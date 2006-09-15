Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750699AbWIOIxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750699AbWIOIxT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 04:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbWIOIxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 04:53:19 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:13745 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750699AbWIOIxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 04:53:18 -0400
Message-ID: <450A6B06.1050308@sw.ru>
Date: Fri, 15 Sep 2006 12:57:42 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: sekharan@us.ibm.com
CC: Pavel Emelianov <xemul@openvz.org>, balbir@in.ibm.com,
       Dave Hansen <haveblue@us.ibm.com>, Rik van Riel <riel@redhat.com>,
       Srivatsa <vatsa@in.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Matt Helsley <matthltc@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       devel@openvz.org
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added	user
 memory)
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com>	 <44FEC7E4.7030708@sw.ru> <44FF1EE4.3060005@in.ibm.com>	 <1157580371.31893.36.camel@linuxchandra> <45011CAC.2040502@openvz.org>	 <1157730221.26324.52.camel@localhost.localdomain>	 <4501B5F0.9050802@in.ibm.com>  <450508BB.7020609@openvz.org> <1158000262.6029.26.camel@linuxchandra>
In-Reply-To: <1158000262.6029.26.camel@linuxchandra>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> CKRM/RG handles it this way:
> 
> Amount of a resource a child RG gets is the ratio of its share value to
> the parent's total # of shares. Children's resource allocation can be
> changed just by changing the parent's total # of shares.
> 
> If you case about initial situation would be:
>   Total memory in the system 100MB 
>   parent's total # of shares: 100 (1 share == 1MB)
>   10 children with # of shares: 10 (i.e each children has 10MB)
> 
> When I want to add another child, just change parent's total # of shares
> to be say 125:
>   Total memory in the system 100MB
>   parent's total # of shares: 125 (1 share == 0.8MB)
>   10 children with # of shares: 10 (i.e each children has 8MB)
> Now you are left with 25 shares (or 20MB) that you can assign to new
> child(ren) as you please.

setting memory in "shares" doesn't look user friendly at all...

Kirill

