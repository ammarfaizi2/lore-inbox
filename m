Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWIMMQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWIMMQH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 08:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWIMMQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 08:16:07 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:54198 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750725AbWIMMQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 08:16:05 -0400
Date: Wed, 13 Sep 2006 17:45:25 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Pavel Emelianov <xemul@openvz.org>
Cc: sekharan@us.ibm.com, balbir@in.ibm.com, Rik van Riel <riel@redhat.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org,
       Matt Helsley <matthltc@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Kirill Korotaev <dev@sw.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added	user memory)
Message-ID: <20060913121525.GC7543@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <45011CAC.2040502@openvz.org> <1157730221.26324.52.camel@localhost.localdomain> <4501B5F0.9050802@in.ibm.com> <450508BB.7020609@openvz.org> <4505161E.1040401@in.ibm.com> <45051AC7.2000607@openvz.org> <1158000590.6029.33.camel@linuxchandra> <45069072.4010007@openvz.org> <1158105488.4800.23.camel@linuxchandra> <4507BC11.6080203@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4507BC11.6080203@openvz.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2006 at 12:06:41PM +0400, Pavel Emelianov wrote:
> OK. Then limiting must be done this way (unreclaimable limit/total limit)
> A (15/40)
> B (25/100)
> C (35/100)

s/35/30?

Also the different b/n total and unreclaimable limits goes towards
limiting reclaimable memory i suppose? And 1st limit seems to be a
hard-limit while the 2nd one is soft?

> D (10/100)
> E (20/50)
> In this case each group will receive it's guarantee for sure.
> 
> E.g. even if A, B, E and D will eat all it's unreclaimable memory then
> we'll have
> 100 - 15 - 25 - 20 - 10 = 30% of memory left (maybe after reclaiming) which
> is perfectly enough for C's guarantee.

I agree by carefully choosing these limits, we can provide some sort of
QoS, which is a good step to begin with.


-- 
Regards,
vatsa
