Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317457AbSFCTF4>; Mon, 3 Jun 2002 15:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317459AbSFCTFz>; Mon, 3 Jun 2002 15:05:55 -0400
Received: from [195.39.17.254] ([195.39.17.254]:3487 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317457AbSFCTFK>;
	Mon, 3 Jun 2002 15:05:10 -0400
Date: Mon, 3 Jun 2002 18:45:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Does pci_alloc_consisent really need to zero memory?
Message-ID: <20020603164517.GA3320@elf.ucw.cz>
In-Reply-To: <200205301141.EAA15864@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >pci_alloc_consistent is so rare, I doubt it [clearing the memory it
> >returns] matters performance wise.
> 
> 	In my efforts to port almost all of the scsi drivers to your
> DMA-mapping interface, I have converted some kmalloc's that
> are frequently called with pci_alloc_consistent (I have not

...

maybe invent __pci_alloc_consistent which does no zeroing?
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
