Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129807AbRBTHla>; Tue, 20 Feb 2001 02:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129909AbRBTHlU>; Tue, 20 Feb 2001 02:41:20 -0500
Received: from theirongiant.weebeastie.net ([203.62.148.50]:5380 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S129835AbRBTHlG>; Tue, 20 Feb 2001 02:41:06 -0500
Date: Tue, 20 Feb 2001 18:40:28 +1100
From: CaT <cat@zip.com.au>
To: Ion Badulescu <ionut@moisil.cs.columbia.edu>
Cc: linux-kernel@vger.kernel.org, Dragan Stancevic <visitor@valinux.com>,
        Andrey Savochkin <saw@saw.sw.com.sg>
Subject: Re: eepro100 + 2.2.18 + laptop problems
Message-ID: <20010220184028.A503@zip.com.au>
In-Reply-To: <20010219144935.D21425@saw.sw.com.sg> <200102200018.f1K0IeC32394@moisil.dev.hydraweb.com> <20010220113152.G365@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010220113152.G365@zip.com.au>; from cat@zip.com.au on Tue, Feb 20, 2001 at 11:31:52AM +1100
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2001 at 11:31:52AM +1100, CaT wrote:
> On Mon, Feb 19, 2001 at 04:18:40PM -0800, Ion Badulescu wrote:
> > > In my experiments wait_for_cmd timeouts almost always were related to
> > > DumpStats command.
> > > I think, we need to investigate what time constraints are related to this
> > > command.
> > 
> > Nothing documented...
> > 
> > CaT, can you apply this debugging patch and let us know what you get in the
> > logs? It should allow us to pinpoint the error a bit more precisely.
> 
> patched, old removed, new installed, waiting for fubar. :)

Ok. this is what I got in my kern.log. this is on a fresh reboot.

Feb 20 18:31:49 theirongiant kernel: eepro100: cmd_wait for(0x70) timedout with(0x70)!
Feb 20 18:31:49 theirongiant kernel: eepro100: cmd_wait for(0x10) timedout with(0x10)!
Feb 20 18:31:49 theirongiant kernel: eepro100: cmd_wait for(0xffffff90) timedout with(0xffffff90)!
Feb 20 18:32:21 theirongiant last message repeated 29 times
Feb 20 18:33:15 theirongiant last message repeated 31 times
Feb 20 18:33:16 theirongiant kernel: eth0: Transmit timed out: status 0000  0c90 at 0/63 command 0001a000.
Feb 20 18:33:16 theirongiant kernel: eth0: Tx ring dump,  Tx queue 63 / 0:
Feb 20 18:33:16 theirongiant kernel: eth0:  *  0 0001a000.
Feb 20 18:33:16 theirongiant kernel: eth0:     1 00020000.
Feb 20 18:33:16 theirongiant kernel: eth0:     2 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:     3 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:     4 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:     5 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:     6 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:     7 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:     8 00020000.
Feb 20 18:33:16 theirongiant kernel: eth0:     9 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    10 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    11 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    12 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    13 000c0000.
Feb 20 18:33:16 theirongiant kernel: eth0:    14 000c0000.
Feb 20 18:33:16 theirongiant kernel: eth0:    15 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    16 200c0000.
Feb 20 18:33:16 theirongiant kernel: eth0:    17 000c0000.
Feb 20 18:33:16 theirongiant kernel: eth0:    18 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    19 000c0000.
Feb 20 18:33:16 theirongiant kernel: eth0:    20 000c0000.
Feb 20 18:33:16 theirongiant kernel: eth0:    21 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    22 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    23 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    24 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    25 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    26 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    27 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    28 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    29 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    30 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    31 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    32 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    33 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    34 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    35 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    36 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    37 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    38 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    39 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    40 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    41 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    42 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    43 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    44 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    45 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    46 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    47 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    48 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    49 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    50 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    51 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    52 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    53 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    54 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    55 000c0000.
Feb 20 18:33:16 theirongiant kernel: eth0:    56 000c0000.
Feb 20 18:33:16 theirongiant kernel: eth0:    57 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    58 000c0000.
Feb 20 18:33:16 theirongiant kernel: eth0:    59 000c0000.
Feb 20 18:33:16 theirongiant kernel: eth0:    60 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    61 00030000.
Feb 20 18:33:16 theirongiant kernel: eth0:    62 40030000.
Feb 20 18:33:16 theirongiant kernel: eth0:   =63 00000000.
Feb 20 18:33:16 theirongiant kernel: eth0: Printing Rx ring (next to receive into 0, dirty index 0).
Feb 20 18:33:16 theirongiant kernel: eth0:  *= 0 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:     1 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:     2 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:     3 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:     4 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:     5 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:     6 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:     7 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:     8 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:     9 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    10 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    11 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    12 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    13 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    14 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    15 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    16 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    17 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    18 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    19 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    20 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    21 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    22 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    23 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    24 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    25 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    26 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    27 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    28 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    29 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    30 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    31 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    32 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    33 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    34 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    35 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    36 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    37 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    38 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    39 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    40 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    41 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    42 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    43 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    44 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    45 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    46 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    47 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    48 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    49 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    50 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    51 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    52 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    53 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    54 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    55 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    56 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    57 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    58 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    59 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    60 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    61 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0:    62 00000001.
Feb 20 18:33:16 theirongiant kernel: eth0: l  63 c0000002.

-- 
CaT (cat@zip.com.au)		*** Jenna has joined the channel.
				<cat> speaking of mental giants..
				<Jenna> me, a giant, bullshit
				<Jenna> And i'm not mental
					- An IRC session, 20/12/2000

