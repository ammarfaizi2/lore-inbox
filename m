Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751869AbWCVA21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869AbWCVA21 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 19:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbWCVA20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 19:28:26 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:19575 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751869AbWCVA20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 19:28:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=HmUOT9hJkJxIPgd8h5zquevBWyqB/f3iHQ8E29JBlx8ZLvoGPFVYM03KDvRApgJCIMjazF4GAh3aEXOD0Y7e1HaQbIAlm1dA4s5F+zf86RF2GWn78TozZMaS2mbhrf1NWKQQmCIerjhyZ4PpaafqAqWQ2l9hDP07SI6nA0Q/egU=  ;
Message-ID: <44209A26.3040102@yahoo.com.au>
Date: Wed, 22 Mar 2006 11:28:22 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Stone Wang <pwstone@gmail.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: PATCH][1/8] 2.6.15 mlock: make_pages_wired/unwired
References: <bc56f2f0603200536scb87a8ck@mail.gmail.com>	 <441FEFB4.6050700@yahoo.com.au> <bc56f2f0603210803l28145c7dj@mail.gmail.com>
In-Reply-To: <bc56f2f0603210803l28145c7dj@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stone Wang wrote:
> We dont account HugeTLB pages for:
> 
> 1. HugeTLB pages themselves are not reclaimable.
> 
> 2. If we count HugeTLB pages in "Wired",then we would have no mind
>    how many of the "Wired" are HugeTLB pages, and how many are
> normal-size pages.
>    Thus, hard to get a clear map of physical memory use,for example:
>      how many pages are reclaimable?
>    If we must count HugeTLB pages,more fields should be added to
> "/proc/meminfo",
>    for exmaple: "Wired HugeTLB:", "Wired Normal:".
> 

Then why do you wire them at all? Your unwire function does not appear
to be able to unwire them.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
