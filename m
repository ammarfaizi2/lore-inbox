Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbTJ2Uh2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 15:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbTJ2Uh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 15:37:27 -0500
Received: from harddata.com ([216.123.194.198]:61420 "EHLO mail.harddata.com")
	by vger.kernel.org with ESMTP id S261555AbTJ2Uh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 15:37:26 -0500
Message-Id: <5.1.1.6.0.20031029125436.03dcd050@mail.harddata.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Wed, 29 Oct 2003 13:38:40 -0700
To: Andi Kleen <ak@muc.de>
From: Mark Lane <mark@harddata.com>
Subject: Re: 2.4.22 and Athlon64
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3llr3zv98.fsf@averell.firstfloor.org>
References: <M4ba.8dv.3@gated-at.bofh.it>
 <M4ba.8dv.3@gated-at.bofh.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:41 PM 10/29/03, Andi Kleen wrote:
>Mark Lane <mark@harddata.com> writes:
>
> > I am having trouble compiling the 2.4.22 kernel for x86-64 non-smp. I
> > can compile the smp kernel but not the regular kernel.
>
>2.4.22 broke the ACPI compilation in the last minute. You can either
>disable ACPI or apply ftp://ftp.x86-64.org/pub/linux/v2.4/acpi-2.4.22-hotfix

Yeah I have tried compiling with ACPI off. This is not my problem.


> > It seems that ksyms.c for x86-64 is looking for some smp stuff from
> > the errors I am getting.
> >
> > I have tried 2.4.23-8 and the problem seems gone but I get an error
> > when linking fs/fs.o into vmlinux. I have attached the errors I
> > received.
>
>fs/fs.o(.text+0x1429f): In function `dput':
>: undefined reference to `atomic_dec_and_lock'
>
>either your tree is unclean (do a make mrproper and try again)
>or your compiler does not properly inline. What compiler are you using?

make mrproper worked thanks
-- 
Mark Lane, CET  mailto:mark@harddata.com
Hard Data Ltd.  http://www.harddata.com
T: 01-780-456-9771      F: 01-780-456-9772
11060 - 166 Avenue Edmonton, AB, Canada, T5X 1Y3
--> Ask me about our Excellent 1U Systems! <--

