Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262622AbSJBVsw>; Wed, 2 Oct 2002 17:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262620AbSJBVso>; Wed, 2 Oct 2002 17:48:44 -0400
Received: from hdfdns02.hd.intel.com ([192.52.58.11]:30173 "EHLO
	mail2.hd.intel.com") by vger.kernel.org with ESMTP
	id <S262628AbSJBVrw>; Wed, 2 Oct 2002 17:47:52 -0400
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DEFA@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: linux-kernel@vger.kernel.org
Subject: ACPI patches updated (20021002)
Date: Wed, 2 Oct 2002 14:53:14 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

There is a new release available at http://sf.net/projects/acpi . It
incorporates many fixes from people on the acpi-devel list (thanks to
everyone) as well as some interpreter enhancements.

Regards -- Andy

----------------------------------------

02 October 2002.  Summary of changes for this release.

1) Linux

Initialize thermal driver's timer before it is used. (Knut
Neumann)

Allow handling negative celsius values. (Kochi Takayoshi)

Fix thermal management and make trip points. R/W (Pavel
Machek)

Fix /proc/acpi/sleep. (P. Christeas)

IA64 fixes. (David Mosberger)

Fix reversed logic in blacklist code. (Sergio Monteiro Basto)

Replace ACPI_DEBUG define with ACPI_DEBUG_OUTPUT. (Dominik
Brodowski)

2) ACPI CA Core Subsystem version 20021002:

Fixed a problem where a store/copy of a string to an existing
string did not always set the string length properly in the
String object.

Fixed a reported problem with the ToString operator where the
behavior was identical to the ToHexString operator instead of
just simply converting a raw buffer to a string data type.

Fixed a problem where CopyObject and the other "explicit"
conversion operators were not updating the internal namespace
node type as part of the store operation.

Fixed a memory leak during implicit source operand conversion
where the original object was not deleted if it was converted
to a new object of a different type.

Enhanced error messages for all problems associated with
namespace lookups.  Common procedure generates and prints the
lookup name as well as the formatted status.

Completed implementation of a new design for the Alias support
within the namespace.  The existing design did not handle the
case where a new object was assigned to one of the two names
due to the use of an explicit conversion operator, resulting
in the two names pointing to two different objects.  The new
design simply points the Alias name to the original name node
- not to the object.  This results in a level of indirection
that must be handled in the name resolution mechanism.


-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover@intel.com

