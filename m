Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965229AbVI0XDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965229AbVI0XDw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 19:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965231AbVI0XDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 19:03:52 -0400
Received: from magic.adaptec.com ([216.52.22.17]:1483 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S965229AbVI0XDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 19:03:51 -0400
Message-ID: <4339CFC7.6080507@adaptec.com>
Date: Tue, 27 Sep 2005 19:03:35 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <4339440C.6090107@adaptec.com>	 <20050927131959.GA30329@infradead.org>  <43395ED0.6070504@adaptec.com> <1127836380.4814.36.camel@mulgrave> <43399F17.4090004@adaptec.com> <4339ACDA.3090801@pobox.com> <4339BD58.7060300@adaptec.com> <4339C12C.5020004@pobox.com>
In-Reply-To: <4339C12C.5020004@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Sep 2005 23:03:44.0336 (UTC) FILETIME=[B59D8D00:01C5C3B7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/27/05 18:01, Jeff Garzik wrote:
> Luben Tuikov wrote:
> 
>>The driver and the infrastructure needs to go in.
>>
>>Give it exposure to the people, let people play with it.
> 
> 
> Merging into the upstream kernel is not necessary for exposure.
> 
> Historically, saying "no" to a single vendor pushing really hard -- as 
> you are doing -- has resulted in a superior solution.

This of course implies that everything in Linux is a
superiour solution _or_ if it is not, then everything in
linux is a vendor solution.

>>If we start "fixing" SCSI Core now (this in itself is JB red
>>herring), how long before it is "fixed" and we can "rest"?
>>And how long then before the driver and infrastructure
>>makes it in?
> 
> Just follow the recipe Christoph outlined.  It's not difficult, just 
> requires some work.

Anyone have a clear technical plan and/or infrastructure
on how to do this?  Any specs, plans, consolidations, etc?

I know its a wishful thinking, but when the architectures
differ, not sure how to do this.

"You can do everything with a big long if ()".

> So far, this is an Adaptec-only solution.

Yes, since Adaptec is the first company to come out with
open transport SAS chip.  Broadcom seems to be doing the same thing.
 
> It does an end run around 90% of the SCSI core.  You might as well make 
> it a block driver, if you're going to do that.

The "90%" part isn't quite true.

But going with a block device isn't that bad:
Now since the architecture _is_ SCSI after all, what would be
needed is a minimal, fast, straightforward, SAM/SPC fully complient
new SCSI Core.  That SCSI Core would register block devices
with the block layer.  Maybe Jens can point out cool things
to do and make the whole infrastructure fast and very fast.
(since we don't need to be bound by this legacy stuff)

Essentially other new technology LLDD and Transport layers
can probably make use of this: Infiniband, USB2 Storage, etc.

So if all you have is an AIC-94xx or BCM8603 storage chip
you can exclule all of the legacy SCSI Core and compile this
new mean, lean, fast SAM Core.

Jeff, this isn't bad at all!

Are you willing to contribute to such an effort?

Thanks,
	Luben

