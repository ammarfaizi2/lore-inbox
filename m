Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422745AbWHEDar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422745AbWHEDar (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 23:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422752AbWHEDar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 23:30:47 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:4461 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422745AbWHEDaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 23:30:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=1Hy7VQyTD4eAwoJ0kWiLAHS8S/4+t1ZaMkSAmPeutG4DzWGo7uGRKfsUeympcT8FjE0r5MsETYtMvhyN9ihvSsC24eUj/MlULYXgudhe7AUQbKyOTVVx4k3uLYyFj+yC/85I0j3uCfdTO2ZwS6DV6mSIlxrLH8cTH33xbmtvako=  ;
Message-ID: <44D410D9.3070108@yahoo.com.au>
Date: Sat, 05 Aug 2006 13:30:33 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: vatsa@in.ibm.com, mingo@elte.hu, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, efault@gmx.de,
       balbir@in.ibm.com, sekharan@us.ibm.com, nagar@watson.ibm.com,
       haveblue@us.ibm.com, pj@sgi.com
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A cpu
 controller
References: <20060804050753.GD27194@in.ibm.com> <20060803223650.423f2e6a.akpm@osdl.org>
In-Reply-To: <20060803223650.423f2e6a.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Fri, 4 Aug 2006 10:37:53 +0530
> Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
> 
> 
>>Resource management has been talked about quite extensively in the
>>past, more recently in the context of containers. The basic requirement
>>here is to provide isolation between *groups* of task wrt their use
>>of various resources like CPU, Memory, I/O bandwidth, open file-descriptors etc.
>>
>>Different maintainers have however expressed different opinions over the need to
>>complicate the kernel to meet this need, especially since it involves core 
>>kernel code like the resource schedulers. 
>>
>>A BoF was hence held at OLS this year to come to a consensus on the minimum 
>>requirements of a resource management solution for Linux kernel. Some notes 
>>taken at the BoF are posted here:
>>
>>	http://www.uwsg.indiana.edu/hypermail/linux/kernel/0607.3/0896.html
>>
>>An important consensus point of the BoF seemed to be "focus on real 
>>controllers more, preferably memory first, using some simple interface
>>and task grouping mechanism".
> 
> 
> ug, I didn't know this.  Had I been there (sorry) I'd have disagreed with
> this whole strategy.
> 
> I thought the most recently posted CKRM core was a fine piece of code.  It
> provides the machinery for grouping tasks together and the machinery for
> establishing and viewing those groupings via configfs, and other such
> common functionality.  My 20-minute impression was that this code was an
> easy merge and it was just awaiting some useful controllers to come along.
> 
> And now we've dumped the good infrastructure and instead we've contentrated
> on the controller, wired up via some imaginative ab^H^Hreuse of the cpuset
> layer.
> 
> I wonder how many of the consensus-makers were familiar with the
> contemporary CKRM core?

Sorry, I've been busy with offline stuff and won't be able to catch up with
emails until next week -- someone else might have already covered this.

But: I think we definitely agreed that a nice simple implementation and even
userspace API for grouping tasks would be a no-brainer.

I advocated implementing some simple controllers on top of such an interface
first, that people can start to put in some of their requirements, see if a
common controller framework should be created, look at what interfaces people
want for them.

I don't have a problem with CKRM as such, but I think there are other groups
with good approaches and the problem has been to get people working together.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
