Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422812AbWJYBa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422812AbWJYBa2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 21:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422819AbWJYBa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 21:30:27 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20753 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422812AbWJYBa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 21:30:27 -0400
Date: Wed, 25 Oct 2006 03:30:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>
Subject: Re: linux-2.6.19-rc2 tg3 problem
Message-ID: <20061025013022.GG27968@stusta.de>
References: <b6a2187b0610230824m38ce6fb2j65cd26099e982449@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6a2187b0610230824m38ce6fb2j65cd26099e982449@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 11:24:14PM +0800, Jeff Chua wrote:
> I'm getting this error on with linux 2.6.19-rc2 with tg3 module, even
> with patching to v3.66 ...
> 
> tg3.c:v3.67 (October 18, 2006)
> ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
> tg3: Cannot find proper PCI device base address, aborting.
> ACPI: PCI Interrupt for device 0000:02:00.0 disabled
> 
> The last version 2.6.18-rc2 works fine. h/w is Dell Optiplex GX620.

Known issue, can you confirm the patches below fix it for you?

Subject    : "ACPI: PCI interrupt for device ... disabled"
References : http://lkml.org/lkml/2006/10/21/227
             http://lkml.org/lkml/2006/10/23/89
Submitter  : Muli Ben-Yehuda <muli@il.ibm.com>
             Gleb Natapov <glebn@voltaire.com>
Caused-By  : Yinghai Lu <yinghai.lu@amd.com>
             commit 45edfd1db02f818b3dc7e4743ee8585af6b78f78
Handled-By : Eric W. Biederman <ebiederm@xmission.com>
Patch      : http://marc.theaimsgroup.com/?l=linux-kernel&m=116157813623508&w=2
             http://marc.theaimsgroup.com/?l=linux-kernel&m=116157837104613&w=2
Status     : patches available

> Jeff.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

