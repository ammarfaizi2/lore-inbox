Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWAEC4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWAEC4c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 21:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbWAEC4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 21:56:32 -0500
Received: from xproxy.gmail.com ([66.249.82.198]:30270 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751241AbWAEC4a convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 21:56:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NGEbFnso99b19sdT/YCY6Xvs9VAcSxG6c0wd7wG9FPk5pu9sHGz2iyXTEe5Xxh3kVin8/badLEhu59O0Z+wGLTgI4+YEbxkpqAuT5Kmwnzs8tx1Ar4klB4YnJopVzPkwSu20bLya0Ec9HjYWo8l3NVwZWBJio8ihs+UyZIMH4CA=
Message-ID: <4807377b0601041856n3a9f53e8uf03dc330190432ea@mail.gmail.com>
Date: Wed, 4 Jan 2006 18:56:29 -0800
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: Krzysztof Baranowski <kgb@dione.ids.pl>
Subject: Re: PCI DEVICE ID PROBLEM and Intel Intergrated eth card - a bios bug (?)
Cc: mj@ucw.cz, linux-kernel@vger.kernel.org,
       NetDEV list <netdev@vger.kernel.org>
In-Reply-To: <4807377b0601041854t4b1410fco5c307db6704e03f6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1755038059.20060105013532@dione.ids.pl>
	 <4807377b0601041854t4b1410fco5c307db6704e03f6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/06, Krzysztof Baranowski <kgb@dione.ids.pl> wrote:
<snip>
> After the upgrade my network card disappeared from both Linux and Win.
>
> After short investigation I noticed one strange incosistency. Under
> the new BIOS the PCI device is reported as PCI VENDOR ID 1459 (
> which is gigabyte) DEV_ID 1019. However Windows driver for this
> card (the lates from both intel and gigabyte) is looking for
> VENDOR_ID 8086 (intel).

IMO, gigabyte should not have changed the vendor id.  Effectively
they've said they will be the only ones supporting this hardware (not
intel).  Generally subvendor and subdevice ids should be the only
thing changed by OEMs.  Since it was changed by a bios upgrade i bet
its a bios bug and should be reported to gigabyte.

Until then you can hack your local kernel to get around it, but the
e1000 driver probably shouldn't change to support this device ID.

also, this is LKML and mentioning windows is just flame bait. :-)

jesse
