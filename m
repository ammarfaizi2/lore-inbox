Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262813AbVCJSvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbVCJSvb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 13:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbVCJSrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 13:47:20 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:6021 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262877AbVCJSkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 13:40:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=JB5vo8n70hfaS0XhfysKJ3vIwnmPRgHlZITkk9agMfVf9/X6syPMFugFlEIDHLeSz3sSw9I5IlwQ7EKgCmKG2yjjMMprPEqOH6tc0zQlmgEUqEIDs67tKOvIeI8k17dsvnZ2v9M0HYXdP+/TZL09SvMMc4+NMeDRGcM2q9Bxnhs=
Message-ID: <9e4733910503101040b815916@mail.gmail.com>
Date: Thu, 10 Mar 2005 13:40:54 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: current linus bk, error mounting root
Cc: Jeff Garzik <jgarzik@pobox.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050310162918.GD2578@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050309210926.GZ28855@suse.de> <20050310075049.GA30243@suse.de>
	 <9e4733910503100658ff440e3@mail.gmail.com>
	 <20050310153151.GY2578@suse.de>
	 <9e473391050310074556aad6b0@mail.gmail.com>
	 <20050310154830.GB2578@suse.de>
	 <9e47339105031007595b1e0cc3@mail.gmail.com>
	 <20050310160155.GC2578@suse.de>
	 <9e4733910503100818df5fb2@mail.gmail.com>
	 <20050310162918.GD2578@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see:
Loading libata.ko module
Loading ata_piix.ko module
ACPI: PCI interupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 169
ata1: SATA max UDMA/133 cmd 0xFE00 ctl 0xFE12 bmdma 0xFEA0 irq 169
ata2: SATA max UDMA/133 cmd 0xFE20 ctl 0xFE32 bmdma 0xFEA0 irq 169
then raid autorun, one of the raid partitions is on /dev/sda

No panic on ata_piix load.
The panix is on killing init, it is the standard panix from not having
a root device.

I just built it in instead as a module, I'll try that next and see if
says anything different.
- Hide quoted text -


On Thu, 10 Mar 2005 17:29:19 +0100, Jens Axboe <axboe@suse.de> wrote:
> On Thu, Mar 10 2005, Jon Smirl wrote:
> > On Thu, 10 Mar 2005 17:01:55 +0100, Jens Axboe <axboe@suse.de> wrote:
> > > what are the major/minor numbers of /dev/root?
> >
> >
> > If I boot on a working system it is 8,5
>
> I see no /dev/sda detected in your system from the dmesg. Ahh this is
> where it panics on loading ata_piix I suppose, can't you capture that
> panic with the serial console as well?
>
> --
> Jens Axboe
>
>

- Hide quoted text -
--
Jon Smirl
jonsmirl@gmail.com
