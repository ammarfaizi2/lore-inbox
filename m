Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265373AbUGDS3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265373AbUGDS3E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 14:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265454AbUGDS3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 14:29:04 -0400
Received: from smtp07.web.de ([217.72.192.225]:51854 "EHLO smtp07.web.de")
	by vger.kernel.org with ESMTP id S265373AbUGDS26 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 14:28:58 -0400
From: Bernd Schubert <bernd-schubert@web.de>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: 2.6.7: sk98lin unload oops
Date: Sun, 4 Jul 2004 20:28:53 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200407041342.18821.bernd-schubert@web.de> <20040704151509.GA5100@infradead.org>
In-Reply-To: <20040704151509.GA5100@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407042028.59047.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christoph,

On Sunday 04 July 2004 17:15, Christoph Hellwig wrote:
> > Fortunality everything still works fine (I'm running the script over the
> > network of the syskonnect cards).
> >
> > This machine has two of those syskonnect cards, on another machine which
> > has only one syskonnect card this oops doesn't occur.
>
> As a colleteral damage the following huge patch should fix it, and I need
> testers for it anyway ;-)
>

thanks for your patches, but I have some trouble to apply them:


hamilton1:/usr/src/linux-2.6.7# cat ../patches/sk98/sk98_patch1.txt |patch -p1
patching file drivers/net/sk98lin/skge.c
Hunk #5 succeeded at 4906 (offset -1 lines).
patching file drivers/net/sk98lin/h/skdrv2nd.h
Reversed (or previously applied) patch detected!  Assume -R? [n]

Either option I will give here, it will always fail to compile with those 
messages:

drivers/net/sk98lin/skge.c:5166: `PCI_VENDOR_ID_DLINK' undeclared here (not in 
a function)
drivers/net/sk98lin/skge.c:5166: initializer element is not constant
drivers/net/sk98lin/skge.c:5166: (near initialization for 
`skge_pci_tbl[4].vendor')
drivers/net/sk98lin/skge.c:5173: `PCI_VENDOR_ID_CNET' undeclared here (not in 
a function)
drivers/net/sk98lin/skge.c:5173: initializer element is not constant
drivers/net/sk98lin/skge.c:5173: (near initialization for 
`skge_pci_tbl[7].vendor')
drivers/net/sk98lin/skge.c:5174: `PCI_VENDOR_ID_LINKSYS' undeclared here (not 
in a function)
drivers/net/sk98lin/skge.c:5174: initializer element is not constant
drivers/net/sk98lin/skge.c:5174: (near initialization for 
`skge_pci_tbl[8].vendor')
drivers/net/sk98lin/skge.c:5175: `PCI_VENDOR_ID_LINKSYS' undeclared here (not 
in a function)
drivers/net/sk98lin/skge.c:5175: initializer element is not constant
drivers/net/sk98lin/skge.c:5175: (near initialization for 
`skge_pci_tbl[9].vendor')

Is your patch for vanilla 2.6.7?

Thanks,
	Bernd

