Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751899AbWCNBPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbWCNBPQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 20:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751920AbWCNBPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 20:15:16 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36569 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751899AbWCNBPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 20:15:14 -0500
Subject: Re: New libata PATA patch for 2.6.16-rc1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOC.4.61.0603132202080.14431@math.ut.ee>
References: <20060313195722.6ADBF1401F@rhn.tartu-labor>
	 <Pine.SOC.4.61.0603132202080.14431@math.ut.ee>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Mar 2006 01:21:13 +0000
Message-Id: <1142299273.25773.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-03-13 at 22:08 +0200, Meelis Roos wrote:
> Built an universla kernel with alla PATA drivers and netconsole, to test 
> on some machines. Just finished building and tried it in qemu, with 
> different config than before. It still crashes in qemu. dmesg and 
> .config below. It seems to detect PDC20230-C/20630 VLB ATA controller 
> that is not there, and then crash in legacy_init(?).

Interesting. If you compile the legacy driver out does it then run
properly. If you've got an IDE class device legacy should not be loading
so I'll have a look at that.

The detection of the 20230 implies a bug in the Qemu IDE emulation but
it shouldn't have crashed and it shouldn't even have tried to detect it
if PCI IDE claims to be present as I believe is the case ?

