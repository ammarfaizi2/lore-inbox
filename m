Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272570AbTHKUNr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 16:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272844AbTHKUNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 16:13:47 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:55541 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S272570AbTHKUNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 16:13:45 -0400
Date: Mon, 11 Aug 2003 13:17:04 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test3-mm1
Message-ID: <873510000.1060633024@flay>
In-Reply-To: <20030811113943.47e5fd85.akpm@osdl.org>
References: <20030809203943.3b925a0e.akpm@osdl.org><94490000.1060612530@[10.10.2.4]> <20030811113943.47e5fd85.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Monday, August 11, 2003 11:39:43 -0700 Andrew Morton <akpm@osdl.org> wrote:

> "Martin J. Bligh" <mbligh@aracnet.com> wrote:
>> 
>> Degredation on kernbench is still there:
>> 
>> Kernbench: (make -j N vmlinux, where N = 16 x num_cpus)
>>                               Elapsed      System        User         CPU
>>               2.6.0-test3       45.97      115.83      571.93     1494.50
>>           2.6.0-test3-mm1       46.43      122.78      571.87     1496.00
>> 
>> Quite a bit of extra sys time.
> 
> Increased system is a surprise.  Profiles would be interesting, thanks.
> 

Buggered if I know what Letext is doing there ???

      6577     3.9% total
      1157     0.0% Letext
       937     0.0% direct_strnlen_user
       748   440.0% filp_close
       722    21.2% __copy_from_user_ll
       610     2.6% page_remove_rmap
       492   487.1% file_ra_state_init
       452    12.4% find_get_page
       405     7.6% __copy_to_user_ll
       402    28.6% schedule
       386     0.0% kpmd_ctor
       348     4.4% __d_lookup
       310    16.6% atomic_dec_and_lock
       300   174.4% may_open
       274    16.3% buffered_rmqueue
       225     1.6% do_anonymous_page
       206    30.9% __wake_up
       193    12.3% kmem_cache_free
       124     0.0% direct_strncpy_from_user
       119     6.5% path_lookup
...
      -112  -100.0% strncpy_from_user
      -117    -1.8% page_add_rmap
      -149    -0.3% default_idle
      -161  -100.0% .text.lock.dcache
      -207  -100.0% .text.lock.filemap
      -277   -78.5% dentry_open
      -297   -65.6% do_page_cache_readahead
      -347  -100.0% pgd_ctor
      -375  -100.0% .text.lock.file_table
      -867  -100.0% strnlen_user

