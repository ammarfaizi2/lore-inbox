Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965036AbVLVCgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbVLVCgn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 21:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbVLVCgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 21:36:43 -0500
Received: from smtp109.plus.mail.mud.yahoo.com ([68.142.206.242]:50615 "HELO
	smtp109.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965036AbVLVCgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 21:36:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=vhogkk7/qXo5izHIHpzfwVSZRbHwuYDjCq1keUQP71IgqC62H0XzZqVLo8p0krtRC1Lt8EocEYBhBN2NF1nbTahD7an3vpJv9BhJRgHWu/7AAEJlnmsvfVdFI1GtbpH4/V4eX1zbqBKZ5aXuLA11ILK4rxe3lxriu78o9WO8CTI=  ;
Message-ID: <43AA1134.7090704@yahoo.com.au>
Date: Thu, 22 Dec 2005 13:36:36 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jes Sorensen <jes@trained-monkey.org>
CC: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 0/8] mutex subsystem, ANNOUNCE
References: <20051221155411.GA7243@elte.hu> <yq0irtiuxvv.fsf@jaguar.mkp.net>
In-Reply-To: <yq0irtiuxvv.fsf@jaguar.mkp.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen wrote:
>>>>>>"Ingo" == Ingo Molnar <mingo@elte.hu> writes:
> 
> 
> Ingo> this is the latest version of the mutex subsystem
> Ingo> patch-queue. It consists of the following patches:
> 
> [snip]
> 
> Ingo> the patches are against Linus' latest tree, and were tested on
> Ingo> i386, x86_64 and ia64. [the tests were also done in
> Ingo> DEBUG_MUTEX_FULL mode, to make sure the code works
> Ingo> fine. MUTEX_FULL support is not included in this patchqueue].
> 
> Hi,
> 
> I have been working with Ingo on porting this to ehe ia64 and run a
> bunch of benchmarks using the DEBUG_MUTEX_FULL settings to see how it
> behaves on various sized systems (8, 24 and 60 CPUs). In general I am
> seeing speedups of roughly a factor 4 on XFS and 2.4 on TMPFS.
> 
> Below you will find the results. It's basically the same kernel
> version with and without the mutex patch running in DEBUG_MUTEX_FULL
> mode without debugging enabled. No other config options were changed.
> 
> I won't rule out any pilot errors, but at least it gives an idea about
> the change in performance for a specific workload on different sized
> boxes.
> 

It would be nice to first do a run with a fair implementation of
mutexes.

The improvements are definitely large enough that you cannot dismiss
the unfair implementation... I wonder if you can record a maximum
cost per op? That would be more interesting than either average or
standard deviation.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
