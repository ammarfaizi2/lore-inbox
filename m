Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030276AbWIRXvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbWIRXvl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 19:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030275AbWIRXvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 19:51:41 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:27295 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030276AbWIRXvk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 19:51:40 -0400
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added	user
	memory)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Kirill Korotaev <dev@sw.ru>
Cc: Rik van Riel <riel@redhat.com>, Srivatsa <vatsa@in.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, balbir@in.ibm.com,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Hugh Dickins <hugh@veritas.com>, Alexey Dobriyan <adobriyan@mail.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>, devel@openvz.org,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <450A6909.4060208@sw.ru>
References: <44FD918A.7050501@sw.ru>	<44FDAB81.5050608@in.ibm.com>
	 <44FEC7E4.7030708@sw.ru>	<44FF1EE4.3060005@in.ibm.com>
	 <1157580371.31893.36.camel@linuxchandra>	<45011CAC.2040502@openvz.org>
	 <1157730221.26324.52.camel@localhost.localdomain>
	 <4501B5F0.9050802@in.ibm.com> <450508BB.7020609@openvz.org>
	 <4505161E.1040401@in.ibm.com> <45051AC7.2000607@openvz.org>
	 <1158000590.6029.33.camel@linuxchandra>	<45069072.4010007@openvz.org>
	 <1158105488.4800.23.camel@linuxchandra>	<4507BC11.6080203@openvz.org>
	 <1158186664.18927.17.camel@linuxchandra> <45090A6E.1040206@openvz.org>
	 <45090D9E.9000903@in.ibm.com> <450952F8.8080606@openvz.org>
	 <1158278541.6357.49.camel@linuxchandra>  <450A6909.4060208@sw.ru>
Content-Type: text/plain
Organization: IBM
Date: Mon, 18 Sep 2006 16:51:35 -0700
Message-Id: <1158623495.6536.5.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-15 at 12:49 +0400, Kirill Korotaev wrote:
> > <snip>
> > 
> >>Reserving in advance means that sometimes you won't be able to start a
> >>new group without taking back some of reserved pages. This is ... strange.
> > 
> > 
> > I do not see it strange. At the time of creation, user sees the failure
> > (that there isn't enough resource to provide the required/requested
> > guarantee) and can act accordingly.
> > 
> > BTW, VMware does it this way.
> This is not true at least for ESX server.

Hmm, from what I have seen, in ESX server, creation of a VM will fail,
if the specified guarantees cannot meet at the time of creation.
 
> It overcommits memory and does dirty tricks like balooning to free memory then.

This is how they handle over commit, which is not what I was talking
about.

<snip>

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


