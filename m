Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbWFXPw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWFXPw1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 11:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbWFXPw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 11:52:27 -0400
Received: from main.gmane.org ([80.91.229.2]:38843 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750838AbWFXPw0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 11:52:26 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joe Seigh <jseigh_02@xemaps.com>
Subject: Re: Userspace RCU+rtth hack (was Re: [patch 3/3] radix-tree: RCU
 lockless readside)
Date: Sat, 24 Jun 2006 11:55:29 -0400
Message-ID: <e7jn3c$rsf$1@sea.gmane.org>
References: <20060408134635.22479.79269.sendpatchset@linux.site> <20060408134707.22479.33814.sendpatchset@linux.site> <20060622014949.GA2202@us.ibm.com> <20060622154518.GA23109@wotan.suse.de> <20060622163032.GC1295@us.ibm.com> <20060622165551.GB23109@wotan.suse.de> <20060622174057.GF1295@us.ibm.com> <20060622182343.GA29003@wotan.suse.de> <20060622202552.GH1295@us.ibm.com> <20060624102024.GA27865@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-60-56-212.hsd1.ma.comcast.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
In-Reply-To: <20060624102024.GA27865@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> On Thu, Jun 22, 2006 at 01:25:53PM -0700, Paul E. McKenney wrote:
> 
> 
>>I have a few user-mode implementations myself, but the lawyers won't
>>let me release them.  :-(
> 
> 
> I imagine they're quite a bit faster than my quick hack, too ;)
> 
> 

I did a number of implementations trying out a number of different strategies.
Yes, they're quite a bit faster and scale better than lock based solutions in
most cases.  They used to be on my atomic-ptr-plus sourceforge project page.
The issue is patents I think.  The RCU patents aren't in any patent pools
for use by open source.  The only thing I think you can do is apply for what
are known as blocking patents for any improvements on RCU.  But you'd have to
sell the patent to recover your patent costs and who would have money for that
do you think, the EFF or a patent troll?

I'm guessing that if lock-free synchronization comes to userspace it will be in
the form of a licensed library that you have to pay for.  There's two out there
already based on Maged Michael's hazard pointers.  One from Intel here
http://www.intel.com/cd/software/products/asmo-na/eng/272688.htm
and one from here http://www.pss-ab.com/

--
Joe Seigh

