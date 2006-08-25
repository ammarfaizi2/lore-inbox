Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWHYI0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWHYI0s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 04:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWHYI0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 04:26:48 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:35680 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751320AbWHYI0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 04:26:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=EAgphnvdgM1hx/Yy2P9w/vUBHvc9dibmnkvTnlfLeyy0P/p/Fpav0SDSczVlYZaU2XqQJ/L2z/2qioGm4yT+aVEH+gtpsykI9me0+IlvwdTlkhWtrA8ej20KSCt7m/3NVEKuopciux2RgJEM6I9it9P3PPCmFRI+uk5UAMQtAGs=  ;
Message-ID: <44EEB425.8060707@yahoo.com.au>
Date: Fri, 25 Aug 2006 18:26:13 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@linux.intel.com>
CC: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org,
       len.brown@intel.com, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFC] maximum latency tracking infrastructure
References: <1156441295.3014.75.camel@laptopd505.fenrus.org> <200608241408.03853.jbarnes@virtuousgeek.org> <44EE1801.3060805@linux.intel.com> <44EE829C.10606@yahoo.com.au> <44EEAD8D.6010801@linux.intel.com>
In-Reply-To: <44EEAD8D.6010801@linux.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> Nick Piggin wrote:

>> Surely you would call set_acceptable_latency() *before* running such
>> operation that requires the given latency? And that 
>> set_acceptable_latency
>> would block the caller until all CPUs are set to wake within this 
>> latency.
>>
>> That would be the API semantics I would expect, anyway.
> 
> 
> but that means it blocks, and thus can't be used in irq context

Is that a problem? I guess it could be, but you don't want to
give a false sense of security either. Having an explicit _nosync
version may make that clear?

> 
> (the usage model I imagine happens most is a set_acceptable_latency() 
> which can block during device init,
> with either no or a very course limit, and a 
> modify_acceptable_latency(), which cannot block, from irq context or
> device open)

OK. You'd know more about that than I ;)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
