Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271383AbTG2Ki6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 06:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271388AbTG2Ki6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 06:38:58 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:26556 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S271383AbTG2Ki4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 06:38:56 -0400
Date: Tue, 29 Jul 2003 12:38:52 +0200 (MEST)
Message-Id: <200307291038.h6TAcqEM026963@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: andrew.grover@intel.com, jacob@netg.se, linux-kernel@vger.kernel.org
Subject: RE: PROBLEM: ACPI hangs when invoked from keyboard
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jul 2003 16:04:59 -0700, andrew.grover@intel.com wrote:
>This isn't ACPI, it's because 2.5.74+ force the APIC enabled.

In this case, the problematic 2.5.74 patch you're referring to
is NOT the culprit.

His machine is a P3 not P4, and we've _always_ force-enabled the
local APICs for all P6/K7-family processors. The 2.5.74 patch
only affects P4s.

(I'm thinking about a lapic/nolapic pair of kernel command-line
options, and possibly changing the P4 default to only enable
if lapic was on the command line. That should solve the issues
with local APIC + ACPI in broken BIOSen.)

...
>> IBM Thinkpad X30
...
>> processor       : 0
>> vendor_id       : GenuineIntel
>> cpu family      : 6
>> model           : 11
>> model name      : Mobile Intel(R) Pentium(R) III CPU - M  1200MHz
>> stepping        : 4
