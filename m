Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265791AbUBBS7u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 13:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265783AbUBBS7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 13:59:50 -0500
Received: from fmr03.intel.com ([143.183.121.5]:38058 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S265791AbUBBS7r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 13:59:47 -0500
Subject: Re: oops with 2.6.1-rc1 and rc-3
From: Len Brown <len.brown@intel.com>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: Micha Feigin <michf@post.tau.ac.il>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <401E0E2C.8020708@gmx.de>
References: <BF1FE1855350A0479097B3A0D2A80EE0020AEB18@hdsmsx402.hd.intel.com>
	 <1075664953.2389.12.camel@dhcppc4>  <401E0E2C.8020708@gmx.de>
Content-Type: text/plain
Organization: 
Message-Id: <1075748372.2398.117.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 02 Feb 2004 13:59:32 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> handlers:
>> [<c02a6b50>] (ide_intr+0x0/0x190)
>> [<c03248c0>] (snd_intel8x0_interrupt+0x0/0x210)
>> Disabling IRQ #11
>> irq 11: nobody cared!

> If you find that it goes away when you boot with pci=noacpi, or
> > acpi=off, then it is likely an ACPI issue -- otherwise it is likely
> > something else -- so give those a try and let me know.
> 
> Ok, I tried rc3 without acpi compiled in, and yes, it booted. So I guess 
> acpi is really breaking up stuff. If you want me to test patches, let me 
> know.


Need more info before sending you test patches, please open up a new bug
report and put the info there:

http://bugzilla.kernel.org/ Category: Power Management, Component: ACPI

For the same (ACPI enabled) kernel, both with and without "acpi=off",
please attach 

dmesg -s40000 output (or serial console log if dmesg unavailable)
/proc/interrupts

If you can run the latest release, and clarify which release this last
worked properly in, that would be helpful.

Also, please attach the output from acpidmp, available in /usr/sbin/, or
in pmtools:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

Please attach the output from dmidecode, available in /usr/sbin/, or
here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

and attach a copy of your .config

thanks,
-Len


