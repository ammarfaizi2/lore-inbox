Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbVKNIWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbVKNIWx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 03:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbVKNIWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 03:22:53 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:50118 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750995AbVKNIWw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 03:22:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UUSpYR2jd8xiol/Qb6NW/K/yiSVTB9ozrmO44sOLSH1TH2k+tX8J7D6qxGtSvVX8G+XcXxe7pQScP9g06Y35rA1AHtaz+JNRst44AQgi/I/+fuOf1NvzY3jq8B0Onz/l7YCeEgUPrJnUN1l25LKPaujk9xcPHmq/6HXvu7ODBtg=
Message-ID: <7a37e95e0511140022y6681240bie7dabe5e87f5563@mail.gmail.com>
Date: Mon, 14 Nov 2005 13:52:51 +0530
From: Deven Balani <devenbalani@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: reference code for non-PCI libata complaint SATA for ARM boards.
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <435E6D55.7090903@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7a37e95e0510250511g631db9edoe4c739ed24b7a79b@mail.gmail.com>
	 <1130254633.25191.33.camel@localhost.localdomain>
	 <435E6D55.7090903@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff

In your previous mail you've mentioned that:

>An out-of-tree driver for a non-PCI embedded board exists, and works
>100%.  Use of struct device and dma_xxx() means it is bus-agnostic.
>That's how the whole system was designed to work -- and work, it does.

Can I just have a patch or link to the said out-of-tree code?

Thanks,
Deven


On 10/25/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> Alan Cox wrote:
> > On Maw, 2005-10-25 at 17:41 +0530, Deven Balani wrote:
> >
> >>Hi All!
> >>
> >>I am currently writing a low-level driver for non-PCI SATA controller
> >>in ARM platform.which uses libata-core.c for linux-2.4.25. Can any one
> >>tell me any reference code available under linux.
> >
> >
> > At the moment its a bit hard to do a non PCI driver because the core
> > code assumes that there is a device structure (or pci_dev structure) for
> > everything. Fixing that is a two line change for 2.6 (probably similar
> > for 2.4) but Jeff Garzik rejected it.
>
> In 2.6.x, libata needs no fixes to support non-PCI devices.
>
> An out-of-tree driver for a non-PCI embedded board exists, and works
> 100%.  Use of struct device and dma_xxx() means it is bus-agnostic.
> That's how the whole system was designed to work -- and work, it does.
>
> None of this is true in 2.4.x, of course...
>
>        Jeff
>
>
--
"A smile confuses an approaching frown..."
