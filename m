Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314546AbSGMPGz>; Sat, 13 Jul 2002 11:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314551AbSGMPGy>; Sat, 13 Jul 2002 11:06:54 -0400
Received: from users-vst.linvision.com ([62.58.92.114]:59273 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S314546AbSGMPGx>; Sat, 13 Jul 2002 11:06:53 -0400
Message-Id: <200207131509.RAA24969@cave.bitwizard.nl>
Subject: Re: Q: boot time memory region recognition and clearing.
In-Reply-To: <1026569717.9958.77.camel@irongate.swansea.linux.org.uk> from Alan
 Cox at "Jul 13, 2002 03:15:17 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sat, 13 Jul 2002 17:09:40 +0200 (MEST)
CC: Ishikawa <ishikawa@yk.rim.or.jp>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-notice: Read http://www.bitwizard.nl/cou.html for the licence to my Emailaddr.
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sat, 2002-07-13 at 11:08, Ishikawa wrote:
> > I have found that the particular motherboard (and memory sticks)
> > that I use at home tends to generate bogus memory problem 
> > warning messages when I use ecc module.
> > Motherboard is Gigabyte 7XIE4 that uses AMD751.
> > (Yes, AMD has now provides AMD76x series chipset for
> > newer CPUs.)
> > 
> > I say "bogus" because I have tested the hardware
> > many times using memtest86 and found that it doesn't
> > detect any memory errors even 
> 
> memtest86 isnt (except on the very very latest versions) aware of ECC.
> It sees the memory after the ECC rescues minor errors so if the RAM has
> errors but ECC just about saves you it will show up clean

A friend of mine had "subtle memory problems". He tested the memory
using memtest86. No errors running for hours. 

Then he did:
	bank1 = malloc (bignum); 
	bank2 = malloc (bignum); 
	srand (seed);
	bash (bank1);
	srand (seed); 
	bash (bank2); 

	if (memcmp (bank1, bank2) != 0)
		Memory error!

and quickly found a memory error on the first pass. 

It turns out you can memtest all you want, but different access
patterns may cause different errors. In some cases memtest86 doesn't
detect problems, while other stuff does.....

				Roger. 


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
