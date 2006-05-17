Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWEQDZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWEQDZJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 23:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWEQDZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 23:25:09 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:63839 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751196AbWEQDZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 23:25:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=b9cNblgs9iH4IOIVc5HjlKg782mYQlHWCe2s1DgKWhVb+Ap0d5QfhImy8zir8YWzjmw15D5l1wsYKMTuEzdG6JxqO6pH6AdCKXx3fKbDLKlKPghXpBDDISgXhjtA7HHhuw2mwTrQc+SQmObGNmStb4gBhNiMEs7vLSn1hSTR0KQ=  ;
Message-ID: <446A978C.3000800@yahoo.com.au>
Date: Wed, 17 May 2006 13:25:00 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
CC: Valerie Henson <val_henson@linux.intel.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Blaisorblade <blaisorblade@yahoo.it>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Linux Memory Management <linux-mm@kvack.org>,
       Val Henson <val.henson@intel.com>
Subject: Re: [patch 00/14] remap_file_pages protection support
References: <20060430172953.409399000@zion.home.lan> <4456D5ED.2040202@yahoo.com.au> <200605030225.54598.blaisorblade@yahoo.it> <445CC949.7050900@redhat.com> <445D75EB.5030909@yahoo.com.au> <4465E981.60302@yahoo.com.au> <20060513181945.GC9612@goober> <4469D3F8.8020305@yahoo.com.au> <20060516135135.GA28995@rhlx01.fht-esslingen.de> <20060516163111.GK9612@goober> <20060516164743.GA23893@rhlx01.fht-esslingen.de>
In-Reply-To: <20060516164743.GA23893@rhlx01.fht-esslingen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Mohr wrote:

>Hi,
>
>On Tue, May 16, 2006 at 09:31:12AM -0700, Valerie Henson wrote:
>
>>On Tue, May 16, 2006 at 03:51:35PM +0200, Andreas Mohr wrote:
>>
>>>I cannot offer much other than some random confirmation that from my own
>>>oprofiling, whatever I did (often running a load test script consisting of
>>>launching 30 big apps at the same time), find_vma basically always showed up
>>>very prominently in the list of vmlinux-based code (always ranking within the
>>>top 4 or 5 kernel hotspots, such as timer interrupts, ACPI idle I/O etc.pp.).
>>>call-tracing showed it originating from mmap syscalls etc., and AFAIR quite
>>>some find_vma activity from oprofile itself.
>>>
>>This is important: Which kernel?
>>
>
>I had some traces still showing find_vma prominently during a profiling run
>just yesterday, with a very fresh 2.6.17-rc4-ck1 (IOW, basically 2.6.17-rc4).
>I added some cache prefetching in the list traversal a while ago, and IIRC
>that improved profiling times there, but cache prefetching is very often
>a bandaid in search for a real solution: a better data-handling algorithm.
>

If you want to try out the patch and see what it does for you, that would be
interesting. I'll repost a slightly cleaned up version in a couple of hours.

Nick
--

Send instant messages to your online friends http://au.messenger.yahoo.com 
