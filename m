Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264605AbTLQXG3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 18:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264829AbTLQXG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 18:06:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26825 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264605AbTLQXG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 18:06:27 -0500
Date: Wed, 17 Dec 2003 18:06:17 -0500
From: Alan Cox <alan@redhat.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>,
       Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
       Gabriel Paubert <paubert@iram.es>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Martin Mares <mj@ucw.cz>, zaitcev@redhat.com, hch@infradead.org
Subject: Re: PCI Express support for 2.4 kernel
Message-ID: <20031217230617.GA10132@devserv.devel.redhat.com>
References: <3FDDACA9.1050600@intel.com> <1071494155.5223.3.camel@laptop.fenrus.com> <3FDDBDFE.5020707@intel.com> <Pine.LNX.4.58.0312151154480.1631@home.osdl.org> <3FDEDC77.9010203@intel.com> <Pine.LNX.4.58.0312160844110.1599@home.osdl.org> <3FDFF81F.7040309@intel.com> <Pine.LNX.4.58.0312162240040.8541@home.osdl.org> <3FDFFDEC.7090109@pobox.com> <20031217082235.GA24027@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031217082235.GA24027@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 17, 2003 at 09:22:35AM +0100, Arjan van de Ven wrote:
> > Any PCI-Ex drivers would obviously _know_ they are PCI Ex, and they 
> > could communicate that by virtue of simply using new functions.  Older 
> > drivers for older hardware would use the old API and not care... 
> > Further, PCI-Ex operations are already basically readl/writel anyway, so 
> > going through the forest of pci_cfg_ops pointers and such would just add 
> > needless layering.
> 
> BUT powermanagement and co will need to potentially do stuff too with the
> config space...

And X11 will want to access it via /proc interfaces. And someone will eventually
go and design a different way to access PCI-EX for their hardware 8)

The PCI layer is a nice abstraction and config space is slow anyway

