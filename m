Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131645AbRALTtw>; Fri, 12 Jan 2001 14:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132138AbRALTtm>; Fri, 12 Jan 2001 14:49:42 -0500
Received: from styx.suse.cz ([195.70.145.226]:32242 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S131645AbRALTtd>;
	Fri, 12 Jan 2001 14:49:33 -0500
Date: Fri, 12 Jan 2001 20:49:32 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Tobias Ringstrom <tori@tellus.mine.nu>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 ate my filesystem on rw-mount
Message-ID: <20010112204932.B2740@suse.cz>
In-Reply-To: <Pine.LNX.4.30.0101120951270.7175-100000@svea.tellus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101120951270.7175-100000@svea.tellus>; from tori@tellus.mine.nu on Fri, Jan 12, 2001 at 10:15:45AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 10:15:45AM +0100, Tobias Ringstrom wrote:
> I've never seen anything like it before, which I'm happy for.  The system
> had been running a standard RedHat 7 kernel for days without any problems,
> but who wants to run a 2.2 kernel?  I compiled 2.4.0 for it, rebooted, and
> blam!  The RedHat init stripts got to the "remounting root read-write"
> point, and just froze solid.
> 
> Rebooting into RH7 failed, becauce inittab could not be found.  In fact
> the filesystem was completely messed up, with /dev empty, lots of device
> nodes in /etc, and files missing all over the place.  I had to reinstall
> RH7 from scratch.
> 
> I do not understand how this could happen during a remounting root rw.
> Is the filesystem really that unstable?
> 
> Am I right in suspecting DMA, which was enabled at the time?  Any other
> ideas?  Is it a known problem?
> 
> This is on a 450 MHz AMD-K6 with the following IDE controller:
> 
> 00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
> 
> [I know this is not a very good trouble report, but it will have to do for
> the time beeing.  I hope to do more testing at a later time.]
> 
> /Tobias
> 
> PS. This is _not_ the same system that I reported IDE busy errors for.

Wow. Ok, I'm maintaining the 2.4.0 VIA driver, so I'd like to know more
about this:

1) What's the ISA bridge revision?
2) What's in /proc/ide/via?
3) What says hdparm -i on your devices?
4) If you mount your filesystem read-only, does it read garbage?

Thanks.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
