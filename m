Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbUKEVUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbUKEVUN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 16:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbUKEVTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 16:19:45 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:28104 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S261220AbUKEVTU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 16:19:20 -0500
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com, james4765@verizon.net
Message-Id: <20041105211919.17210.92084.88561@localhost.localdomain>
In-Reply-To: <20041105211912.17210.55119.84600@localhost.localdomain>
References: <20041105211912.17210.55119.84600@localhost.localdomain>
Subject: [PATCH] hw_random: Remove changelog from hw_random.txt
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [68.238.31.6] at Fri, 5 Nov 2004 15:19:19 -0600
Date: Fri, 5 Nov 2004 15:19:20 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove pre-merge changelog from Documentation/hw_random.txt

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.9-original/Documentation/hw_random.txt linux-2.6.9/Documentation/hw_random.txt
--- linux-2.6.9-original/Documentation/hw_random.txt	2004-10-18 17:54:38.000000000 -0400
+++ linux-2.6.9/Documentation/hw_random.txt	2004-11-05 15:28:24.834717240 -0500
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
