Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271717AbRHQVTZ>; Fri, 17 Aug 2001 17:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271714AbRHQVTN>; Fri, 17 Aug 2001 17:19:13 -0400
Received: from SNAP.THUNK.ORG ([216.175.175.173]:48132 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S271694AbRHQVTE>;
	Fri, 17 Aug 2001 17:19:04 -0400
Date: Fri, 17 Aug 2001 17:18:35 -0400
From: Theodore Tso <tytso@mit.edu>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: Steve Hill <steve@navaho.co.uk>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: /dev/random in 2.4.6
Message-ID: <20010817171834.A24850@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Andreas Dilger <adilger@turbolinux.com>,
	Steve Hill <steve@navaho.co.uk>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0108151622570.2107-100000@sorbus.navaho> <200108151713.f7FHDg0n013420@webber.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <200108151713.f7FHDg0n013420@webber.adilger.int>; from adilger@turbolinux.com on Wed, Aug 15, 2001 at 11:13:41AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2001 at 11:13:41AM -0600, Andreas Dilger wrote:
> Note that network interrupts do NOT normally contribute to the entropy
> pool.  This is because of the _very_theoretical_ possibility that an
> attacker can "control" the network traffic to such a precise extent as
> to flush or otherwise contaminate the entropy from the pool by sending
> packets with very precise intervals and generating interrupts so exactly
> as to fill the entropy pool with known data.  IMVHO, this is basically
> impossible, as the attacker could not possibly control ALL of the network
> traffic, and you could optionally define "safe" and "unsafe" interfaces
> for terms of entropy.

That's not the only attack, actually.  The much simpler attack pathis
for an attack to **observe** the network traffic to such a precise
extent as to be able to guess what the entropy numbers are that are
going into the pool.  (Think: FBI's Carnivore).

The one saving grace here is that in order to really do this well, the
attacker would need to be sitting on the local area network to get the
best and most precise timing numbers.  You can argue that this is
still a theoretical attack; but it's not quite so difficult as saying
that the attacker has to "control" the network traffic.

						- Ted

