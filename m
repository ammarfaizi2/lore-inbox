Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314338AbSEIUsP>; Thu, 9 May 2002 16:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314343AbSEIUsO>; Thu, 9 May 2002 16:48:14 -0400
Received: from [195.63.194.11] ([195.63.194.11]:21509 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314338AbSEIUsO>; Thu, 9 May 2002 16:48:14 -0400
Message-ID: <3CDAD1C0.9090406@evision-ventures.com>
Date: Thu, 09 May 2002 21:45:04 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        James Bottomley <James.Bottomley@steeleye.com>, mochel@osdl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] PCI reorg fix
In-Reply-To: <20020509165234.GA17627@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Greg KH napisa?:
> Linus,
> 
> James pointed out that pci_alloc_consistent() and pci_free_consistent()
> are allowed to be called, even if CONFIG_PCI is not enabled.  So this
> changeset moves these calls back into the arch/i386/kernel directory.
> 
> Pull from:  bk://linuxusb.bkbits.net/linux-2.5-pci
> 
> As a side note, I don't think that any pci_* function should be able to
> be called by non-pci drivers.  Is it worth spending the time now in 2.5
> to make these two functions not rely on 'struct pci_dev' and fix up all
> of the drivers and architectures and documentation to reflect this?
> Possible names would be alloc_consistent() and free_consistent()?

If your are at it: I was always itching my had what
pci_alloc_inconsistent and pci_free_inconsistent is supposed to be?
Negating semantically the consistent attribute shows nicely
that the _consistent is a bad nomenclatures. Perhaps something
more related to the purpose of it would help. Like

ioalloc() and iofree()

Could be even abstracted from the bus implementation.

And of course much less typing...


