Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265248AbUGANvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265248AbUGANvl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 09:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265285AbUGANvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 09:51:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:53129 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265248AbUGANvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 09:51:32 -0400
Date: Tue, 29 Jun 2004 23:40:52 +0200
From: Pavel Machek <pavel@suse.cz>
To: Sergio Vergata <vergata@stud.fbi.fh-darmstadt.de>
Cc: linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org
Subject: Re: ACPI Hibernate and Suspend Strange behavior 2.6.7/-mm1
Message-ID: <20040629214052.GO698@openzaurus.ucw.cz>
References: <200406270032.12897.vergata@stud.fbi.fh-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406270032.12897.vergata@stud.fbi.fh-darmstadt.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> So i don't use Apic and so acpi works now after powering on the machine and 
> booting with acpi resume kernel all get to work again. Only sometimes, don't 
> know why and in witch circumstances, the system boots the kernel and find the 
> Image in Swapspace, but reading that image says that this is an corruptet 
> image and stop booting, now if I power the system whith resume=noresume the 
> kernel boots up find the Image in swap (why that) and restore this found 
> image back to an running system at the last state. Strange ! After the system 

fsck now, and never ever resume second time.
If resume fails, force fsck and re-mkswap.
				Pavel

> boots everything goes back to work. Only the IRQ problem remains and 
> hibernating and resuming again will work. 
> 
> Finaly I have an request: could the acpi_wakeup_devices be addet to some patch 
> set ? Or preferable to kerneltree it self?! 
> 
> 
> So i hope someone will read this, and maybe report the same problems, or 
> better an hint what it could be :-) 
> 
> CU Sergio
> 
> - -- 
> Microsoft is to operating systems & security ....
>              .... what McDonalds is to gourmet cooking
> 
> PGP-Key http://vergata.it/GPG/F17FDB2F.asc
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.4 (GNU/Linux)
> 
> iD8DBQFA3fllVP5w5vF/2y8RAiPlAKC4pA4mg4Pi2UtNLl+qW+lK1SJbIQCfWjnv
> 9/G8l8GRh7z3h2CzXFIcUs4=
> =xEU+
> -----END PGP SIGNATURE-----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

