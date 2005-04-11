Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVDKPjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVDKPjn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 11:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVDKPjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 11:39:35 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:54427 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261812AbVDKPjY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 11:39:24 -0400
Subject: Re: security issue: hard disk lock
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jonas Diemer <diemer@gmx.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200504041942.10976.diemer@gmx.de>
References: <200504041942.10976.diemer@gmx.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1113233800.9875.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 11 Apr 2005 16:36:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-04-04 at 18:42, Jonas Diemer wrote:
> I figured there could be a kernel compiled-in option that will make the kernel 
> lock all drives found during bootup. then, a malicous program would need to 
> install a different kernel in order to harm the drive, which would be much 
> more secure.

It makes little difference as the attacker can replace the kernel and
reboot.
Anyway they can flash erase your video card bios, your IDE firmware,
your BIOS
and far more just as easily.

I wrote an analysis for the UK government a few years back about this
threat and concluded that a sufficiently malicious attacker and a
suitable hole would allow someone to wipe out large numbers of PCs on a
fairly permanent basis. We can just be glad that the folks writing stuff
like slammer mostly want either fame or are operating "commercially" (ie
DoS protection rackets, spam etc) so don't wish to kill their hosts.

>From an OS perspective it is very hard to protect against. Locking the
boot media can help providing the BIOS settings cannot be used to boot
another disk. Dropping CAP_SYS_RAWIO early in boot will protect against
most of the potential root user directly accesses the hardware type
attacks. hdparm can help but really it needs to be in the BIOS options
to make much difference so kick your pet BIOS vendor/PC maker.

Alan

