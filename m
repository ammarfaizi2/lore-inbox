Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946406AbWJSTu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946406AbWJSTu0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 15:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946407AbWJSTu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 15:50:26 -0400
Received: from smtp-out.google.com ([216.239.45.12]:37841 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1946406AbWJSTuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 15:50:25 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=df4Gw0ZLBoEO4rKZhSFhg2qInxza4LbzSL4tFV0Jq8DaYZR83mFM8AuqyoeYR0adj
	gn6UVW+AFUhrG2QyAoGIw==
Message-ID: <4537D6E8.8020501@google.com>
Date: Thu, 19 Oct 2006 12:50:00 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Paul Jackson <pj@sgi.com>, akpm@osdl.org, menage@google.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, dino@in.ibm.com,
       rohitseth@google.com, holt@sgi.com, dipankar@in.ibm.com,
       suresh.b.siddha@intel.com
Subject: Re: [RFC] cpuset: remove sched domain hooks from cpusets
References: <20061019092358.17547.51425.sendpatchset@sam.engr.sgi.com>	<4537527B.5050401@yahoo.com.au> <20061019120358.6d302ae9.pj@sgi.com> <4537D056.9080108@yahoo.com.au>
In-Reply-To: <4537D056.9080108@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I don't know of anyone else using cpusets, but I'd be interested to know.

We (Google) are planning to use it to do some partitioning, albeit on
much smaller machines. I'd really like to NOT use cpus_allowed from
previous experience - if we can get it to to partition using separated
sched domains, that would be much better.

 From my dim recollections of previous discussions when cpusets was
added in the first place, we asked for exactly the same thing then.
I think some of the problem came from the fact that "exclusive"
to cpusets doesn't actually mean exclusive at all, and they're
shared in some fashion. Perhaps that issue is cleared up now?
/me crosses all fingers and toes and prays really hard.

M.
