Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266472AbRGCIH2>; Tue, 3 Jul 2001 04:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266473AbRGCIHS>; Tue, 3 Jul 2001 04:07:18 -0400
Received: from t2.redhat.com ([199.183.24.243]:60662 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S266472AbRGCIHD>; Tue, 3 Jul 2001 04:07:03 -0400
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: David Howells <dhowells@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] I/O Access Abstractions 
In-Reply-To: Message from Jeff Garzik <jgarzik@mandrakesoft.com> 
   of "Tue, 03 Jul 2001 04:00:09 EDT." <3B417B89.6FE1D06A@mandrakesoft.com> 
Date: Tue, 03 Jul 2001 09:07:02 +0100
Message-ID: <3938.994147622@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> David Howells wrote:
> > For example, one board I've got doesn't allow you to do a straight
> > memory-mapped I/O access to your PCI device directly, but have to
> > reposition a window in the CPU's memory space over part of the PCI memory
> > space first, and then hold a spinlock whilst you do it.
> 
> Yuck.  Does that wind up making MMIO slower than PIO, on this board?

The mapping is not symmetrical (things on the PCI bus can see more of the CPU
bus at any one time than the reverse, so DMA isn't a problem), and at the
moment I have only one device on it that I'm actually using (the ethernet
chipset).

David
