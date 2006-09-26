Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWIZIwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWIZIwe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 04:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWIZIwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 04:52:34 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:16102 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750742AbWIZIwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 04:52:33 -0400
Message-ID: <4518EA39.40309@pobox.com>
Date: Tue, 26 Sep 2006 04:52:09 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Howells <dhowells@redhat.com>,
       Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore libata build on frv
References: <20060925142016.GI29920@ftp.linux.org.uk>	 <1159186771.11049.63.camel@localhost.localdomain>	 <1159183568.11049.51.camel@localhost.localdomain>	 <20060924223925.GU29920@ftp.linux.org.uk>	 <22314.1159181060@warthog.cambridge.redhat.com>	 <5578.1159183668@warthog.cambridge.redhat.com>	 <7276.1159186684@warthog.cambridge.redhat.com>	 <20660.1159195152@warthog.cambridge.redhat.com>	 <1159199184.11049.93.camel@localhost.localdomain> <1159258013.3309.9.camel@pmac.infradead.org>
In-Reply-To: <1159258013.3309.9.camel@pmac.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> On Mon, 2006-09-25 at 16:46 +0100, Alan Cox wrote:
>> Ar Llu, 2006-09-25 am 15:39 +0100, ysgrifennodd David Howells:
>>> Why does the arch have to supply those numbers?  What's wrong with my
>>> suggested patch?  According to code in libata, these are _legacy_ access
>>> methods, and on FRV they aren't currently required, so why can't I dispense
>> "legacy, legacy, legacy" "wont wont wont"
>>
>> The ports in question are PCI values. They come from the PCI
>> specifications and apply to any device with PCI bus, unless it has
>> special mappings. The same logic you are whining about is already partly
>> handled in the generic pci quirks code, and in time will end up with the
>> I/O port value fixups there anyway.
>>
>> See quirk_ide_bases in drivers/pci/quirks.c
> 
> If we can do that with PCI quirks, why the need to hard-code it in the
> IDE driver too?
> 
> And IRQ zero isn't particularly helpful suggestion -- using an invalid
> IRQ number would be better. Like NO_IRQ or IDE_NO_IRQ, which should be
> -1.
> 
> Don't make me dig out the board where the PCI slots all get IRQ 0 :)

The irq is a special case no matter how we try to prettyify it.  We need 
two irqs, and PCI only gives us one per device.

	Jeff



