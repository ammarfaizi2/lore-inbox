Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131323AbRD3FD4>; Mon, 30 Apr 2001 01:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133098AbRD3FDr>; Mon, 30 Apr 2001 01:03:47 -0400
Received: from rumor.cps.intel.com ([192.102.198.242]:6131 "EHLO
	rumor.cps.intel.com") by vger.kernel.org with ESMTP
	id <S131323AbRD3FDa>; Mon, 30 Apr 2001 01:03:30 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E89006CDDDE5@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Pavel Machek'" <pavel@suse.cz>,
        "Michael K. Johnson" <johnsonm@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Lid support for ACPI
Date: Sun, 29 Apr 2001 22:00:05 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(btw ACPI 2.0 spec section 12.1.1 discusses this)

> From: Pavel Machek [mailto:pavel@suse.cz]
> > No, the ACPI standard requires CPUs to shut themselves down before
> > any damage would occur from overheading.  Well, at least the 1.0b
> > version of the standard did; I haven't read 2.0 yet.

> BTW shut themselves down to halt, or shut themselves to 
> *very* low speed?

Both. When a CPU overheats, the OS implements either active (turning on a
fan) or passive (cpu throttling). If the temperature still exceeds the
critical threshold, the OS must shut down.

> Slow down to 10% speed is what my toshiba does. Is there way 
> back from such
> mode?

Once the temperature drops below the active and passive cooling thresholds,
the OS should stop its cooling measures, such as throttling.

That said, I seem to recall your laptop is doing throttling in a non-OS
visible way (BIOS) so I don't know under what circumstances it stops cpu
throttling.

Regards -- Andy

