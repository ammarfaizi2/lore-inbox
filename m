Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267148AbRG2LQ5>; Sun, 29 Jul 2001 07:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267187AbRG2LQr>; Sun, 29 Jul 2001 07:16:47 -0400
Received: from ns.caldera.de ([212.34.180.1]:11933 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S267148AbRG2LQi>;
	Sun, 29 Jul 2001 07:16:38 -0400
Date: Sun, 29 Jul 2001 13:16:38 +0200
Message-Id: <200107291116.f6TBGcK13689@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: kiwiunixman@yahoo.co.nz (Matthew Gardiner)
Cc: linux-kernel@vger.kernel.org (kernel)
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <01072902183404.02683@kiwiunixman.nodomain.nowhere>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In article <01072902183404.02683@kiwiunixman.nodomain.nowhere> you wrote:
> I've noticed that in the menuconfig there is support for the Vertias 
> Journalling File System. Has there been any push for that to be a "bootable" 
> filesystem so it can be used for Linux?

I don't see any reason wht it shoudn't be bootable, I just haven't tested it
yet.  If you want to try it, please follow the below steps:

1) Get one of these CD-ROM readonly distribution
2) Copy it over NFS to a UnixWare (or any other x86 System with VxFS)
3) Make a VxFS system big enough for the distribution
4) Copy the Distribution on the VxFS filesystem

And now the difficult part:

5) Adjust the ondisk dev_t to match Linux's major/minor split instead
   of SVR4's.  This can either be done by creating (bogus) SVR4 device
   nodes that are valid Linux ones when read by Linux or by doing this
   with fsdb after they were created.

If you have success with this sppropeach please drop me a mail - I'll add
it to the freevxfs docs then.

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
