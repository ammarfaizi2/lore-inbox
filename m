Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265787AbTAJSjf>; Fri, 10 Jan 2003 13:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265857AbTAJSaJ>; Fri, 10 Jan 2003 13:30:09 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:19409 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S265787AbTAJS3b>; Fri, 10 Jan 2003 13:29:31 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A84725A119@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: acpi-devel@sourceforge.net
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: ACPI patches updated (20030109)
Date: Fri, 10 Jan 2003 10:38:03 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

ACPI patches based upon the 20030109 label have been released.
http://sourceforge.net/projects/acpi . The non-Linux releases will be
available at
http://developer.intel.com/technology/iapc/acpi/downloads.htm , by
tomorrow.

Regards -- Andy

----------------------------------------
09 January 2003.  Summary of changes for version 20030109.

1) Linux-specific

Fixed an oops on module insertion/removal (Matthew Tippett)

(2.4) Fix to handle dynamic size of mp_irqs (Joerg Prante)

(2.5) Replace pr_debug (Randy Dunlap)

(2.5) Remove usage of CPUFREQ_ALL_CPUS (Dominik Brodowski)

(Both) Eliminate spawning of thread from timer callback, in
favor of schedule_work()

(Both) Show Lid status in /proc (Zdenek OGAR Skalak)

(Both) Added define for Fixed Function HW region (Matthew
Wilcox)

(Both) Add missing statics to button.c (Pavel Machek)

Several changes have been made to the source code translation
utility that generates the Linux Code in order to make the
code more "Linux-like":

All typedefs on structs and unions have been removed in
keeping with the Linux coding style.

Removed the non-Linux SourceSafe module revision number from
each module header.

Completed major overhaul of symbols to be lowercased for
linux.  Doubled the number of symbols that are lowercased.

Fixed a problem where identifiers within procedure headers and
within quotes were not fully lower cased (they were left with
a starting capital.)

Some C macros whose only purpose is to allow the generation of
16-bit code are now completely removed in the Linux code,
increasing readability and maintainability.

2) ACPI CA Core Subsystem:

Changed the behavior of the internal Buffer-to-String
conversion function.  The current ACPI specification states
that the contents of the buffer are "converted to a string of
two-character hexadecimal numbers, each separated by a space".
Unfortunately, this definition is not backwards compatible
with existing ACPI 1.0 implementations (although the behavior
was not defined in the ACPI 1.0 specification).  The new
behavior simply copies data from the buffer to the string
until a null character is found or the end of the buffer is
reached.  The new String object is always null terminated.
This problem was seen during the generation of _BIF battery
data where incorrect strings were returned for battery type,
etc.  This will also require an errata to the ACPI
specification.

Renamed all instances of NATIVE_UINT and NATIVE_INT to
ACPI_NATIVE_UINT and ACPI_NATIVE_INT, respectively.

Copyright in all module headers (both Linux and non-Linux) has
be updated to 2003.


-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover@intel.com

