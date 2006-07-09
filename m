Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbWGIOij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbWGIOij (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 10:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWGIOij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 10:38:39 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:28818 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932464AbWGIOii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 10:38:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=F7OgebyJrzyDyJHG8RDnH7/l5D3nmSklMaoWWCJXkV57aTJ9zhyF9Wif2krM99UsZ5zXi5mMR/lRssACX9y1qn/qnDt2idv+kVo/vWkViUclPL8hqCPekD0Nx3xZk7qR59xIUBnHpp0RuWl4HQuhbEwBQb4HAD0SD9JBdnl9tCw=  ;
Message-ID: <44B0FCC9.8010508@yahoo.com.au>
Date: Sun, 09 Jul 2006 22:55:37 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Fabio Comolli <fabio.comolli@gmail.com>, mingo@redhat.com,
       linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
       Dave Jones <davej@codemonkey.org.uk>
Subject: Re: 2.6.18-rc1-mm1
References: <20060709021106.9310d4d1.akpm@osdl.org>	<b637ec0b0607090326w5a1702d1l9b7619fba7e4bc41@mail.gmail.com> <20060709034509.c4652caa.akpm@osdl.org> <44B0F87F.70503@yahoo.com.au>
In-Reply-To: <44B0F87F.70503@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Andrew Morton wrote:

>>
>> - If a piece of kernel code is dealing with per-cpu data and cannot run
>>   atomically then it should have its own cpu hotplug handlers anyway.  It
>>   is up to that code (ie: cpufreq) to provide its own locking against its
>>   own CPU hotplug callback.
> 
> 
> This still does not solve this cpufreq problem where it is trying to
> take the same lock twice down the same call path. Whether it is the
> lock_cpu_hotplug mutex or another one, the code must be just busted.
> 

Err...

s/twice down the same call path/inverted with another lock

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
