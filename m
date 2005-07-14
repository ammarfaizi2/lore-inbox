Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbVGNT0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVGNT0t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 15:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVGNT0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 15:26:49 -0400
Received: from fmr15.intel.com ([192.55.52.69]:28855 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S261488AbVGNTYQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 15:24:16 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.13-rc3 ACPI regression and hang on x86-64
Date: Thu, 14 Jul 2005 15:23:52 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30040CF75E@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.13-rc3 ACPI regression and hang on x86-64
Thread-Index: AcWIX/22mzsZVhMMTPOlyirUCP62gAAR56qg
From: "Brown, Len" <len.brown@intel.com>
To: "Mikael Pettersson" <mikpe@csd.uu.se>, "Yu, Luming" <luming.yu@intel.com>
Cc: <acpi-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Jul 2005 19:23:55.0729 (UTC) FILETIME=[939C9410:01C588A9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>acpi_ec-0217 [04] acpi_ec_leave_burst_mo: ------->status fail
>
>on the console, and then the machine is hung hard.

2.6.13-rc3 x86_64 failed, but 
2.6.13-rc2 x86_64 worked

And both of these revisions in the i386 kernel still work?

>+evxfevnt-0203 [07] acpi_enable_event     : Could not enable
power_button
>event
>+ evxface-0157 [06] acpi_install_fixed_eve: Could not enable fixed
event.
>+acpi_button-0224 [05] acpi_button_add       : Error installing notify
>handler
>+ACPI: Power Button (CM) [PWRB]


We're toast at this point, even before the EC message.

Looks like this failure was reported here
http://bugzilla.kernel.org/show_bug.cgi?id=4534
and is assigned to Luming.

Is it possible for you to test the latest ACPI patch?
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/
2.6.13/

Also, it would be good to confirm the same failure exists with
CONFIG_ACPI_DEBUG=n.

thanks,
-Len

