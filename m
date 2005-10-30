Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932811AbVJ3Dvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932811AbVJ3Dvs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 23:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932813AbVJ3Dvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 23:51:47 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:31068 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932811AbVJ3Dvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 23:51:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=bORpModnqFtjlv5hCp1ugQ9YtN1BK7SAwCHGVVeIg2PyyhVbxi2Wp0HvODHjaSlE5/kMSM8OqT99qjjxngmm6IdxZdbX5kyWPt+mtMdQWbZxNNHWVSvWZjiQRqzqAKnopk3IIauiyP74h9n+qJhopegDwR/kNDD/ZbGlDspJyOU=  ;
Message-ID: <436443A0.1000508@yahoo.com.au>
Date: Sun, 30 Oct 2005 14:53:04 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: rohit.seth@intel.com, akpm@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Clean up of __alloc_pages
References: <20051028183326.A28611@unix-os.sc.intel.com>	<20051029184728.100e3058.pj@sgi.com>	<4364296E.1080905@yahoo.com.au>	<20051029191946.1832adaf.pj@sgi.com>	<436430BA.4010606@yahoo.com.au> <20051029200634.778a57d6.pj@sgi.com>
In-Reply-To: <20051029200634.778a57d6.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Nick, replying to pj:
> 

>>Hmm, where is the other callsite? 
> 
> 
> The other callsite is mm/swap_prefetch.c:prefetch_get_page(), from Con
> Kolivas's mm-implement-swap-prefetching.patch patch in *-mm, dated
> about six days ago.
> 

OK, I haven't looked at those patches really. I think some of that
stuff should go into page_alloc.c and I'd prefer to keep
buffered_rmqueue static.

But no matter for the cleanup patch at hand: let's leave the inline
off, and the compiler will do the right thing if it is static and
there is just a single call site (and I think newer gccs will do
function versioning if there are constant arguments).

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
