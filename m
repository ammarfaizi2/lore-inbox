Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263578AbUEMMzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263578AbUEMMzR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 08:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbUEMMzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 08:55:17 -0400
Received: from web13904.mail.yahoo.com ([216.136.175.67]:41150 "HELO
	web13904.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263578AbUEMMzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 08:55:05 -0400
Message-ID: <20040513125504.24434.qmail@web13904.mail.yahoo.com>
X-RocketYMMF: knobi.rm
Date: Thu, 13 May 2004 05:55:04 -0700 (PDT)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Re: new laptop woes
To: linux-kernel@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Linux enables the Local APIC even on uni-processors systems so that it
>can use the LOCal APIC timer. This policy causes a significant
>population of laptops to freeze when booted with ACPI enabled.
>Curiously, we've seen this failure go away on some laptops after a
BIOS
>upgrade -- so you shoul verify that you're running the latest BIOS for
>your system.
>
>Perhaps you could try the test patch here
>
>http://bugzilla.kernel.org/show_bug.cgi?id=2044
>
>and add a comment to the bug report on if it makes any difference or
not.

Len,

 just to confirm that the mentioned patch fixes my boot hang (HP
Omnibook 6100, newest BIOS) with kernel-2.6.6. With acpi enabled it
needed "nolacpi" to come up. It would always just stop after the lines:

ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Edge set to Level Trigger.
    ACPI-0179: *** Warning: The ACPI AML in your computer contains
errors, please nag the manufacturer to correct it.
    ACPI-0182: *** Warning: Allowing relaxed access to fields; turn on
CONFIG_ACPI_DEBUG for details.


 Apparently the SuSE supplied 2.6.4-54.3 has that (or a similar) fix in
it, as the notebook boots fine with that.

 Only remaining problem now is that I have the "gut feeling" that I am
missing some mouse events with acpi enabled. That maybe XFree related.

Cheers
Martin

=====
------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
