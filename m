Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUKMU76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUKMU76 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 15:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbUKMU6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 15:58:35 -0500
Received: from havoc.gtf.org ([69.28.190.101]:56968 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261169AbUKMUy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 15:54:56 -0500
Date: Sat, 13 Nov 2004 15:54:54 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCHES] 2.6.x misc updates
Message-ID: <20041113205454.GA29806@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


viro was bugging me about the lack of (arg) in nth_page() definition...

Please do a

	bk pull bk://gkernel.bkbits.net/misc-2.6

This will update the following files:

 Documentation/hw_random.txt |   69 --------------------------------------------
 include/linux/mm.h          |    2 -
 2 files changed, 1 insertion(+), 70 deletions(-)

through these ChangeSets:

<jgarzik@pobox.com> (04/11/13 1.2095)
   Parenthize nth_page() macro arg, in linux/mm.h.

<james4765@verizon.net> (04/11/06 1.2026.70.1)
   [PATCH] hw_random: Remove changelog from hw_random.txt
   
   Remove pre-merge changelog from Documentation/hw_random.txt
   
   Signed-off-by: James Nelson <james4765@gmail.com>
   Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

diff -Nru a/Documentation/hw_random.txt b/Documentation/hw_random.txt
--- a/Documentation/hw_random.txt	2004-11-13 15:53:11 -05:00
+++ b/Documentation/hw_random.txt	2004-11-13 15:53:11 -05:00
@@ -67,72 +67,3 @@
 
 	Special thanks to Matt Sottek.  I did the "guts", he
 	did the "brains" and all the testing.
-
-Change history:
-
-	Version 1.0.0:
-	* Merge Intel, AMD, VIA RNG drivers into one.
-	  Further changelog in BitKeeper.
-
-	Version 0.9.8:
-	* Support other i8xx chipsets by adding 82801E detection
-	* 82801DB detection is the same as for 82801CA.
-
-	Version 0.9.7:
-	* Support other i8xx chipsets too (by adding 82801BA(M) and
-	  82801CA(M) detection)
-
-	Version 0.9.6:
-	* Internal driver cleanups, prep for 1.0.0 release.
-
-	Version 0.9.5:
-	* Rip out entropy injection via timer.  It never ever worked,
-	  and a better solution (rngd) is now available.
-
-	Version 0.9.4:
-	* Fix: Remove request_mem_region
-	* Fix: Horrible bugs in FIPS calculation and test execution
-
-	Version 0.9.3:
-	* Clean up rng_read a bit.
-	* Update i810_rng driver Web site URL.
-	* Increase default timer interval to 4 samples per second.
-	* Abort if mem region is not available.
-	* BSS zero-initialization cleanup.
-	* Call misc_register() from rng_init_one.
-	* Fix O_NONBLOCK to occur before we schedule.
-
-	Version 0.9.2:
-	* Simplify open blocking logic
-
-	Version 0.9.1:
-	* Support i815 chipsets too (Matt Sottek)
-	* Fix reference counting when statically compiled (prumpf)
-	* Rewrite rng_dev_read (prumpf)
-	* Make module races less likely (prumpf)
-	* Small miscellaneous bug fixes (prumpf)
-	* Use pci table for PCI id list
-
-	Version 0.9.0:
-	* Don't register a pci_driver, because we are really
-	  using PCI bridge vendor/device ids, and someone
-	  may want to register a driver for the bridge. (bug fix)
-	* Don't let the usage count go negative (bug fix)
-	* Clean up spinlocks (bug fix)
-	* Enable PCI device, if necessary (bug fix)
-	* iounmap on module unload (bug fix)
-	* If RNG chrdev is already in use when open(2) is called,
-	  sleep until it is available.
-	* Remove redundant globals rng_allocated, rng_use_count
-	* Convert numeric globals to unsigned
-	* Module unload cleanup
-
-	Version 0.6.2:
-	* Clean up spinlocks.  Since we don't have any interrupts
-	  to worry about, but we do have a timer to worry about,
-	  we use spin_lock_bh everywhere except the timer function
-	  itself.
-	* Fix module load/unload.
-	* Fix timer function and h/w enable/disable logic
-	* New timer interval sysctl
-	* Clean up sysctl names
diff -Nru a/include/linux/mm.h b/include/linux/mm.h
--- a/include/linux/mm.h	2004-11-13 15:53:11 -05:00
+++ b/include/linux/mm.h	2004-11-13 15:53:11 -05:00
@@ -41,7 +41,7 @@
 #define MM_VM_SIZE(mm)	TASK_SIZE
 #endif
 
-#define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + n)
+#define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
 
 /*
  * Linux kernel virtual memory manager primitives.
