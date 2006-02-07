Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWBGLgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWBGLgj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 06:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWBGLgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 06:36:39 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:29381 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750888AbWBGLgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 06:36:38 -0500
Subject: Re: libATA  PATA status report, new patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOC.4.61.0602071305310.10491@math.ut.ee>
References: <20060207084347.54CD01430C@rhn.tartu-labor>
	 <1139310335.18391.2.camel@localhost.localdomain>
	 <Pine.SOC.4.61.0602071305310.10491@math.ut.ee>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 07 Feb 2006 11:38:50 +0000
Message-Id: <1139312330.18391.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-02-07 at 13:10 +0200, Meelis Roos wrote:
> I also tried VMWare 5.5 that emulated PIIX4. It works if I only put 
> ata_piix driver in. With the same kernel that Qemu gets the error, 
> VMWare gets another oops during generic ide initialisation. I relooked 
> and found that I have both generic PCI ide and generic ISA ide drivers 
> compiled in, so I disabled them and it works using ata_piix (with PATA 
> and ATAPI enabled). Even ATAPI cdrom worked as the root partition.

Ok there is a resource handling bug somewhere in the generic case that
needs fixing I have yet to find. Also some mishandling of devices with
bmdma not enabled which kills Qemu. I've just been fixing the latter and
also adding CFA awareness. I'll take a look at the resource code next.

Alan

