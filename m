Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbWD0GXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbWD0GXN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 02:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbWD0GXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 02:23:13 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:33660 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964959AbWD0GXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 02:23:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=XrCqdidoRAi2Q6h2+Z89gYVzmzYJNJ6SH1mK/WZ5CUrFxqHRIMHs3obluEoDI9qTLH4aVFw1uwh8MinRNZqEDT+7wXsrJgoOHxx7u3ffkj9Cxmfg2dFvj4k1T3aH7OjBda9kRGnXL9Z7RtPxd5tL9B1sD1O788H4bwAeWTnhvlE=  ;
Message-ID: <44506023.4060609@yahoo.com.au>
Date: Thu, 27 Apr 2006 16:09:39 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Magnus Damm <magnus.damm@gmail.com>
CC: Dave McCracken <dmccr@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       Hugh Dickins <hugh@veritas.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC/PATCH] Shared Page Tables [1/2]
References: <1144685591.570.36.camel@wildcat.int.mccr.org>	 <1144695296.31255.16.camel@localhost.localdomain>	 <C7A8E6F316A73810A5FF466E@10.1.1.4> <aec7e5c30604262049v3ae18915le415ee33b2f80fc4@mail.gmail.com>
In-Reply-To: <aec7e5c30604262049v3ae18915le415ee33b2f80fc4@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Damm wrote:
> On 4/11/06, Dave McCracken <dmccr@us.ibm.com> wrote:

>>No one actually uses any of the pud_page and pgd_page macros (other than
>>one reference in the same include file).  After some discussion on the list
>>the last time I posted the patches, we agreed that changing pud_page and
>>pgd_page to be consistent with pmd_page is the best solution.  We also
>>agreed that I should go ahead and propagate that change across all
>>architectures even though not all of them currently support shared page
>>tables.  This patch is the result of that work.
> 
> 
> What is the merge status of this patch?
> 
> I've written some generic page table creation code for kexec, but the
> fact that pud_page() returns struct page * on i386 but unsigned long
> on other architectures makes it hard to write clean generic code.
> 
> Any merge objections, or was this patch simply overlooked?

Don't think there would be any objections. If someone sends
along a broken out patch, I'm sure it could get into 2.6.18.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
