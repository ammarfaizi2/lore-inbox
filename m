Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129038AbQJ0Nln>; Fri, 27 Oct 2000 09:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129084AbQJ0Nle>; Fri, 27 Oct 2000 09:41:34 -0400
Received: from styx.suse.cz ([195.70.145.226]:1521 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129038AbQJ0Nl1>;
	Fri, 27 Oct 2000 09:41:27 -0400
Date: Fri, 27 Oct 2000 15:41:22 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: bart@etpmod.phys.tue.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible critical VIA vt82c686a chip bug (private question)
Message-ID: <20001027154122.A923@suse.cz>
In-Reply-To: <20001026173244.B8290@suse.cz> <200010271205.OAA31607@gum04.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200010271205.OAA31607@gum04.etpnet.phys.tue.nl>; from bart@etpmod.phys.tue.nl on Fri, Oct 27, 2000 at 02:04:58PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2000 at 02:04:58PM +0200, bart@etpmod.phys.tue.nl wrote:

> > Interesting. If it's caused by SCSI as well (might be), then it's not
> > caused by heavy IDE activity but rather than that it could be heavy
> > BusMastering activity instead (The IDE chip does BM as well).
> > 
> > I'm still wondering if it could be a Linux kernel bug (bad/concurrent
> > accesses to the i8253 registers), this has to be checked.
> > 
> 
> How sure are you that the chip is actually buggy? I ran into something
> similar a while ago, when I mixed the two arguments to an outb in a driver, 
> and ended up writing MYPORT into the timer instead of 0x40 into MYPORT.

I'm *not* sure. It just looks like a reasonable explanation. It doesn't
happen on Intel chips and older VIA chips, it only happens on new VIA
chips, and the code is the same all the time. Also, it happens both with
2.2 and 2.4 kernels ...

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
