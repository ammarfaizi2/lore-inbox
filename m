Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbWDRT5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWDRT5c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 15:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWDRT5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 15:57:32 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:57496 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932292AbWDRT5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 15:57:31 -0400
Date: Tue, 18 Apr 2006 14:56:45 -0500
From: Jack Steiner <steiner@sgi.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: davej@codemonkey.org.uk, tony.luck@intel.com, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, bob.picco@hp.com, ak@suse.de,
       linux-mm@kvack.org
Subject: Re: [PATCH 0/7] [RFC] Sizing zones and holes in an architecture independent manner V3
Message-ID: <20060418195644.GA30911@sgi.com>
References: <20060418130015.28928.10163.sendpatchset@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060418130015.28928.10163.sendpatchset@skynet>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2006 at 02:00:15PM +0100, Mel Gorman wrote:
> This is V3 of the patchset to size zones and memory holes in an
...



FYI, I applied the patches to a recent kernel & booted on a large
SGI system. No problem aside from what I assume is a very large number
of debug messages. 


------
Linux version 2.6.17-tony (steiner@attica) (gcc version 4.1.0 (SUSE Linux)) #5 SMP PREEMPT Tue Apr 18 14:01:54 CDT 2006
EFI v1.10 by INTEL: SALsystab=0x6002c51df0 ACPI 2.0=0x6002c51ee0
Number of logical nodes in system = 512
Number of memory chunks in system = 512
SAL 2.9: SGI SN2 version 1.10
SAL Platform features: ITC_Drift
SAL: AP wakeup using external interrupt vector 0x12
No logical to physical processor mapping available
ACPI: Local APIC address c0000000fee00000
ACPI: Error parsing MADT - no IOSAPIC entries
register_intr: No IOSAPIC for GSI 52
512 CPUs available, 512 CPUs total
MCA related initialization done
SGI SAL version 1.10
add_active_range(0, 25168900, 25235456): New
add_active_range(0, 25236375, 25419776): New
add_active_range(0, 27262976, 27516927): New
add_active_range(0, 29360128, 29614080): New
add_active_range(1, 92277760, 92528640): New
...
add_active_range(511, 34322242024, 34322242047): New
add_active_range(511, 34322243072, 34322243417): New
add_active_range(511, 34322243432, 34322243460): New
add_active_range(511, 34322243488, 34322243500): New
Virtual mem_map starts at 0xa0007e407d270000
free_area_init_nodes(68719476736, 68719476736, 34322243584, 34322243584)
free_area_init_nodes(): find_min_pfn = 25168900
Dumping sorted node map
entry 0: 0  25168900 -> 25235456
entry 1: 0  25236375 -> 25419776
entry 2: 0  27262976 -> 27516927
entry 3: 0  29360128 -> 29614080
entry 4: 1  92277760 -> 92528640
entry 5: 1  94371840 -> 94625792
entry 6: 1  96468992 -> 96722944
...
entry 1536: 511	 34321989632 -> 34322242001
entry 1537: 511	 34322242016 -> 34322242022
entry 1538: 511	 34322242024 -> 34322242047
entry 1539: 511	 34322243072 -> 34322243417
entry 1540: 511	 34322243432 -> 34322243460
entry 1541: 511	 34322243488 -> 34322243500
__absent_pages_in_range(0, 25168900, 68719476736) = 3687320
__absent_pages_in_range(0, 68719476736, 68719476736) = 0
__absent_pages_in_range(0, 68719476736, 34322243584) = 0
__absent_pages_in_range(0, 34322243584, 34322243584) = 0
__absent_pages_in_range(0, 25168900, 68719476736) = 3687320
...
__absent_pages_in_range(511, 34322243584, 34322243584) = 0
__absent_pages_in_range(511, 25168900, 68719476736) = 3687485
__absent_pages_in_range(511, 68719476736, 68719476736) = 0
__absent_pages_in_range(511, 68719476736, 34322243584) = 0
__absent_pages_in_range(511, 34322243584, 34322243584) = 0
Built 512 zonelists
Kernel command line: BOOT_IMAGE=net0:jfs/tonys	ro hashdist=1 dhash_entries=2097152 ihash_entries=2097152 rhash_entries=2097152 thash_entries=2097152 console=ttySG0,38400n8 kdb=on noprobe root=/dev/sda5
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour dummy device 80x25
Memory: 4639378784k/4655642784k available (7021k code, 16279040k reserved, 4361k data, 736k init)
	(essentially the same numbers as with a kernel w/o the patches)
McKinley Errata 9 workaround not needed; disabling it
