Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129092AbRBAAAh>; Wed, 31 Jan 2001 19:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129133AbRBAAA2>; Wed, 31 Jan 2001 19:00:28 -0500
Received: from [195.71.115.196] ([195.71.115.196]:63985 "HELO
	demdwug7.mediaways.net") by vger.kernel.org with SMTP
	id <S129092AbRBAAAT>; Wed, 31 Jan 2001 19:00:19 -0500
Date: Thu, 1 Feb 2001 01:01:40 +0100 (CET)
From: Martin Diehl <mdiehlcs@compuserve.de>
To: davej@suse.de
cc: Linus Torvalds <torvalds@transmeta.com>, becker@scyld.com,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] minor ne2k-pci irq fix
In-Reply-To: <Pine.LNX.4.31.0101311207150.20199-100000@athlon.local>
Message-ID: <Pine.LNX.4.21.0102010039290.2065-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001 davej@suse.de wrote:

> I think it would be better to move the pci_enable_device(pdev);
> above all this, as we should enable the device before reading the
> pdev->resource[] too iirc.

Probably I've missed this because the last time I hit such a thing was
when my ob800 bios mapped the cardbus memory BAR's into bogus legacy
0xe0000 area. Hence there was good reason to read and correct this before
trying to enable the device.
The normal case however would be like you've suggested, IMHO.

BTW, will it ever happen the kernel starts remapping BAR's when enabling
devices?

Regards
Martin


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
