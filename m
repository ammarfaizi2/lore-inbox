Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWIZIHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWIZIHb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 04:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWIZIHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 04:07:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:13244 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750791AbWIZIH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 04:07:29 -0400
Subject: Re: [PATCH] restore libata build on frv
From: David Woodhouse <dwmw2@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Howells <dhowells@redhat.com>, Al Viro <viro@ftp.linux.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1159199184.11049.93.camel@localhost.localdomain>
References: <20060925142016.GI29920@ftp.linux.org.uk>
	 <1159186771.11049.63.camel@localhost.localdomain>
	 <1159183568.11049.51.camel@localhost.localdomain>
	 <20060924223925.GU29920@ftp.linux.org.uk>
	 <22314.1159181060@warthog.cambridge.redhat.com>
	 <5578.1159183668@warthog.cambridge.redhat.com>
	 <7276.1159186684@warthog.cambridge.redhat.com>
	 <20660.1159195152@warthog.cambridge.redhat.com>
	 <1159199184.11049.93.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 09:06:53 +0100
Message-Id: <1159258013.3309.9.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-25 at 16:46 +0100, Alan Cox wrote:
> Ar Llu, 2006-09-25 am 15:39 +0100, ysgrifennodd David Howells:
> > Why does the arch have to supply those numbers?  What's wrong with my
> > suggested patch?  According to code in libata, these are _legacy_ access
> > methods, and on FRV they aren't currently required, so why can't I dispense
> 
> "legacy, legacy, legacy" "wont wont wont"
> 
> The ports in question are PCI values. They come from the PCI
> specifications and apply to any device with PCI bus, unless it has
> special mappings. The same logic you are whining about is already partly
> handled in the generic pci quirks code, and in time will end up with the
> I/O port value fixups there anyway.
>
> See quirk_ide_bases in drivers/pci/quirks.c

If we can do that with PCI quirks, why the need to hard-code it in the
IDE driver too?

And IRQ zero isn't particularly helpful suggestion -- using an invalid
IRQ number would be better. Like NO_IRQ or IDE_NO_IRQ, which should be
-1.

Don't make me dig out the board where the PCI slots all get IRQ 0 :)

-- 
dwmw2

