Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWAOWzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWAOWzl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 17:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbWAOWzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 17:55:40 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:57349 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1750954AbWAOWzk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 17:55:40 -0500
To: Peter Osterlund <petero2@telia.com>
Cc: Phillip Susi <psusi@cfl.rr.com>, Damian Pietras <daper@daper.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Problems with eject and pktcdvd
References: <20060115123546.GA21609@daper.net> <43CA8C15.8010402@cfl.rr.com>
	<20060115185025.GA15782@daper.net> <43CA9FC7.9000802@cfl.rr.com>
	<m3ek39z09f.fsf@telia.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: there's a reason it comes with a built-in psychotherapist.
Date: Sun, 15 Jan 2006 22:55:22 +0000
In-Reply-To: <m3ek39z09f.fsf@telia.com> (Peter Osterlund's message of "15
 Jan 2006 20:48:38 -0000")
Message-ID: <87wth19k4l.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jan 2006, Peter Osterlund murmured:
> If you do
> 
> 	pktsetup 0 /dev/hdc
> 	mount /dev/hdc /mnt/tmp
> 	umount /mnt/tmp

> the door will be left in a locked state.

This is indeed what I see.

> 	pktsetup 0 /dev/hdc
> 	mount /dev/pktcdvd/0 /mnt/tmp
> 	umount /mnt/tmp
> 
> the door will be properly unlocked.

... and this.

... and my assumption that I couldn't mount non-packetwritten CDs via
the /dev/pktcdvd/0 device is entirely erroneous. So it all works after
all, as long as I never use the non-packetwritten device.

Oh *good*. Thank you for this: this was my last real thing that worked
better in 2.4 than in 2.6 :)))

> The problem is that the cdrom driver locks the door the first time the
> device is opened in blocking mode, but doesn't unlock it again until
> the open count goes down to zero. The pktcdvd driver tries to work
> around that, but it can't do it in the first example because the
> mount/umount commands do not involve the pktcdvd driver at all.

Yeah, well, it's obvious once you've explained it ;)

-- 
`Logic and human nature don't seem to mix very well,
 unfortunately.' --- Velvet Wood
