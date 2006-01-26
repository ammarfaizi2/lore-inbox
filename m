Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWAZJBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWAZJBX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 04:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWAZJBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 04:01:23 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:61868 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932134AbWAZJBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 04:01:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Ge+eovh1zMwB3mrFNnSXn+awUh+NO9WYXnxffagaWLXiZ3thAv6mASqFuAdLH7yhir4DDBqaQlXT0eBAwtRilj7vBhwgkCpkzFfqG0Q2m4pGYk7W8SmNNdE+JkbbcTBRpew1g9poaoRVVxgiOxa5KGwal8Hx+PmBbFGct1XwfOo=  ;
Message-ID: <43D88FDF.6040606@yahoo.com.au>
Date: Thu, 26 Jan 2006 20:01:19 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@aitel.hist.no>
CC: davids@webmaster.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hancockr@shaw.ca
Subject: Re: sched_yield() makes OpenLDAP slow
References: <MDEHLPKNGKAHNMBLJOLKAEJBJKAB.davids@webmaster.com> <43D8889E.3020907@aitel.hist.no>
In-Reply-To: <43D8889E.3020907@aitel.hist.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> David Schwartz wrote:

>> nothing says that it can't call pthread_mutex_lock and re-acquire the 
>> mutex
>> before any other thread gets around to getting it.
>>  
>>
> Wrong.
> The spec says that the mutex must be given to a waiter (if any) at the
> moment of release.

Repeating myself here...

To me it says that the scheduling policy decides at the moment of release.
What if the scheduling policy decides *right then* to give the mutex to
the next running thread that tries to aquire it?

That would be the logical way for a scheduling policy to decide the next
owner of the mutex.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
