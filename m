Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267583AbSLSJV0>; Thu, 19 Dec 2002 04:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267589AbSLSJV0>; Thu, 19 Dec 2002 04:21:26 -0500
Received: from holomorphy.com ([66.224.33.161]:23232 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267583AbSLSJVY>;
	Thu, 19 Dec 2002 04:21:24 -0500
Date: Thu, 19 Dec 2002 01:28:53 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: 2.5.52-mm2
Message-ID: <20021219092853.GK1922@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org
References: <3E015ECE.9E3BD19@digeo.com> <20021219085426.GJ1922@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021219085426.GJ1922@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2002 at 09:53:18PM -0800, Andrew Morton wrote:
>> url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.52/2.5.52-mm2/

On Thu, Dec 19, 2002 at 12:54:26AM -0800, William Lee Irwin III wrote:
> Kernel compile on ramfs, shpte off, overcommit on (probably more like a
> stress test for shpte):

With shpte on:

c0135790 123025   0.33807     nr_free_pages
c015021c 134621   0.369936    __fput
c0119974 144602   0.397364    kmap_atomic
c01b23d0 146899   0.403676    __copy_user_intel
c014c050 159002   0.436935    pte_unshare
c0122c28 171802   0.472109    current_kernel_time
c01fbd9c 172897   0.475118    sync_buffer
c0116870 187066   0.514054    pfn_to_nid
c0115390 199497   0.548214    smp_apic_timer_interrupt
c013f820 236468   0.64981     do_no_page
c0116918 260314   0.715338    x86_profile_hook
c016566c 274151   0.753362    d_lookup
c01b2578 280625   0.771152    __copy_from_user
c013212c 323752   0.889665    find_get_page
c0140800 338288   0.929609    vm_enough_memory
c013fbd0 355384   0.976589    handle_mm_fault
c014ff90 358839   0.986083    get_empty_filp
c011a710 363642   0.999282    scheduler_tick
c011a258 507320   1.39411     load_balance
c01505a9 664873   1.82706     .text.lock.file_table
c01b2510 834467   2.2931      __copy_to_user
c0135928 1051119  2.88846     __get_page_state
c013f400 1062731  2.92037     do_anonymous_page
c0143fa0 1273498  3.49955     page_add_rmap
c014419c 1386659  3.81051     page_remove_rmap
c0106f38 21099307 57.9805     poll_idle


Bill
