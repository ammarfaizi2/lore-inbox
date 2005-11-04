Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030504AbVKDBZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030504AbVKDBZd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 20:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030570AbVKDBZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 20:25:33 -0500
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:55926 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030504AbVKDBZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 20:25:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=g80W0+XQXHVYTMnPjVpfNXhAiJQ4Ff6exi+1uhqsMbRZujgUY96ekdqp2uT2QR1usVpKQa1QI/tnxnU4bxJRLtgX8htG1+cmJAy3cR0D1aMcRRdq5mEXeqMPNVhtw6/0yNCLmNYvAKS58v1uOa2/087Mwsn44GpmMCM7lass58A=  ;
Message-ID: <436AB902.3000309@yahoo.com.au>
Date: Fri, 04 Nov 2005 12:27:30 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@mbligh.org>
CC: Andy Nelson <andy@thermo.lanl.gov>, torvalds@osdl.org, akpm@osdl.org,
       arjan@infradead.org, arjanv@infradead.org, haveblue@us.ibm.com,
       kravetz@us.ibm.com, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, mel@csn.ul.ie,
       mingo@elte.hu
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
References: <20051104010021.4180A184531@thermo.lanl.gov> <58210000.1131067015@flay>
In-Reply-To: <58210000.1131067015@flay>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:

> 
> To provide a slightly shorter version ... we had one customer running
> similarly large number crunching things in Fortran. Their app ran 25%
> faster with large pages (not a typo). Because they ran a variety of
> jobs in batch mode, they need large pages sometimes, and small pages
> at others - hence they need to dynamically resize the pool. 
> 
> That's the sort of thing we were trying to fix with dynamically sized
> hugepage pools. It does make a huge difference to real-world customers.
> 

Aren't HPC users very easy? In fact, probably the easiest because they
generally not very kernel intensive (apart from perhaps some batches of
IO at the beginning and end of the jobs).

A reclaimable zone should provide exactly what they need. I assume the
sysadmin can give some reasonable upper and lower estimates of the
memory requirements.

They don't need to dynamically resize the pool because it is all being
allocated to pagecache anyway, so all jobs are satisfied from the
reclaimable zone.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
