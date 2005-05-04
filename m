Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbVEDAJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbVEDAJR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 20:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVEDAJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 20:09:12 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:61556 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261940AbVEDAIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 20:08:53 -0400
Message-ID: <42781286.7080801@yahoo.com.au>
Date: Wed, 04 May 2005 10:08:38 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Dobson <colpatch@us.ibm.com>
CC: dino@in.ibm.com, Paul Jackson <pj@sgi.com>,
       Simon Derr <Simon.Derr@bull.net>, lkml <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC PATCH] Dynamic sched domains (v0.5)
References: <20050501190947.GA5204@in.ibm.com> <4277F52B.8040908@us.ibm.com>
In-Reply-To: <4277F52B.8040908@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson wrote:
> Dinakar Guniguntala wrote:
> 
>>+	lock_cpu_hotplug();
>>+	rebuild_sched_domains(span1, span2);
>>+	unlock_cpu_hotplug();
>>+}
> 
> 
> Nitpicky, but span1 and span2 could do with better names.
> 

As could rebuild_sched_domains while we're at it.

partition_disjoint_sched_domains(partition1, partition2);
?

Dunno. That isn't really great, but maybe better? Pretty
long, but it'll only ever be called in one or two places.

-- 
SUSE Labs, Novell Inc.

