Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271692AbRHUOWG>; Tue, 21 Aug 2001 10:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271694AbRHUOVq>; Tue, 21 Aug 2001 10:21:46 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60945 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271692AbRHUOVl>; Tue, 21 Aug 2001 10:21:41 -0400
Subject: Re: Qlogic/FC firmware
To: davem@redhat.com (David S. Miller)
Date: Tue, 21 Aug 2001 15:24:17 +0100 (BST)
Cc: jes@sunsite.dk, linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "David S. Miller" at Aug 21, 2001 06:58:09 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZCS1-0007xV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When the Qlogic,FC sees a master abort, the firmware is essentially
> cleared to zero.

None of the cards I have do this. Is this some kind of sparc specific
firmware problem ?

> If you're going to say "put the user thing in initrd", I'm going to
> say "bite me".  I build a static kernel with no initrd and that is how
> I'd like it to stay.  It is one thing to do initrd firmware loading
> for devices not necessary for booting and mounting root, that is
> acceptable, this isn't.

Why. What exactly is your argument ? Lets waste 128K of kernel space to keep
Dave happy. If the lack of proper boot time init on the sparc64 platform is
causing more problems then copy the firmware image out of the BIOS into the
card if sparc64 is defined.

And an initrd is the right answer. You free up the 128K of wasted space
using it.

Alan

