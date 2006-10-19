Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161339AbWJSGjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161339AbWJSGjZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 02:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161341AbWJSGjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 02:39:25 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:33431 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161339AbWJSGjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 02:39:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=AgKCxdzCipC+juE6pXyZuPPmPEqG3G2R6tuDlt4fpcqGJhueNai7rvsbYs7bBBfm24oACZjGq1hTXV632BCMdZctZ5uaeg8vJcmxzVz3lvSKvSirU6QZrDkfT7VTzJ1BVwZUi+LVay/S5Q/aDZ+KrWAqAXwf7OtT/vPzWbMiKyk=  ;
Message-ID: <45371D96.8060003@yahoo.com.au>
Date: Thu, 19 Oct 2006 16:39:18 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, dino@in.ibm.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       mbligh@google.com, rohitseth@google.com, dipankar@in.ibm.com
Subject: Re: [RFC] Cpuset: explicit dynamic sched domain control flags
References: <20061016230351.19049.29855.sendpatchset@jackhammer.engr.sgi.com>	<20061017114306.A19690@unix-os.sc.intel.com>	<20061017121823.e6f695aa.pj@sgi.com>	<20061017190144.A19901@unix-os.sc.intel.com> <20061018000512.1d13aabd.pj@sgi.com>
In-Reply-To: <20061018000512.1d13aabd.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Suresh wrote:

>>Once the sched domains are partitioned, there is no interaction/scheduling
>>happening between those partitions.
> 
> 
> Ok ...
> 
> Is there anyway to determine, on a running system, what sched domains
> and groups are present?

You don't have to worry about the details of the hierarchy. You just need
to know where the partitions are, and that's easy because you were the one
who set them up in the first place (with the exception of isolcpus, which
at least needs a couple of lines on the sched.c side to make it workable).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
