Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933938AbWKTPl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933938AbWKTPl7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 10:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933940AbWKTPl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 10:41:59 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:19886 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S933938AbWKTPl7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 10:41:59 -0500
Date: Mon, 20 Nov 2006 15:47:29 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: first proposal for pci resume quirk interface
Message-ID: <20061120154729.45003599@localhost.localdomain>
In-Reply-To: <20061120152041.GA4199@ucw.cz>
References: <20061114175510.6e7c7119@localhost.localdomain>
	<20061120152041.GA4199@ucw.cz>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006 15:20:41 +0000
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> Looks okay to me.
> 
> 
> >  #define DECLARE_PCI_FIXUP_ENABLE(vendor, device, hook)			\
> >  	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_enable,			\
> >  			vendor##device##hook, vendor, device, hook)
> > +#define DECLARE_PCI_FIXUP_RESUME(vendor, device, hook)			\
> > +	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_resume,			\
> > +			resume##vendor##device##hook, vendor, device, hook)
> 
> Maybe having DECLARE_PCI_FIXUP_ALWAYS (meaning ENABLE+RESUME)  would reduce the code
> duplication?

There is almost no duplication if you actually look at the output of the
code. It simply generates entries into two jump/match tables. Doing a
PCI_FIXUP for both is ugly because of the ordering requirements.

Alan
