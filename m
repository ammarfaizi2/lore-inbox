Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbULWLGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbULWLGU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 06:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbULWLGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 06:06:20 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:38013 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261206AbULWLGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 06:06:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=HVwz6tUPDS31V+qV3mL91u3YIiJPqef0/d/TEAUvYnso6zbloZBMv15KBUAD73pyFcvD0HnCkgI08Fy8BChoSQrjALY5GNi24OZf2tJMpcRDvfkfqVed1kM1zJfv3cv+I2AbpxjrdLE8AEI7j1abV4pZJ3BaeLC79T9YrATdJEg=
Message-ID: <641bfad604122303067e4974c7@mail.gmail.com>
Date: Thu, 23 Dec 2004 13:06:17 +0200
From: Edward Broustinov <edichka@gmail.com>
Reply-To: Edward Broustinov <edichka@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Can't activate dma on ide/sata under 2.6.5/9 + Intel E7520 chipset
In-Reply-To: <41C9D679.70209@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1103708275.570197.31660@z14g2000cwz.googlegroups.com>
	 <20041222094014.B5A1E5F727@attila.bofh.it>
	 <641bfad604122201527736eca6@mail.gmail.com> <41C9D679.70209@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2004 15:18:01 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> Edward Broustinov wrote:
> > Hi,
> > hdparm -d1 /dev/hda (or /dev/sda) returns "HDIO_SET_DMA failed:
> > Operation not permitted" on both disks.
> > Is it possible that there's no (full?) support for ICH5-R in those kernels?
> > The motherboard is Intel SE7520BD2, exact kernel versions which were
> > tried are:
> > 2.6.9-1.667smp #1 SMP Tue Nov 2 15:09:11 EST 2004 x86_64 x86_64 x86_64
> > GNU/Linux (FC3 64bit)
> > 2.6.5-1.358smp #1 SMP Sat May 8 09:28:14 EDT 2004 x86_64 x86_64 x86_64
> > GNU/Linux (FC2 64bit)
> >
> > 2.4.21/22 (RH9) and 2.6.7* (AS3.0) do not show this problem on the board.
> >
> > Does anybody have any idea/patch/hack?
> 
> If you are using libata (/dev/sdX), then DMA is unconditionally enabled.
> 
>         Jeff
> 
I'm pretty sure I do use libata, because /dev/sda is present, and I
see libata in 'lsmod' output.
I was wrong in my previous post. /dev/sda has dma enabled indeed, like
you said. I get this error only when I try to set dma on /dev/hda
disk.
I took vanilla 2.6.9 from kernel.org, compiled in nearly everything I
could just relate to IDE/ATA thing - no luck. I then took 2.6.10.rc3
and got the same result.
What am I missing here?

Please help,
Ed.
