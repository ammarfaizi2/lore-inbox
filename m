Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265080AbTF2Xql (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 19:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265083AbTF2Xql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 19:46:41 -0400
Received: from ns.mock.com ([209.157.146.194]:42942 "EHLO mail.mock.com")
	by vger.kernel.org with ESMTP id S265080AbTF2Xqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 19:46:40 -0400
Message-Id: <5.1.0.14.2.20030629165324.03da7cf0@mail.mock.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 29 Jun 2003 17:00:57 -0700
To: Kurt Wall <kwall@kurtwerks.com>
From: Jeff Mock <jeff-ml@mock.com>
Subject: Re: PROBLEM: 2.4.21 ICH5 SATA related hang during boot
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030629232244.GB276@kurtwerks.com>
References: <5.1.0.14.2.20030629135412.03c1d940@mail.mock.com>
 <5.1.0.14.2.20030629135412.03c1d940@mail.mock.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-DCC-meer-Metrics: wobble.mock.com 1035; Body=2 Fuz1=2 Fuz2=2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:22 PM 6/29/2003 -0400, Kurt Wall wrote:
>Quoth Jeff Mock:
> >
> > I'm running a 2.4.21 kernel on a redhat 9.0 system.
> >
> > I'm having a problem when using serial ATA drives on an Intel 875P/ICH5
> > motherboard where the kernel will hang at approximately the same place
> > in the boot process about 25% of the time.
>
>[tale of woe elided]
>
>[lots of snippage]
>
> > 1: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4363  Sat
> > Apr 19 17:46:46 PDT 2003
>
>You won't get a lot of help here until you lose this module.
>
>
> > Linux agpgart interface v0.99 (c) Jeff Hartmann
> > agpgart: Maximum main memory to use for agp memory: 1919M
> > agpgart: Unsupported Intel chipset (device id: 2578), you might want to 
> try
> > agp_try_unsupported=1.
> > agpgart: no supported devices found.
> > 1: NVRM: AGPGART: unable to retrieve symbol table
>
>Hmm.

Guilty. The sad thing is that's just the tip of my politically
incorrect iceberg.

The nvidia driver (and the attempt at agpgart) is loaded when X
starts, long after the potential SATA related crash.  I changed my
default init level and rebooted a few times to verify the crash, so
I'm pretty sure that neither agpgart or the proprietary graphics driver
are involved in the problem.

jeff



