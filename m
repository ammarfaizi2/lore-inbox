Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVFOATA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVFOATA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 20:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVFOAS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 20:18:59 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:58703 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261440AbVFOASl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 20:18:41 -0400
Message-ID: <42AF73DA.6030601@yahoo.com.au>
Date: Wed, 15 Jun 2005 10:18:34 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: christoph <christoph@scalex86.org>, ak@suse.de,
       linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: Re: [PATCH] Move some variables into the "most_readonly" section??
References: <Pine.LNX.4.62.0506071253020.2850@ScMPusgw>	<20050608131839.GP23831@wotan.suse.de>	<Pine.LNX.4.62.0506141551350.3676@ScMPusgw>	<20050614162354.6aabe57e.akpm@osdl.org>	<Pine.LNX.4.62.0506141644160.4099@ScMPusgw> <20050614165818.6f83fa6c.akpm@osdl.org>
In-Reply-To: <20050614165818.6f83fa6c.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> christoph <christoph@scalex86.org> wrote:
> 
>>On Tue, 14 Jun 2005, Andrew Morton wrote:
>>
>>
>>>I think readmostliness and alignment are mostly-unrelated concepts and
>>>should have separate tag thingies.  IOW,
>>>__cacheline_aligned_mostly_readonly goes away and to handle things like the
>>>cpu maps we do:
>>
>>Yup that makes the whole thing much more sane. Can we specify multiple 
>>attributes to a variable?
> 
> 
> I suppose so.
> 
> Compiling this:
> 
> int x   __attribute__((__aligned__(32)))
>         __attribute__((__section__(".data.mostly_readonly")));
> 

Can I just throw in something unrelated and not very constructive
and ask that we call it 'read_mostly' instead of mostly_readonly?

mostly_readonly kind of says to me that most items in the section
are read only, read_mostly says all the items are mostly only read.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
