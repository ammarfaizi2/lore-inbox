Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136438AbREDQQe>; Fri, 4 May 2001 12:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136445AbREDQQY>; Fri, 4 May 2001 12:16:24 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:43888 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S136438AbREDQQK>; Fri, 4 May 2001 12:16:10 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com (Linus Torvalds),
        beamz_owl@yahoo.com (Edward Spidre),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
Subject: Re: Possible PCI subsystem bug in 2.4
In-Reply-To: <E14vhsG-0007Xe-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 May 2001 10:13:56 -0600
In-Reply-To: Alan Cox's message of "Fri, 4 May 2001 16:52:07 +0100 (BST)"
Message-ID: <m17kzxnlbv.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > There are a couple of options here.
> > 1) read the MTRRs unless the BIOS is braindead it will set up that area as
> >    write-back.  At any rate we shouldn't ever try to allocate a pci region
> >    that is write-back cached.
> 
> 'unless the BIOS is braindead'. Right. We only got into this problem because
> the BIOS _was_ braindead.

Well I did provide a suggestion so you don't have to second guess...
Usually it's actually easier to read the memory size from the northbridge
than to parse the E820 map.

However since it is different kinds of braindamage to mess up the MTRRs,
and the E820 memory map, it is worth a shot.  Personally I think MTRRs
are much easier to get right, because you don't need to take into
account what the BIOS is going to do just where your ram is.

As for braindead BIOS's in general any comments on totally nuking
them?  

Seriously.  With the general attitude of distrusting BIOS's I have
been amazed at the number of things linux expects the BIOS to get
right.  In practice windows seem to trust the BIOS much less than
linux does.

Eric
