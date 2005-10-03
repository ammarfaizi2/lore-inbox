Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbVJCQRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbVJCQRk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 12:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbVJCQRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 12:17:40 -0400
Received: from magic.adaptec.com ([216.52.22.17]:12523 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932274AbVJCQRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 12:17:38 -0400
Message-ID: <4341599D.70904@adaptec.com>
Date: Mon, 03 Oct 2005 12:17:33 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Arjan van de Ven <arjan@infradead.org>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>, andrew.patterson@hp.com,
       dougg@torque.net, Linus Torvalds <torvalds@osdl.org>,
       Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01A9FA11@otce2k03.adaptec.com>	 <1128102837.3012.15.camel@laptopd505.fenrus.org> <1128210952.17099.73.camel@localhost.localdomain>
In-Reply-To: <1128210952.17099.73.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Oct 2005 16:17:34.0705 (UTC) FILETIME=[F6A97610:01C5C835]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/05 19:55, Alan Cox wrote:
> On Gwe, 2005-09-30 at 19:53 +0200, Arjan van de Ven wrote:
> 
>>that makes me wonder... why and how does T10 control linux abi's ??
> 
> 
> Indirectly the standards do define APIs at the very least. A good
> example is taskfile. ACPI methods (which we don't yet use) allow get/set
> mode, get features on the motherboard ATA controller if you don't know
> how to drive it. The objects they work in are taskfiles. No taskfiles,
> no ACPI.

Yes, that's true.

Even more is true.  Standards and specs define the
_layering infrastructure_ which if implemented, 
allows for layer intersection.

For example, if one needs to insert a SATL later just because
the underlaying transport was found able to transport it,
since the layering is well defined and _so_ implemented, it wouldn't
be hard to interface antother well defined layer in.

If, OTOH, things are conglomerated into a blob, just because
the kernel engineers (not (storage) engineers per se) found _no_ current
use of the layering infrastructure and separating the layers
was found do add  "more maintenance", then this will turn around
sooner or later to bite back.

After all, things are what they are.

	Luben

