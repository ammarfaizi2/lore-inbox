Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130791AbQLLSI5>; Tue, 12 Dec 2000 13:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130679AbQLLSIr>; Tue, 12 Dec 2000 13:08:47 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:27881 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S129844AbQLLSIf>;
	Tue, 12 Dec 2000 13:08:35 -0500
Date: Tue, 12 Dec 2000 18:37:19 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200012121737.SAA28304@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] local APIC and NMI watchdog on UP P6 systems
Cc: kaos@ocs.com.au, macro@ds2.pg.gda.pl, mingo@elte.hu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An updated version of the UP-APIC patch for Intel P6 processors
is now available at:

	http://www.csd.uu.se/~mikpe/linux/upapic/

The current version is intended for 2.4.0-test12 final.

This version is based on Ingo Molnar's upapic-2.4.0-test9-F8 patch,
with add-on patches from Maciej W. Rozycki and myself. I'm
intending to maintain it until it gets into 2.4 or 2.5.

I've used it since test10-pre and believe it to be safe for
general use, but more testers are welcome.

For those unfamiliar with the patch:
- It enables the local APIC found in most P6 family processors,
  even on UP systems which often keep it disabled.
- The NMI watchdog now works on UP systems too. This is interesting
  primarily for kernel hackers wishing to debug lockups.
- A properly enabled local APIC is a prerequisite for interrupt-
  driven use of the performance-monitoring counters.

/Mikael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
