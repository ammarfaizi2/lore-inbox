Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLSNSn>; Tue, 19 Dec 2000 08:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130026AbQLSNSd>; Tue, 19 Dec 2000 08:18:33 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:9230 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129835AbQLSNSa>; Tue, 19 Dec 2000 08:18:30 -0500
Date: Tue, 19 Dec 2000 06:48:00 -0600
To: Kurt Garloff <garloff@suse.de>, "Theodore Y. Ts'o" <tytso@MIT.EDU>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: /dev/random: really secure?
Message-ID: <20001219064800.B980@cadcamlab.org>
In-Reply-To: <20001218213801.A19903@pcep-jamie.cern.ch> <200012182133.QAA02136@tsx-prime.MIT.EDU> <20001219124948.P17777@garloff.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001219124948.P17777@garloff.suse.de>; from garloff@suse.de on Tue, Dec 19, 2000 at 12:49:48PM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Kurt Garloff]
> It should not be world-writeable, IMHO. So the only one who can feed
> entropy there is root, who should know aht (s)he's doing ...

No, it is *good* to allow users to add entropy to the RNG pool, but it
is *bad* to assume that it is in fact entropy.

The beauty of cryptographic hashes is that the user can't *decrease*
the total entropy, even with 'cat /dev/zero > /dev/random'.  All he can
do by adding to the pool is *increase* your confidence that you do in
fact have at least the estimated amount of randomness.  The more
"untrusted" entropy you feed into the pool, the less it will matter (in
practical terms) if in the future a "trusted" source is compromised.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
