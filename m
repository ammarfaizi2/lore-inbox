Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290502AbSAYCQH>; Thu, 24 Jan 2002 21:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290500AbSAYCQA>; Thu, 24 Jan 2002 21:16:00 -0500
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:39646 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S290497AbSAYCPl>; Thu, 24 Jan 2002 21:15:41 -0500
Message-ID: <D9223EB959A5D511A98F00508B68C20C048758BC@ORSMSX108>
From: "Therien, Guy" <guy.therien@intel.com>
To: "Grover, Andrew" <andrew.grover@intel.com>, "'lwn@lwn.net'" <lwn@lwn.net>
Cc: "Acpi-linux (E-mail)" <acpi-devel@lists.sourceforge.net>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [ACPI] ACPI mentioned on lwn.net/kernel
Date: Thu, 24 Jan 2002 18:15:36 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll add that contrary to your statement, EVERY other OS with ACPI support
has it in their kernel. 
Since Linux APM support calls the APM BIOS, which is not easily changed, and
ACPI calls AML that you can capture and change to fix any problems
discovered using available tools, I'd say you were off with the statement
about "an interpreter that can run arbitrary, closed source code" also. You
can't "configure and dump" if you want runtime configuration and power
management. If you need more info ask on or off the list.
Regards,
ACPIGuy

-----Original Message-----
From: Grover, Andrew [mailto:andrew.grover@intel.com]
Sent: Thursday, January 24, 2002 5:30 PM
To: 'lwn@lwn.net'
Cc: Acpi-linux (E-mail); 'linux-kernel@vger.kernel.org'
Subject: [ACPI] ACPI mentioned on lwn.net/kernel


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


_______________________________________________
Acpi-devel mailing list
Acpi-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/acpi-devel
