Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263471AbTHWCLr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 22:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263480AbTHWCLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 22:11:47 -0400
Received: from proxyip5.us.army.mil ([140.183.234.119]:3422 "EHLO
	mailrouter.us.army.mil") by vger.kernel.org with ESMTP
	id S263471AbTHWCLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 22:11:44 -0400
Date: Sat, 23 Aug 2003 10:41:46 +0900
From: kenton.groombridge@us.army.mil
Subject: Re: nforce2 lockups
To: Patrick Dreker <patrick@dreker.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <34a0a7034a4308.34a430834a0a70@us.army.mil>
MIME-version: 1.0
X-Mailer: iPlanet Messenger Express 5.2 HotFix 1.17 (built Jun 23 2003)
Content-type: text/plain; charset=us-ascii
Content-language: en
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you!!!

I had done this before but without the nolapic option.  That appears to have been the solution.  Ran a whole day without one lockup where before 10 minutes was rarely achieved.

I don't know if you knew I had a $20 reward for the fix, but it looks like you got it.

Going to run a few more days just to be sure, but send me your address and I will send you the $20 after stressing my system a bit more.

It looks like the nolapic kernel parameter was just recently introduced.  I tried it in both the 2.4.22-rc2 kernel and the 2.6.0-test3 kernel with success in both.

Would still like apic to be completely fixed in the nforce2 chipsets, but I am just happy to have a working system again.

Thanks again,
Ken

----- Original Message -----
From: Patrick Dreker <patrick@dreker.de>
Date: Thursday, August 21, 2003 8:05 pm
Subject: Re: nforce2 lockups

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Am Thursday 21 August 2003 03:39 schrieb 
> kenton.groombridge@us.army.mil zum 
> Thema Re: nforce2 lockups:
> > and it did cure my spurious interrupt problem, but 
> unfortunately, my
> > lockups have returned.
> I managed to stabilize my Board, but I don't think the trick was 
> obvious: 
> Disable alle APIC related kernel Options (Local APIC and IO-APIC), 
> disable 
> APIC Mode in the BIOS. Check on reboot if it still talks about the 
> APIC in 
> the boot messages (How? IIRC mine did, which was why I did not 
> think that 
> disabling the APIC helped... Actually somehow it still was 
> activated. Could 
> ACPI be part of this?). If it does try noapic and/or nolapic boot 
> options.
> If you completely shut off the APIC it runs stable, but 1 of the 3 
> USB 
> Controllers is not assigned an interrupt. All this with ACPI 
> enabled (ACPI 
> patch 20030730 and kernel 2.6.0-test3).
> 
> - -- 
> Patrick Dreker
> 
> GPG KeyID  : 0xFCC2F7A7 (Patrick Dreker)
> Fingerprint: 7A21 FC7F 707A C498 F370  1008 7044 66DA FCC2 F7A7
> Key available from keyservers or http://www.dreker.de/pubkey.asc
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.2 (GNU/Linux)
> 
> iD8DBQE/RKdhcERm2vzC96cRAtjAAJ4y5oOm7uhtPqWtaS/S+mnWTr9C5gCdF3hK
> 2JQZ86psKDmWO74wxrINSRE=
> =YbYq
> -----END PGP SIGNATURE-----
> 

