Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161187AbVICJu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161187AbVICJu3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 05:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbVICJu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 05:50:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16325 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750824AbVICJu2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 05:50:28 -0400
Date: Sat, 3 Sep 2005 02:48:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org,
       James.Bottomley@steeleye.com, linux-scsi@vger.kernel.org
Subject: Re: 2.6.13-mm1: hangs during boot ...
Message-Id: <20050903024841.341beef0.akpm@osdl.org>
In-Reply-To: <43196CAE.2000309@bigpond.net.au>
References: <F7DC2337C7631D4386A2DF6E8FB22B30047FA063@hdsmsx401.amr.corp.intel.com>
	<4319403E.4050105@bigpond.net.au>
	<43194E3B.2050609@bigpond.net.au>
	<1125735548.11903.53.camel@toshiba>
	<43196CAE.2000309@bigpond.net.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams <pwil3058@bigpond.net.au> wrote:
>
> > Please then try the latest ACPI patch here:
>  > http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.13/acpi-20050902-2.6.13.diff.gz
>  > It should apply to vanilla 2.6.13 with a reject in ia64/Kconfig
>  > that you can ignore.
>  > 
>  > If this works, then we munged git-acpi.patch in 2.6.13-mm1 somehow.
> 
>  There were no problems with this patch applied.  So it looks like the 
>  munge theory is correct.

That diff is significantly different from the diff I plucked from
master.kernel.org:/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git#test
for 2.6.13-mm1.

Doing (patch -R | grep FAILED) on 2.6.13-mm1 says:

Hunk #3 FAILED at 356.
1 out of 3 hunks FAILED -- saving rejects to file arch/ia64/Kconfig.rej
Hunk #6 FAILED at 190.
Hunk #8 FAILED at 221.
Hunk #10 FAILED at 254.
Hunk #11 FAILED at 357.
Hunk #15 FAILED at 474.
Hunk #17 FAILED at 569.
6 out of 17 hunks FAILED -- saving rejects to file drivers/acpi/dispatcher/dsmethod.c.rej
Hunk #19 FAILED at 468.
Hunk #29 FAILED at 701.
2 out of 38 hunks FAILED -- saving rejects to file drivers/acpi/dispatcher/dswload.c.rej
Hunk #14 FAILED at 321.
Hunk #43 FAILED at 1159.
2 out of 44 hunks FAILED -- saving rejects to file drivers/acpi/osl.c.rej
Hunk #17 FAILED at 1134.
1 out of 18 hunks FAILED -- saving rejects to file drivers/acpi/parser/psparse.c.rej
Hunk #3 FAILED at 74.
1 out of 3 hunks FAILED -- saving rejects to file drivers/acpi/parser/psxface.c.rej
Hunk #1 FAILED at 35.
1 out of 15 hunks FAILED -- saving rejects to file drivers/acpi/pci_bind.c.rej
Hunk #5 FAILED at 220.
Hunk #15 FAILED at 412.
Hunk #16 FAILED at 425.
Hunk #17 FAILED at 446.
Hunk #19 FAILED at 484.
5 out of 36 hunks FAILED -- saving rejects to file drivers/acpi/processor_core.c.rej
Hunk #1 FAILED at 41.
Hunk #2 FAILED at 71.
Hunk #4 FAILED at -55.
Hunk #5 FAILED at 30.
Hunk #6 FAILED at 40.
Hunk #7 FAILED at 69.
Hunk #9 FAILED at 317.
Hunk #10 FAILED at 344.
Hunk #12 FAILED at 289.
Hunk #14 FAILED at 523.
Hunk #15 FAILED at 607.
Hunk #16 FAILED at 618.
Hunk #17 FAILED at 645.
Hunk #19 FAILED at 534.
Hunk #20 FAILED at 686.
Hunk #22 FAILED at 916.
Hunk #23 FAILED at 968.
Hunk #25 FAILED at 881.
Hunk #26 FAILED at 891.
Hunk #29 FAILED at 953.
20 out of 29 hunks FAILED -- saving rejects to file drivers/acpi/resources/rsaddr.c.rej
Hunk #11 FAILED at 289.
Hunk #16 FAILED at 407.
Hunk #17 FAILED at 425.
Hunk #18 FAILED at 434.
Hunk #20 FAILED at 470.
Hunk #21 FAILED at 527.
6 out of 21 hunks FAILED -- saving rejects to file drivers/acpi/resources/rsirq.c.rej
Hunk #27 FAILED at 553.
1 out of 61 hunks FAILED -- saving rejects to file drivers/acpi/scan.c.rej
Hunk #1 FAILED at 41.
1 out of 34 hunks FAILED -- saving rejects to file drivers/acpi/utilities/utmisc.c.rej
Hunk #5 FAILED at 291.
1 out of 76 hunks FAILED -- saving rejects to file drivers/acpi/video.c.rej
Hunk #2 FAILED at 64.
1 out of 8 hunks FAILED -- saving rejects to file include/acpi/acconfig.h.rej
Hunk #1 FAILED at 41.
1 out of 1 hunk FAILED -- saving rejects to file include/acpi/acdispat.h.rej
Hunk #29 FAILED at 1078.
Hunk #30 FAILED at 1240.
2 out of 31 hunks FAILED -- saving rejects to file include/acpi/actypes.h.rej

