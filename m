Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRCHOnG>; Thu, 8 Mar 2001 09:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129066AbRCHOm4>; Thu, 8 Mar 2001 09:42:56 -0500
Received: from [213.203.46.68] ([213.203.46.68]:45833 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129051AbRCHOmn>; Thu, 8 Mar 2001 09:42:43 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.2 kernel mount crash
In-Reply-To: <E14b1Nh-000321-00@the-village.bc.nu>
From: remco@solbors.no (Remco B. Brink)
Organization: Norge-iNvest <http://www.norge-invest.no>
Date: 08 Mar 2001 15:41:12 +0100
Message-ID: <m366hkuxvb.fsf@localhost.localdomain>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > I used kgcc to compile the kernel, did not get any of the RH7 gcc warning messages
> > and still am left with a not-so-stable mount.
> 
> Its certainly worth building with kgcc as well to make sure, and in this case
> it looks like the problem is really in the kernel proper

Actually the mount process behaves in exactly the same way as my emacs process
as mentioned in an earlier post (topic: "process with connection in CLOSE_WAIT won't 
die in 2.4.2").

It'll stay in the proceslist regardless of what kill signal is sent to it
and appears to be (and very much _stay_) in un-interuptable sleep.

The same can be said for the various mount processes, both when mounting
loopback and scsi devices.

Another thing that struck me as weird was that after all the problems
with the mount and emacs process, trying to unmount a NFS share was not
possible even though the NFS server had no problems whatsoever mounting
new shares.

regards,
Remco

-- 
Remco B. Brink                                  Norge-iNvest AS
Kung foo                            http://www.norge-invest.com
        PGP/GnuPG key at http://remco.xgov.net/rbb.pgp

In most countries selling harmful things like drugs is punishable.
Then howcome people can sell Microsoft software and go unpunished?
(By hasku@rost.abo.fi, Hasse Skrifvars)
