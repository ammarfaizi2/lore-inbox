Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266669AbUJDMVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266669AbUJDMVb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 08:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267356AbUJDMVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 08:21:31 -0400
Received: from centaur.acm.jhu.edu ([128.220.223.65]:33206 "EHLO
	centaur.acm.jhu.edu") by vger.kernel.org with ESMTP id S267504AbUJDMVU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 08:21:20 -0400
Date: Mon, 4 Oct 2004 08:21:20 -0400
From: Jack Lloyd <lloyd@randombit.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: mlock(1)
Message-ID: <20041004122120.GG664@acm.jhu.edu>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <41547C16.4070301@pobox.com> <20040924132247.W1973@build.pdx.osdl.net> <1096060045.10800.4.camel@localhost.localdomain> <20040924225900.GY3309@dualathlon.random> <1096069581.3591.23.camel@desktop.cunninghams> <20040925010759.GA3309@dualathlon.random> <1096114881.5937.18.camel@desktop.cunninghams> <20040925145315.GJ3309@dualathlon.random> <20040928084850.GA18819@elf.ucw.cz> <20040930174244.GL22008@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040930174244.GL22008@dualathlon.random>
X-GPG-Key-ID: 4DCDF398
X-GPG-Key-Fingerprint: 2DD2 95F9 C7E3 A15E AF29 80E1 D6A9 A5B9 4DCD F398
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 07:42:44PM +0200, Andrea Arcangeli wrote:
> > 
> > Actually, better solution probably is to encrypt 32-bit zero.
> > 
> > Then, you have 1:2^32 probability of accepting wrong password, still
> > if you try to brute-force it, you'll find many possible passwords.
> 
> this is just the first step an attacker needs to rule out all the
> impossible passwords and extend the crack to the other known bits. I
> don't think it's secure. My suggestion OTOH sounds completely secure
> (though much harder to implement).

PGP actually uses a similiar techinique (80 bits of randomness, with bytes 9+10
being repeats of 7+8) to check for bad decrypts. With 16 bits of checksum, the
attacker only is able to eliminate about (2^16-1)/2^16 of the keys, which seems
like a lot, but only reduces the keylength by 16 bits. If you're using
reasonably sized keys (>=128 bits) that's not a problem because the remaining
keyspace is still much larger than the set of likely passphrases (even quite
good passphrases rarely get over 80 or 90 bits of entropy).

-Jack
