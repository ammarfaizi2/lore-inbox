Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129170AbQKBSD6>; Thu, 2 Nov 2000 13:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129089AbQKBSDt>; Thu, 2 Nov 2000 13:03:49 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:54285 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S129073AbQKBSDm>; Thu, 2 Nov 2000 13:03:42 -0500
Message-Id: <200011021803.eA2I3ba74308@aslan.scsiguy.com>
Date: Thu, 02 Nov 2000 11:03:37 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------- Blind-Carbon-Copy

To: linux-scsi@vger.kernel.org
Subject: 
Date: Thu, 02 Nov 2000 11:03:37 -0700
From: "Justin T. Gibbs" <gibbs@aslan>

	Adaptec SCSI HBA device driver for the Linux Operating System
				Justin T. Gibbs
				  Adaptec Inc.
			     gibbs@btc.adaptec.com
				  2000/11/02


Introduction:

	In an effort to increase its level of support for the Linux community,
	Adaptec Inc. has committed to enhancing and maintaining the community
	developed driver for Adaptec AIC78XX SCSI host bus adapters.  This
	package represents the first public Alpha release of the Adaptec
	sponsored driver.  As this is an Alpha release:

	THIS DRIVER SHOULD NOT BE DEPLOYED EXCEPT IN A TESTING
	ENVIRONMENT WHERE SYSTEM CORRUPTION, DATA LOSS, AND SYSTEM
	INSTABILITY CAN BE TOLERATED.

	This driver is under active development.  New versions may
	be found at:

		http://people.FreeBSD.org/~gibbs/linux/

Supported Hardware:

	All Adaptec Fast, Ultra, Ultra2 and Ultra160/m PCI adapters
	are supported by this release.  This includes, but it not
	limited to the 2930, 2940, 2940UW, 2950U2W, 3950U2W, 19160,
	29160, 39160, and motherboard versions of the
	aic7850/55/59/60/70/80/90/91/92/67/97/99.

New Features:

	o Adaptive tagged queuing algorithm.  This new algorithm
	  will fine tune the queue depth for a particular device.
	  For devices with a fixed depth, the driver will eventually
	  determine that depth and from that point forward, avoid
	  queuing more commands than the device can handle.  For
	  devices that report queue full for temporary resource
	  shortages, the driver will throttle back and slowly
	  attempt to increase the queue depth over time.  Tagged
	  queuing is enabled by default.

	o U160 is now supported on all U160 devices.  The Adaptec
	  driver firmware issue that rendered U160 speeds unreliable
	  on some Quantum drives has been resolved.

ERRATA:
	o Not all KERNEL_VERSION defines are completely correct.
	  Some assistance from the community in refining these
	  values would be appreciated.  The current values
	  were determined based on porting efforts to 2.2.14,
	  2.3.99-pre9, and 2.4.0-test10, but an exhaustive search
	  of exactly when certain kernel interfaces changed was not
	  performed.

	o The VL/EISA attachment has not been tested.

	o The driver has not been audited for big endian issues,
	  and is not guaranteed to work on big endian systems.
	  The driver is 64bit clean.

	o Domain Validation is not yet implemented.

	o Several of the historical driver load options (for modules
	  or via LILO) are not yet honored.

	o /proc support is not yet implemented.

Patching your kernel:

	cd /usr/src/linux
	tar xvfz aic7xxx.src.tar.gz
	patch -p1 < 2.4.0.diffs

	Only diffs for 2.4.0 are currently provided.  As more community
	testing is completed, patches for additional kernel revisions will
	be made available.  Driver update disks will be provided as soon
	as the driver goes into Beta testing.

------- End of Blind-Carbon-Copy
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
