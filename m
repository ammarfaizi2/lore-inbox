Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751615AbWJWGtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbWJWGtz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 02:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbWJWGtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 02:49:55 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:22418 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751614AbWJWGtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 02:49:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=4p3BuHpVwmvPSqWd9BZuHRy9bAE/m9ucFPBqx0smbXD8ylKax3/mWp/jPseENGYHXOJeoMFXt4he7iEShL5O2WmR8tbqfaTcMPF8RD6sUudYbQEqRF4CdZqcyqSPDLWo2TWUyEJeNtjO3woMdwwt0FvJN+w4G0Heqr0UAO94Mks=  ;
Message-ID: <453C660A.1060405@yahoo.com.au>
Date: Mon, 23 Oct 2006 16:49:46 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: dino@in.ibm.com, akpm@osdl.org, mbligh@google.com, menage@google.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, rohitseth@google.com,
       holt@sgi.com, dipankar@in.ibm.com, suresh.b.siddha@intel.com
Subject: Re: [RFC] cpuset: add interface to isolated cpus
References: <20061019092607.17547.68979.sendpatchset@sam.engr.sgi.com>	<20061020210422.GA29870@in.ibm.com>	<20061022201824.267525c9.pj@sgi.com>	<453C4E22.9000308@yahoo.com.au>	<20061022225108.21716614.pj@sgi.com>	<453C5E77.2050905@yahoo.com.au> <20061022234152.baaf4624.pj@sgi.com>
In-Reply-To: <20061022234152.baaf4624.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Nick wrote:
> 
>>These are both part of the same larger solution, which is to
>>partition domains. isolated CPUs are just the case of 1 CPU in
>>its own domain (and that's how they are implemented now).
> 
> 
> and later, he also wrote:
> 
>>I think this is much more of an automatic behind your back thing.
> 
> 
> I got confused there.
> 
> I agree that if we can do a -good- job of it, then an implicit,
> automatic solution is better for the problem of reducing sched domain
> partition sizes on large systems than yet another manual knob.

OK, good.

> But I thought that it was good idea, with general agreement, to provide
> an explicit control of isolated cpus for the real-time folks, even if
> under the covers it use sched domain partitions of size 1 to implement
> it.

If they isolate it by setting the cpus_allowed masks of processes
to reflect the way they'd like balancing to be carried out, then
the partition will be made for them.

But an explicit control might be required anyway, and I wouldn't
disagree with it. It might be required to do more than just sched
partitioning (eg. pdflush and other kernel threads should probably
be made to stay off isolated cpus as well, where possible).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
