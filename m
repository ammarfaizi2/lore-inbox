Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267517AbUJBTR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267517AbUJBTR4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 15:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267516AbUJBTR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 15:17:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:20171 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267517AbUJBTRx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 15:17:53 -0400
Date: Sat, 2 Oct 2004 12:17:48 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: CaT <cat@zip.com.au>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: promise controller resource alloc problems with ~2.6.8
In-Reply-To: <20041002045725.GC1049@zip.com.au>
Message-ID: <Pine.LNX.4.58.0410021211120.2301@ppc970.osdl.org>
References: <20040927084550.GA1134@zip.com.au> <Pine.LNX.4.58.0409301615110.2403@ppc970.osdl.org>
 <20040930233048.GC7162@zip.com.au> <Pine.LNX.4.58.0409301646040.2403@ppc970.osdl.org>
 <20041001103032.GA1049@zip.com.au> <Pine.LNX.4.58.0410010731560.2403@ppc970.osdl.org>
 <20041002045725.GC1049@zip.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 2 Oct 2004, CaT wrote:
> 
> > Can you send me your ioports from 2.6.9-rc3 _with_ the 
> > "request_resource()" change..
> 
> Diff says that the file is thesame as the one without patch+change
> that doesn't work.

That's really wrong. Hmm.. Can you enable debugging for the PCI resource 
stuff? It's DEBUG_CONFIG in drivers/pci/setup-res.c, and DEBUG in 
arch/i386/pci/pci.h, and now your dmesg should be a lot more verbose about 
the bootup resources..

Also (independently - I really do want to see the debug info) can you try
making the "drivers/pci/setup-res.c" version of "insert_resource()" be a
request_resource() too?

Thanks,

		Linus
