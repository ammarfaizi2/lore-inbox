Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269313AbUHZSim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269313AbUHZSim (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 14:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269292AbUHZSfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:35:13 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:31463 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269235AbUHZSaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 14:30:24 -0400
Message-ID: <412E2B6B.80904@engr.sgi.com>
Date: Thu, 26 Aug 2004 11:26:51 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Schmielau <tim@physik3.uni-rostock.de>
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       erikj@dbear.engr.sgi.com, limin@engr.sgi.com,
       lse-tech@lists.sourceforge.net,
       =?ISO-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>,
       Yoshitaka ISHIKAWA <y.ishikawa@soft.fujitsu.com>,
       Arthur Corliss <corliss@digitalmages.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Subject: Re: [Lse-tech] Re: [PATCH] new CSA patchset for 2.6.8
References: <412D2E10.8010406@engr.sgi.com> <20040825221842.72dd83a4.akpm@osdl.org> <Pine.LNX.4.53.0408261821090.14826@gockel.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.53.0408261821090.14826@gockel.physik3.uni-rostock.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The reason for breaking up one CSA patch into four patches was
so that the only CSA (http://oss.sgi.com/projects/csa/) specific
thing is the csa_module. My intention is to improve the system
accounting data collection and make the data available to any
clients that can use the data. The three areas of accounting
data we try to improve are io, mm, and per-process area.

As Tim said the problem of BSD accounting was that it has been
inactive for a long time. I do not mind incoporating the
three accounting data collection patches i submitted into BSD or
others as long as the data made available to modules that plan
to make use of the data. :)

Thanks,
  - jay


Tim Schmielau wrote:
> On Wed, 25 Aug 2004, Andrew Morton wrote:
> 
> 
>>More broadly: Help!
>>
>>I am 100% not in a position to judge whether Linux needs Comprehensive
>>System Accounting, nor am I able to define what the requirements for such a
>>thing should be.  All I can tell from your patch is the quality of its
>>implementation, and that's leaping far, far ahead of where we should be.
>>
>>We're going to need help from you, and from all the other stakeholders in
>>judging how useful this feature is to Linux implementors and how well this
>>implementation meets the (unknown) requirements.  See my problem?
>>
>>I've cc'ed lse-tech, where enterprise folks hang out.  I would request that
>>the people who are stakeholders in this feature
>>
>>a) stick their hands up
>>
>>b) let us know how important this kind of feature is for their users
>>
>>c) review the offered feature set against their requirements
>>
>>d) let us know how well the implementation fits that requirement and
>>
>>e) inform us of any competing implementations.  Compare and contrast.
> 
> 
> Judging from the feedback during it's stay in -mm (none at all!), general
> interest in BSD accounting seems quite limited. The rate of downloads of
> the updated userspace tools is hardly distinguishable from background
> noise. (This might change with the correct URL in the help text now, but
> even that was broken for months and nobody cared).
> Also general interest in the user space tools is low, the latest release 
> of the GNU acct package is from 1998 (and yes, there _are_ problems 
> warranting updates).
> 
> Funnily enough, with three competing implementation even interest from
> developers seems larger than that from users (This statement includes me,
> I did a patch but am not a user of it).) But communication between
> developers is poor. I for myself only recently learned about ELSA and CSA.
> 
> Therefore I've Cc:ed some people from whom I got valuable feedback on the
> BSD accounting format patch.
> 
> IMHO CSA, ELSA and BSD accounting are too similar to have more than one of 
> them in the kernel. We should either improve BSD accounting to do the job, 
> or kill it in favor of a different implementation.
> 
> Tim
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
> 100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
> Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
> http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech

