Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272385AbTGaFEV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 01:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272392AbTGaFEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 01:04:21 -0400
Received: from e166066.upc-e.chello.nl ([213.93.166.66]:21162 "EHLO
	hypnos.var.cx") by vger.kernel.org with ESMTP id S272385AbTGaFEU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 01:04:20 -0400
Date: Thu, 31 Jul 2003 07:04:17 +0200
From: Frank v Waveren <fvw@var.cx>
To: James Morris <jmorris@intercode.com.au>
Cc: linux-kernel@vger.kernel.org, Andries.Brouwer@cwi.nl,
       linux-crypto@nl.linux.org
Subject: Re: 2.6.0-test2+Util-linux/cryptoapi
Message-ID: <1059627605AME.fvw@tracks.var.cx>
References: <1059621603HIC.fvw@tracks.var.cx> <Mutt.LNX.4.44.0307311420080.21102-100000@excalibur.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Mutt.LNX.4.44.0307311420080.21102-100000@excalibur.intercode.com.au>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 02:39:45PM +1000, James Morris wrote:
> > Moving to the slightly more ontopic stuff for lk@vger: Is access to
> > the cryptoapi algorithms exposed to userspace yet?
> No, there is no point (apart from testing) unless the kernel API is 
> providing access to crypto hardware.
Even if we don't have the drivers yet, the sooner it's available and
in use the better, then we can always drop in hardware support later.
(Still, I'm not volunteering for either job so I won't complain, just
wondering if it had been done)

> > Thirdly, has the encryption setup changed again since 2.4.x with hvr's
> > testing cryptoapi stuff? I have a filesystem encrypted with 256 bits
> > serpent, yet it won't decrypt using 2.6.0-test2 and util-linux 2.12.
> The kerneli serpent implementation is incorrect (it's reversed, a common
> implementation problem with this algorithm).
Owch. But I assume this didn't sneak in since the testing cryptoAPI
patches? Or have the algorithms been redone?

> > Lastly: Why the move from a /proc/crypto directory containing files
> > for all the algorithms to one monolithic /proc/crypto file? Isn't the
> > former a lot nicer from the userspace programmer's point of view?
> Possibly, although it's probably too late to change now for 2.6.
But why was it ever changed to on big file in the first place?

-- 
Frank v Waveren                                      Fingerprint: 21A7 C7F3
fvw@[var.cx|stack.nl|chello.nl] ICQ#10074100            1FF3 47FF 545C CB53
Public key: hkp://wwwkeys.pgp.net/fvw@var.cx            7BD9 09C0 3AC1 6DF2
