Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265803AbSKAW1N>; Fri, 1 Nov 2002 17:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265804AbSKAW1N>; Fri, 1 Nov 2002 17:27:13 -0500
Received: from fmr05.intel.com ([134.134.136.6]:51420 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S265803AbSKAW1L>; Fri, 1 Nov 2002 17:27:11 -0500
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A49F@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI patches updated
Date: Fri, 1 Nov 2002 14:33:33 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

ACPI patches dated 20021101 is now released at http://sf.net/projects/acpi
<http://sf.net/projects/acpi>  for both 2.4.x and 2.5.x. It includes a fix
for a bug causing processor and thermal drivers to fail to load, as well as
a few others.

Thanks -- Regards -- Andy

----------------------------------------
01 November 2002.  Summary of changes for version 20021101.

1) Linux

Fixed a problem introduced in the previous release where the
Processor and Thermal objects were not recognized and
installed in /proc.  This was related to the scope type change
described below.

2) ACPI CA Core Subsystem:

Fixed a problem where platforms that have a GPE1 block but no
GPE0 block were not handled correctly.  This resulted in a
"GPE overlap" error message.  GPE0 is no longer required.

Removed code added in the previous release that inserted nodes
into the namespace in alphabetical order.  This caused some
side-effects on various machines.  The root cause of the
problem is still under investigation since in theory, the
internal ordering of the namespace nodes should not matter.

Enhanced error reporting for the case where a named object is
not found during control method execution.  The full ACPI
namepath (name reference) of the object that was not found is
displayed in this case.

Note: as a result of the overhaul of the namespace object
types in the previous release, the namespace nodes for the
predefined scopes (_TZ, _PR, etc.) are now of the type
ACPI_TYPE_LOCAL_SCOPE instead of ACPI_TYPE_ANY.  This
simplifies the namespace management code but may affect code
that walks the namespace tree looking for specific object
types.


-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover@intel.com


