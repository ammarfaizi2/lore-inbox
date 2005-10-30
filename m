Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932785AbVJ3Ceq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932785AbVJ3Ceq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 22:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932793AbVJ3Ceq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 22:34:46 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:1448 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932785AbVJ3Cep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 22:34:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=jtJ0M3kATeicETGuNbDVO4anoEe6dA7RN+NzxxtkFTdkfVVF0wEbEaatQQPg4Otj+29J0gFyok9+QegUzAGK3qVIHx8v4gDud+Gg8ghkqN5NxcvI356wsjq++dRTh9Q2imOowGctGBeF8FuqACxe9KpxLlRsdzU+40go2ywoE8A=  ;
Message-ID: <43643195.9040600@yahoo.com.au>
Date: Sun, 30 Oct 2005 13:36:05 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: rohit.seth@intel.com, akpm@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Clean up of __alloc_pages
References: <20051028183326.A28611@unix-os.sc.intel.com>	<20051029184728.100e3058.pj@sgi.com>	<4364296E.1080905@yahoo.com.au> <20051029192611.79b9c5e7.pj@sgi.com>
In-Reply-To: <20051029192611.79b9c5e7.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
>>> 2) The can_try_harder flag values were driving me nuts.
>>
>>Please instead use a second argument 'gfp_high', which will nicely
>>match zone_watermark_ok, and use that consistently when converting
>>__alloc_pages code to use get_page_from_freelist. Ie. keep current
>>behaviour.
> 
> 
> Well ... I still don't understand what you're suggesting, so I
> guess I will have to wait for an actual patch incorporating it.
> 

See how can_try_harder and gfp_high is used currently. They
are simple boolean values and are easily derived from parameters
passed into __alloc_pages.

> Are you also objecting to converting "can_try_harder" to an
> enum, and getting the values in order of desperation?  If so,
> I don't why you object.
> 

Because then to get current behaviour you would have to add
branches to get the correct enum value.

> And there is still the issue that I don't think cpuset constraints
> should be applied in the last attempt before oom_killing for
> GFP_ATOMIC requests.
> 

Sure.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
