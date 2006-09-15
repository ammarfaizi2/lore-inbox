Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWIOIoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWIOIoz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 04:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWIOIoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 04:44:55 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:31542 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750758AbWIOIoy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 04:44:54 -0400
Message-ID: <450A6909.4060208@sw.ru>
Date: Fri, 15 Sep 2006 12:49:13 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: sekharan@us.ibm.com
CC: Pavel Emelianov <xemul@openvz.org>, balbir@in.ibm.com,
       Srivatsa <vatsa@in.ibm.com>, Rik van Riel <riel@redhat.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org,
       Matt Helsley <matthltc@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added	user
 memory)
References: <44FD918A.7050501@sw.ru>	<44FDAB81.5050608@in.ibm.com>	 <44FEC7E4.7030708@sw.ru>	<44FF1EE4.3060005@in.ibm.com>	 <1157580371.31893.36.camel@linuxchandra>	<45011CAC.2040502@openvz.org>	 <1157730221.26324.52.camel@localhost.localdomain>	 <4501B5F0.9050802@in.ibm.com> <450508BB.7020609@openvz.org>	 <4505161E.1040401@in.ibm.com> <45051AC7.2000607@openvz.org>	 <1158000590.6029.33.camel@linuxchandra>	<45069072.4010007@openvz.org>	 <1158105488.4800.23.camel@linuxchandra>	<4507BC11.6080203@openvz.org>	 <1158186664.18927.17.camel@linuxchandra> <45090A6E.1040206@openvz.org>	 <45090D9E.9000903@in.ibm.com>  <450952F8.8080606@openvz.org> <1158278541.6357.49.camel@linuxchandra>
In-Reply-To: <1158278541.6357.49.camel@linuxchandra>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> <snip>
> 
>>Reserving in advance means that sometimes you won't be able to start a
>>new group without taking back some of reserved pages. This is ... strange.
> 
> 
> I do not see it strange. At the time of creation, user sees the failure
> (that there isn't enough resource to provide the required/requested
> guarantee) and can act accordingly.
> 
> BTW, VMware does it this way.
This is not true at least for ESX server.
It overcommits memory and does dirty tricks like balooning to free memory then.

[...]

> We would need at least:
>  - BC should be created/deleted explicitly by the user
>  - cleaner interface for controller writers
why do you bother for the last too much?
The number of controlers is quite limited...

Kirill
