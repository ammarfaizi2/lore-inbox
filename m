Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132906AbQLIAup>; Fri, 8 Dec 2000 19:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132996AbQLIAuf>; Fri, 8 Dec 2000 19:50:35 -0500
Received: from feral.com ([192.67.166.1]:43608 "EHLO feral.com")
	by vger.kernel.org with ESMTP id <S132906AbQLIAuX>;
	Fri, 8 Dec 2000 19:50:23 -0500
Date: Fri, 8 Dec 2000 16:19:45 -0800 (PST)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: mjacob@feral.com
To: Andi Kleen <ak@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, baettig@scs.ch,
        linux-kernel@vger.kernel.org
Subject: Re: io_request_lock question (2.2)
In-Reply-To: <20001209011457.A30226@gruyere.muc.suse.de>
Message-ID: <Pine.BSF.4.21.0012081618440.72881-100000@beppo.feral.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 
> > On Fri, 8 Dec 2000, Alan Cox wrote:
> > 
> > > > Yes, and I believe that this is what's broken about the SCSI midlayer. The the
> > > > io_request_lock cannot be completely released in a SCSI HBA because the flags
> > > 
> > > You can drop it with spin_unlock_irq and that is fine. I do that with no
> > > problems in the I2O scsi driver for example
> > 
> > I am (like, I think I *finally* got locking sorta right in my QLogic driver),
> > but doesn't this still leave ints blocked for this CPU at least?
> 
> spin_unlock_irq() does a __sti()
> spin_unlock() doesn't. 

Umm. Okay, but you haven't changed your processor priority though, right?
(I just don't *get* i386 stuff... I'll go off and ponder SParc code - &that& I
understand).

-matt


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
