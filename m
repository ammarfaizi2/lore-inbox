Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277000AbRJKWaB>; Thu, 11 Oct 2001 18:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277011AbRJKW3w>; Thu, 11 Oct 2001 18:29:52 -0400
Received: from ip240.cvd2.rb1.bel.nwlink.com ([207.202.151.240]:35642 "EHLO
	zot.localdomain") by vger.kernel.org with ESMTP id <S277000AbRJKW3m>;
	Thu, 11 Oct 2001 18:29:42 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: mra@pobox.com (Mark Atwood),
        cfriesen@nortelnetworks.com (Christopher Friesen),
        linux-kernel@vger.kernel.org (Linux Kernel Development)
Subject: Re: Module read a file?
In-Reply-To: <E15roAI-000539-00@the-village.bc.nu>
From: Mark Atwood <mra@pobox.com>
Date: 11 Oct 2001 15:29:41 -0700
In-Reply-To: Alan Cox's message of "Thu, 11 Oct 2001 23:18:54 +0100 (BST)"
Message-ID: <m3adyxstd6.fsf@flash.localdomain>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> > Because the firmware is stored in volitile memory on the card, and
> > vanishes on a card reset or removal, and I would like to have it Just
> > Work with the pcmcia-cs package with minimal changes.
> 
> Longer term that is precisely what the hot plug interface is there fore

And in the longer term, I plan on migrating this product over to the
hot plug interface.

In the medium term, this will be a really useful feature for quite a
few users of this driver.

In the short term, I just want to get this thing working.

> 
> > Having to remember "run this userspace tool after every card reset"
> > (which includes power suspends and so forth) would be a major pain.
> > 
> > Besides, the card already has a good validator in it.
> 
> What do you do if the card is compiled in and initialised before the
> firmware holding fs is mounted ?

Tell the packager and/or user of the module Dont Do That, and have the
card_reset and card_insert functions return with an error.

-- 
Mark Atwood   | I'm wearing black only until I find something darker.
mra@pobox.com | http://www.pobox.com/~mra
