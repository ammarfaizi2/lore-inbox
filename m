Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266572AbUBESKY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 13:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266575AbUBESKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 13:10:24 -0500
Received: from fmr03.intel.com ([143.183.121.5]:15567 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S266572AbUBESKG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 13:10:06 -0500
Subject: Re: acpi interrupts going haywire
From: Len Brown <len.brown@intel.com>
To: Casey Lancour <cjlancour@link.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0023E8695@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE0023E8695@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1076004598.2558.8.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 05 Feb 2004 13:09:59 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Casey,
I don't expect CPU firmware to have any effect on acpi interrupts --
however, the BIOS version and BIOS SETUP settings certainly could; so
you should verify that you're running the latest BIOS and that the CMOS
settings are the same on the working and failing systems.

It would be good if you can select one of the failing systems and try a
newer kernel on it.  Note that we support the latest ACPI patch on top
of kernels back to 2.4.22:

http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/

You may have a mis-configired acpi interrupt, or there may be a real
interrupt source out there.  When you're running up-to-date code, there
are a number of things we can do to diagnose.

Feel free to open a bug against this failure.

thanks,
-Len

How to file a bug against ACPI:

http://bugzilla.kernel.org/ Category: Power Management, Component: ACPI

Please attach dmesg -s40000 output (or serial console log if dmesg
unavailable)
Please attach copy of /proc/interrupts if possible

Please attach the output from acpidmp, available in /usr/sbin/, or in
pmtools:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

Please attach the output from dmidecode, available in /usr/sbin/, or
here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/


On Wed, 2004-02-04 at 14:14, Casey Lancour wrote:
> Problem:
> im running the 2.4.20 kernel and my /proc/interrupts reports that my
> acpi
> has like 4billion inturrupts going off and my system is sluggish
> (rebooting fixes it).  It isnt intermitant! Yet i have about 100 of
> these
> computers and not all of them do it, the bois settings and versions
> are
> all the same as well as the harddisks and hardware. (the ones that
> have
> the problem always have it and the ones that dont always dont)
> 
> Question:
> I wanna log and trace what my kernel is doing at boot see if i can see
> if
> there is a before and after for when the interrupts go nuts. how is
> this
> done?
> 
> Could getting the latest Intel IA32 CPU microcode help? and adding
> /dev/cpu support to kernel make any difference. as
> http://urbanmyth.org/microcode/ isnt specific as to what the microcode
> does.
> 
> thanks in advance,
> 
>      -=Casey
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

