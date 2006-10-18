Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161103AbWJRTPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161103AbWJRTPD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 15:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161271AbWJRTPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 15:15:03 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:17341 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161103AbWJRTPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 15:15:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=a0oGTr0SpCMhtrJN5HDvBwgRaIa8qRPTdmmZBic/zeOJPYJMV+ItFVP6jq7XRbP+tmCPiMoh7KZRB6WGQfmpA5uFc1hghZnsfEgKPpcUHKHvICAgrl0CJP9J31wSnIMdOdwWMXCj6erRn/FcxvjuVeefJrse8bF/2zYadBPWXlI=  ;
Message-ID: <45367D32.6090301@yahoo.com.au>
Date: Thu, 19 Oct 2006 05:14:58 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Ingo Molnar <mingo@elte.hu>, Peter Williams <pwil3058@bigpond.net.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] sched_tick with interrupts enabled
References: <Pine.LNX.4.64.0610181001480.28582@schroedinger.engr.sgi.com> <4536629C.4050807@yahoo.com.au> <Pine.LNX.4.64.0610181059570.28750@schroedinger.engr.sgi.com> <45366DF0.6040702@yahoo.com.au> <Pine.LNX.4.64.0610181145250.29163@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0610181145250.29163@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Thu, 19 Oct 2006, Nick Piggin wrote:
> 
> 
>>wake_priority_sleeper should not be called from rebalance_tick. That
>>code was OK where it was before, I think.
> 
> 
> wake_priority_sleeper() is necessary to establish the idle state.

No it isn't. It's just that if it returns nonzero, we know we are not
idle so we needn't test for that again.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
