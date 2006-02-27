Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWB0M2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWB0M2W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 07:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbWB0M2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 07:28:22 -0500
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:28849 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751232AbWB0M2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 07:28:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=D0++mDswJgECGX7mN5CQcGwSAV3aBXprz0Yy+t+0CAHPDq3xA7Wnb36ft+vc9b/xQXiuZcYwSXuZbQ1Ra1yPMQHLCvmvaFPaDpLW/yUKctynyeoUE3U9M4gmJv00+wf6SaM7pgX7DuSUNMA1e6ra8uJVVFFg93HBfuF11Udx28M=  ;
Message-ID: <4402F065.3010303@yahoo.com.au>
Date: Mon, 27 Feb 2006 23:28:21 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Patch 2/7] Add sysctl for schedstats
References: <1141026996.5785.38.camel@elinux04.optonline.net> <1141027367.5785.42.camel@elinux04.optonline.net> <1141027923.5785.50.camel@elinux04.optonline.net> <4402C3BB.7010705@yahoo.com.au> <4402C954.2080606@watson.ibm.com>
In-Reply-To: <4402C954.2080606@watson.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar wrote:
> Nick Piggin wrote:

>>
>> And clearing this at all is not really needed for the schedstats 
>> interface.
>> You have a timestamp and a set of accumulated values, so it is easy to 
>> work
>> out deltas. So do you need this?
> 
> 
> Not clearing the stats will mean userspace has to distinguish between 
> the tasks
> that are hanging around from before the last turn off, and the ones 
> created after
> wards. Any delta taken across an interval where schedstats was turned 
> off will
> give the impression a task was sleeping during the interval (and hence 
> show it had
> a lesser average wait time than it might actually have experienced).

Presumably a delta taken acrsoss an interval where schedstats
was turned off would be rather inaccurate, no matter what.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
