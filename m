Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266119AbUA1RH3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 12:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266120AbUA1RH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 12:07:29 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:47569 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S266119AbUA1RHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 12:07:22 -0500
Date: Wed, 28 Jan 2004 18:07:03 +0100
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP AMD64 (Tyan S2882) problems.
Message-ID: <20040128180702.E6714@fi.muni.cz>
References: <20040127190911.B13769@fi.muni.cz.suse.lists.linux.kernel> <p73fze1fdk4.fsf@nielsen.suse.de> <20040127224931.D24747@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040127224931.D24747@fi.muni.cz>; from kas@informatics.muni.cz on Tue, Jan 27, 2004 at 10:49:31PM +0100
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak wrote:
: : > Problem 2: the 3ware controller does not work correctly on the first
: : > PCI bus (slot 1 and 2) - in slot 1 it hangs under bigger load (e.g.
: : > an array rebuild), in slot 2 it hangs during boot in 3ware BIOS.
: : > It is probably not Linux-specific, but has anyone seen the same problem?
: : 
: : I haven't seen it.
: : 
: : You can try if it goes away when you disable ACPI PCI routing
: : (pci=noacpi) 
: 
: 	I will try tomorrow.
: 

	With pci=noacpi the system does not boot: it hangs during
the 3ware initialization - prints the following message:

3w-xxxx: scsi0: UNIT #0: Command (000001002645b0) timed out, resetting card
3w-xxxx: scsi0: UNIT #0: Command (000001002645b0) timed out, resetting card

Then it tries the same with UNIT #1 (whatever it is) and then the system
locks up.

	With acpi=off it boots correctly. I will try it in another
Tyan S2882 box - it may be a faulty mainboard.

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
 Any compiler or language that likes to hide things like memory allocations
 behind your back just isn't a good choice for a kernel.   --Linus Torvalds
