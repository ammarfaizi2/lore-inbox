Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbTIZUqj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 16:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbTIZUqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 16:46:38 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:45003 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S261556AbTIZUqh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 16:46:37 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Jan Rychter <jan@rychter.com>
Date: Fri, 26 Sep 2003 22:46:12 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: vmware in Linux 2.6
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <155339E1124@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Sep 03 at 12:56, Jan Rychter wrote:
> >>>>> "Petr" == Petr Vandrovec <VANDROVE@vc.cvut.cz>:
>  Petr> On 26 Sep 03 at 12:50, Mons Rullgord wrote:
>  >> "Petr Vandrovec" <VANDROVE@vc.cvut.cz> writes:
>  >>
>  > Is it possible to use vmware with Linux 2.6?  The kernel modules
>  > (obviously) fail to compile.
> 
> [...]
> 
>  Petr> And except that this patch makes thing compilable, it also makes
>  Petr> driver a bit friendlier to the MM subsystem, it allows you to use
>  Petr> VMware on 4G/4G host, and it properly handles bridged networking
>  Petr> on adapters using hardware (or pseudohardware...) Tx checksumming
>  Petr> (although only for IPv4 due to features of dev_queue_xmit_nit).
> 
> Does VMware roll these changes back in? This isn't cheap software, I
> feel they should care for Linux users a bit more.

Yes. Currently VMware's & mine code is identical except that mine
vmmon supports all released products since VMware 2.0.0 through VMware 
express, GSX & so on up to the VMware 4.0.2, while VMware's code supports 
only product it is shipped with. And you need C++ (for templates which are
used for generating code for different product versions) with mine code,
while you get one unwind template instance from VMware.

> For those who run VMware on notebooks with ACPI, another patch is
> necessary, otherwise ACPI C-states handling doesn't notice VMware and as
> a result the guest system is unbearably slow.

If this patch is for vmmon, can you share it with VMware (or with me
and I'll then share it with VMware) ? I cannot explain why ACPI does 
not notice that kernel is spending about 99% of time in the kernel, 
being very busy with hard work...

                                            Thanks,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                

