Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbVCQMhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbVCQMhp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 07:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVCQMhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 07:37:45 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:52101 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262069AbVCQMhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 07:37:31 -0500
Message-ID: <42397A04.2060703@yahoo.com.au>
Date: Thu, 17 Mar 2005 23:37:24 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
CC: linux-kernel@vger.kernel.org, garloff@suse.de, ak@suse.de
Subject: Re: 2.6.11 vs 2.6.10 slowdown on i686
References: <E1DBtvc-0002c4-00@mta1.cl.cam.ac.uk>
In-Reply-To: <E1DBtvc-0002c4-00@mta1.cl.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Pratt wrote:
> Folks, 
> 
> When we upgraded arch xen/x86 to kernel 2.6.11, we noticed a slowdown
> on a number of micro-benchmarks. In order to investigate, I built
> native (non Xen) i686 uniprocessor kernels for 2.6.10 and 2.6.11 with
> the same configuration and ran lmbench-3.0-a3 on them. The test
> machine was a 2.4GHz Xeon box, gcc 3.3.3 (FC3 default) was used to
> compile the kernels, NOHIGHMEM=y (2-level only).
> 
> On the i686 fork and exec benchmarks I found that there's been a
> significant slowdown between 2.6.10 and 2.6.11. Some of the other
> numbers a bit ugly too (see attached).
> 
> fork: 166 -> 235  (40% slowdown)
> exec: 857 -> 1003 (17% slowdown)
> 
> I'm guessing this is down to the 4 level pagetables. This is rather a
> surprise as I thought the compiler would optimise most of these
> changes away. Apparently not. 
> 

There are some changes in the current -bk tree (which are a
bit in-flux at the moment) which introduce some optimisations.

They should bring 2-level performance close to par with 2.6.10.
If not, complain again :)

Thanks,
Nick

