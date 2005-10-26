Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932550AbVJZF6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbVJZF6M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 01:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbVJZF6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 01:58:12 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:13840 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932550AbVJZF6L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 01:58:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CWls3U0FU7hR/ZrguR5uJmBjUN/8Ijos48KQaqfLvmeI8wJyP69n16mbrr7XvAu/vfqGe3uIGJP9DqHzsmSRWWBbHbhXoh0xP04xO5Jfohr6Tgrux7y7bTEUvsCxCGUEBfsqvD/pVq9QFuDKMiN8w6deBLCulKqdMVV6K1RsSgw=
Message-ID: <7a37e95e0510252258k621b46efj4d37c2ceed00dfeb@mail.gmail.com>
Date: Wed, 26 Oct 2005 11:28:10 +0530
From: Deven Balani <devenbalani@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: reference code for non-PCI libata complaint SATA for ARM boards.
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
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

Hi jeff,

Thank you for your quick reply.

According to your mail I believe I had to write a SATA low-level
driver only for
2.6 kernels.

But I have a problem my other drivers are 2.4.25 compliant. So it is a huge work
to make all other drivers 2.6 compliant and use libata-core.c.
I believe it is far more easier to have 2.4.x libata rather than
porting my drivers to
2.6.x.

What do you suggest me ?

Regards,
balani

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
>


--
"A smile confuses an approaching frown..."
