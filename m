Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264725AbUEJOqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264725AbUEJOqJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 10:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264718AbUEJOpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 10:45:55 -0400
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:38543 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264722AbUEJOna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 10:43:30 -0400
Message-ID: <409F9510.9050001@yahoo.com.au>
Date: Tue, 11 May 2004 00:43:28 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Cache queue_congestion_on/off_threshold
References: <20040507093921.GD21109@suse.de> <200405072200.i47M0AF00868@unix-os.sc.intel.com> <20040510143024.GF14403@suse.de>
In-Reply-To: <20040510143024.GF14403@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Fri, May 07 2004, Chen, Kenneth W wrote:
> 
>>>>>>Jens Axboe wrote on Friday, May 07, 2004 2:39 AM
>>>
>>>On Thu, May 06 2004, Chen, Kenneth W wrote:
>>>
>>>>(3) can we allocate request structure up front in __make_request?
>>>>    For I/O that cannot be merged, the elevator code executes twice
>>>>    in __make_request.
>>>>
>>>
>>>Actually, with the good working batching we might get away with killing
>>>freereq completely. Have you tested that (if not, could you?)
>>
>>Sorry, I'm clueless on "good working batching".  If you could please give
>>me some pointers, I will definitely test it.
> 
> 
> Something like this.
> 

While we're doing that can we drop the GFP_ATOMIC allocation
completely?
