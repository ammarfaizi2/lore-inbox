Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbWINIHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWINIHL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 04:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWINIHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 04:07:10 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:8326 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751452AbWINIHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 04:07:08 -0400
Message-ID: <45090D9E.9000903@in.ibm.com>
Date: Thu, 14 Sep 2006 13:36:54 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Pavel Emelianov <xemul@openvz.org>
Cc: sekharan@us.ibm.com, Srivatsa <vatsa@in.ibm.com>,
       Rik van Riel <riel@redhat.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org,
       Matt Helsley <matthltc@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Kirill Korotaev <dev@sw.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added	user
 memory)
References: <44FD918A.7050501@sw.ru>	<44FDAB81.5050608@in.ibm.com>		<44FEC7E4.7030708@sw.ru>	<44FF1EE4.3060005@in.ibm.com>		<1157580371.31893.36.camel@linuxchandra>	<45011CAC.2040502@openvz.org>		<1157730221.26324.52.camel@localhost.localdomain>		<4501B5F0.9050802@in.ibm.com> <450508BB.7020609@openvz.org>		<4505161E.1040401@in.ibm.com> <45051AC7.2000607@openvz.org>		<1158000590.6029.33.camel@linuxchandra>	<45069072.4010007@openvz.org>		<1158105488.4800.23.camel@linuxchandra>	<4507BC11.6080203@openvz.org>	<1158186664.18927.17.camel@linuxchandra> <45090A6E.1040206@openvz.org>
In-Reply-To: <45090A6E.1040206@openvz.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Emelianov wrote:

> I don't understand your idea. Limit does _not_ imply anything - it's
> just a limit.
> You may limit anything to anyone w/o bothering the consequences.
> Guarantee implies that the resource you guarantee will be available and
> this "will be" is something not that easy.
> 
> So I repeat my question - how can you be sure that these X megabytes you
> guarantee to some group won't be used by others so that you won't be able
> to reclaim them?
> 
> 

May be we can treat a guarantee as a soft guarantee. A soft
guarantee would imply that when a group needs its guaranteed resources, the
system makes its best effort to make it available.

In soft guarantees, resources not actively used by a group can be shared with
other groups.

Hard guarantees would probably require reserving the resource in advance and
sharing of the resources not used, with other groups, might not be possible.

Comments?

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
