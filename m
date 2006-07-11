Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWGKPdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWGKPdv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 11:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWGKPdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 11:33:51 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:43179 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751291AbWGKPdu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 11:33:50 -0400
Message-ID: <44B3C4D6.8010606@watson.ibm.com>
Date: Tue, 11 Jul 2006 11:33:42 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Jay Lan <jlan@sgi.com>, Chris Sturtivant <csturtiv@sgi.com>,
       Paul Jackson <pj@sgi.com>, Balbir Singh <balbir@in.ibm.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
Subject: Re: [Patch 0/6] delay accounting & taskstats fixes
References: <1152591838.14142.114.camel@localhost.localdomain> <20060711112835.GA22832@infradead.org>
In-Reply-To: <20060711112835.GA22832@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Tue, Jul 11, 2006 at 12:23:58AM -0400, Shailabh Nagar wrote:
> 
>>Andrew,
>>
>>Chandra, Balbir & I have been putting taskstats and delay accounting
>>patches through some extensive testing on multiple platforms.
>>
>>Following are a set of patches that fix some bugs found as well as
>>some cleanups of the code. Some results showing the cpumask feature 
>>works as expected will follow separately.
> 
> 
> Btw, did you ever explain what this delay accounting code is useful for
> exactly?  

Yes.
Previous postings have explained the rationale,

http://www.uwsg.indiana.edu/hypermail/linux/kernel/0511.1/2275.html
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0512.0/2152.html

lwn.net had a good summary as always,
http://lwn.net/Articles/173209/




> It's an awfull lot of code that doesn't seem to have a huge
> use.  

The delay accounting part of the code is quite small (just a few
lines of timestamping code place in core kernel code) and much of the
remaining size comes from the interface. Since the interface is designed
to be of generic use towards ANY per-task accounting needs, discussions and
code have been fairly involved. We went through a long discussion of
potential exploiters:

(see thread under [Patch 0/8] per-task delay accounting at
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0603.3/index.html

> While we're at it do you have a pointer to the associated userspace code?
> 

Its part of the patches in Documentation/accounting/getdelays.c

and the last-but-one version of it can be viewed at its location in the -mm
tree:
http://www.linux-m32r.org/lxr/http/source/Documentation/accounting/?a=generic

(The just accepted patches updates the documentation especially the parts
relating to cpumasks but the above should also suffice to give a flavor of
what userspace could do).


Thanks,
Shailabh

