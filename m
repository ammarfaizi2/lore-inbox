Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290485AbSAYBaL>; Thu, 24 Jan 2002 20:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290481AbSAYB3u>; Thu, 24 Jan 2002 20:29:50 -0500
Received: from fmfdns01.fm.intel.com ([132.233.247.10]:59856 "EHLO
	calliope1.fm.intel.com") by vger.kernel.org with ESMTP
	id <S290480AbSAYB3o>; Thu, 24 Jan 2002 20:29:44 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C02AB7BDF@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'lwn@lwn.net'" <lwn@lwn.net>
Cc: "Acpi-linux (E-mail)" <acpi-devel@lists.sourceforge.net>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: ACPI mentioned on lwn.net/kernel
Date: Thu, 24 Jan 2002 17:29:40 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

As longtime subscribers to acpi-devel know, this seems to come up every few
months, but the criticisms mentioned in this week's lwn.net kernel
development summary (http://lwn.net/2002/0124/kernel.php3) prompt me to
respond, lest my silence be taken for capitulation. ;-)

The concerns seem to be summed up when the article says, "ACPI brings
substantial amounts of kernel bloat, reliability worries, and security
concerns." Let me respond to each of those in reverse order:

1) Security concerns
- I think you mistook some kernel developers' off the cuff comments about
this as being real concerns, rather than trolling me (which is apparently
frightfully easy ;-). ACPI is only concerned with power management and
configuration. It has nothing to do with digital rights management, and that
phrase does not appear anywhere in the 481 page ACPI 2.0 specification. The
word "security" appears only twice.

2) Reliability
- One of ACPI's design goals was actually to reduce the OS's susceptibility
to bad BIOSs, compared to APM. OSs using APM suffer because they must call
into the BIOS -- relinquish control completely -- to perform power
management. Under ACPI this is not the case. For example, to get the current
battery status, the steps the OS must perform are defined by the BIOS.
However, since they are performed by the OS, the OS in fact gains visibility
into the process, and does not ever relinquish control to the BIOS.

3) Bloat
- Optimizing for size (or the various unloading schemes) should wait until
the codebase stabilizes. We're still adding major pieces of functionality.
- 100K really isn't that much, compared to other kernel modules (determined
via "size *.o"), or compared to memory installed on most machines these
days.
- Bloat is compiler-dependent. Compiling the interpreter with MSVC instead
of GCC resulted in a ~40% size decrease.

Anyway, looking towards the future...

Our next release will have preliminary support for PCI IRQ routing via ACPI
(which should solve Jes's problem), along with a complete rewrite of the
ancillary drivers to adopt the new Linux 2.5 driver model. When it is ready
(target: Jan 31st) I'll post on both acpi-devel and linux-kernel. My hope
is, the more people gain familiarity of Linux's ACPI code by testing and
helping in its development, the more we all can accept it on its merits, and
start improving Linux's PnP and power management by using the improved
functionality ACPI provides.

Regards -- Andy


----------------------------
Andrew Grover
Intel/MPG/Mobile Arch Lab
andrew.grover@intel.com

