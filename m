Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263788AbUDVCvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263788AbUDVCvs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 22:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263790AbUDVCvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 22:51:48 -0400
Received: from fmr02.intel.com ([192.55.52.25]:42727 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S263788AbUDVCvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 22:51:35 -0400
Subject: Re: ACPIKernel OOPS
From: Len Brown <len.brown@intel.com>
To: reddog83@charter
Cc: reddog83@charter.net, linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F9649@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F9649@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1082602291.16333.145.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 21 Apr 2004 22:51:31 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-21 at 03:52, Nathaniel Russell wrote:
> Attached is my problem w/ ACPI. I can't figure it out on Linux
> Kernel-2.4.26

ACPI: Subsystem revision 20040326
...
ACPI: Unable to load the System Description Tables

This isn't an OOPS.
This is ACPI choking on the DSDT in your BIOS
and deciding to head for the exits.

Did other versions of Linux run in ACPI mode on this box?

I recommend that you file a bug so we can look at
this failure in more detail.

thanks,
-Len
---------

How to file a bug against ACPI:

http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
Select component "AML Interpreter"

Please attach dmesg -s40000 output (or serial console log if dmesg
unavailable)
Please attach copy of /proc/interrupts if possible

Please attach the output from acpidmp, available in /usr/sbin/, or in
pmtools:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/


