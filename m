Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbWIYPWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWIYPWZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 11:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWIYPWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 11:22:25 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:3467 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750957AbWIYPWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 11:22:25 -0400
Subject: Re: [PATCH] restore libata build on frv
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20660.1159195152@warthog.cambridge.redhat.com>
References: <20060925142016.GI29920@ftp.linux.org.uk>
	 <1159186771.11049.63.camel@localhost.localdomain>
	 <1159183568.11049.51.camel@localhost.localdomain>
	 <20060924223925.GU29920@ftp.linux.org.uk>
	 <22314.1159181060@warthog.cambridge.redhat.com>
	 <5578.1159183668@warthog.cambridge.redhat.com>
	 <7276.1159186684@warthog.cambridge.redhat.com>
	 <20660.1159195152@warthog.cambridge.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Sep 2006 16:46:23 +0100
Message-Id: <1159199184.11049.93.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-25 am 15:39 +0100, ysgrifennodd David Howells:
> Why does the arch have to supply those numbers?  What's wrong with my
> suggested patch?  According to code in libata, these are _legacy_ access
> methods, and on FRV they aren't currently required, so why can't I dispense

"legacy, legacy, legacy" "wont wont wont"

The ports in question are PCI values. They come from the PCI
specifications and apply to any device with PCI bus, unless it has
special mappings. The same logic you are whining about is already partly
handled in the generic pci quirks code, and in time will end up with the
I/O port value fixups there anyway.

See quirk_ide_bases in drivers/pci/quirks.c

Go read the specifications and stop whining about legacy ports and ISA
bus for things that are not.

Ack Al Viro's changes but with IRQ set to zero.

Alan
