Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbVKPTGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbVKPTGY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 14:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbVKPTGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 14:06:24 -0500
Received: from web34111.mail.mud.yahoo.com ([66.163.178.109]:58996 "HELO
	web34111.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751474AbVKPTGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 14:06:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=R12jYt+Cm8kntE9MWsBjfpTLumEXqgMV8NLzNO0FjCNwW7scNg7yDQ2Rsa7Ji2FA/NFPq+kmD/mUCS/IO2rMJ9gQGBzmG3isAKLp59yBsycl+RhexTFn77TI8Uw3VH6fZb0foXeoPe5g+1FobGkgHqxzIjm1kbSPRWG3zJQaXWQ=  ;
Message-ID: <20051116190622.76583.qmail@web34111.mail.mud.yahoo.com>
Date: Wed, 16 Nov 2005 11:06:22 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: mmap over nfs leads to excessive system load
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1132163057.8811.15.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> OK, please back out the patch that I sent you, and try this one instead.

With jumbo frames, the profile is even happier:
(throughput is a little higher and CPU usage is a little lower too)

samples  %        symbol name
74463    12.1129  skb_copy_bits
30351     4.9372  __lookup_tag
24520     3.9887  _spin_lock
20353     3.3108  _spin_lock_irqsave
19306     3.1405  __copy_from_user_ll
15393     2.5040  __copy_user_zeroing_intel
10014     1.6290  isolate_lru_pages
9002      1.4644  sub_preempt_count
7997      1.3009  debug_smp_processor_id
7691      1.2511  schedule
6999      1.1385  shrink_list
6699      1.0897  tcp_sendmsg
6669      1.0848  radix_tree_delete
6532      1.0626  _write_lock_irqsave
6413      1.0432  __mod_page_state
6170      1.0037  acpi_safe_halt

Again... this is excellent.
So will this make 2.6.16? or can this be called a bug fix for 2.6.15?

-Kenny



		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
