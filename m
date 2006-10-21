Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751739AbWJUGOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbWJUGOZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 02:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751740AbWJUGOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 02:14:25 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:29374 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751738AbWJUGOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 02:14:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=vCTNC9H91xWx3fOQmk7wAeVtpXQWa8y4bPkOAv1iGB/DOGQtEeGTET+kr7fa0RoNzq9hdza/gpf7Da5gvo96othc0XmgdAeEKQE9evkAWKtAZTX7jLyhRB3ykhVLtoiQlNXwynTncjadw1mWaE0LmkEY2SOvGYVaD1MLTG0HNFo=  ;
Message-ID: <4539BAB2.3010501@yahoo.com.au>
Date: Sat, 21 Oct 2006 16:14:10 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: akpm@osdl.org, mbligh@google.com, menage@google.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, dino@in.ibm.com, rohitseth@google.com,
       holt@sgi.com, dipankar@in.ibm.com, suresh.b.siddha@intel.com,
       clameter@sgi.com
Subject: Re: [RFC] cpuset: add interface to isolated cpus
References: <20061019092607.17547.68979.sendpatchset@sam.engr.sgi.com>	<453750AA.1050803@yahoo.com.au>	<20061019105515.080675fb.pj@sgi.com>	<4537BEDA.8030005@yahoo.com.au>	<20061019115652.562054ca.pj@sgi.com>	<4537CC1E.60204@yahoo.com.au>	<20061019203744.09b8c800.pj@sgi.com>	<453882AC.3070500@yahoo.com.au> <20061020130141.b5e986dd.pj@sgi.com>
In-Reply-To: <20061020130141.b5e986dd.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Nick wrote:
> 
>>Or, another question, how does my patch hijack cpus_allowed? In
>>what way does it change the semantics of cpus_allowed?
> 
> 
> It limits load balancing for tasks in cpusets containing
> a superset of that cpusets cpus.
> 
> There are always such cpusets - the top cpuset if no other.

Ah OK, and there is my misunderstanding with cpusets. From the
documentation it appears as though cpu_exclusive cpusets are
made in order to do the partitioning thing.

If you always have other domains overlapping them (regardless
that it is a parent), then what actual use does cpu_exclusive
flag have?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
