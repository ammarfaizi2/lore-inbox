Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbVHUJ1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbVHUJ1K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 05:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbVHUJ1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 05:27:10 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:4981 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750898AbVHUJ1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 05:27:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=2N05cpJwhHczCfDHHBcZvFv7PGLmZXu+KLoEzevfMRjOLqFSvIKyddmekmvmMr0JUTZDF8J0tPS801eO09iW04FzRfAvOPQSm6nOP1Xi8Yhw19jUSTdtUyA9fj6TnWdTq2bGNvTPH/RxnfYTf1u9vD/AjugRAEK3D2IEg8l2r34=  ;
Message-ID: <430848F5.3040308@yahoo.com.au>
Date: Sun, 21 Aug 2005 19:27:17 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: tony.luck@intel.com, linux-kernel@vger.kernel.org, jasonuhl@sgi.com
Subject: Re: CONFIG_PRINTK_TIME woes
References: <B8E391BBE9FE384DAA4C5C003888BE6F042C7DA7@scsmsx401.amr.corp.intel.com>	<20050821021322.3986dd4a.akpm@osdl.org> <20050821021616.6bbf2a14.akpm@osdl.org>
In-Reply-To: <20050821021616.6bbf2a14.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> 
>>How about we give each arch a printk_clock()?
> 
> 
> Which might be as simple as this..
> 
> 

sched_clock() shouldn't really be taken outside kernel/sched.c,
especially for things like this.

It actually has some fundamental problems even in its current
use in the scheduler (which need to be fixed). But basically it
is a very nasty interface with a rather tenuous relationship to
time.

Why not use something like do_gettimeofday? (or I'm sure one
of our time keepers can suggest the right thing to use).

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
