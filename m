Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbQLSJXH>; Tue, 19 Dec 2000 04:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129289AbQLSJW6>; Tue, 19 Dec 2000 04:22:58 -0500
Received: from cnxtsmtp2.conexant.com ([198.62.9.253]:22227 "EHLO
	cnxtsmtp2.conexant.com") by vger.kernel.org with ESMTP
	id <S129406AbQLSJWn>; Tue, 19 Dec 2000 04:22:43 -0500
From: rui.sousa@conexant.com
Subject: Re: emu10k1 broken in 2.2.18
To: Ari Heitner <aheitner@andrew.cmu.edu>
Cc: alan@lxorguk.ukuu.org.uk, emu10k1-devel@opensource.creative.com,
        linux-kernel@vger.kernel.org, rsousa@grad.physics.sunysb.edu
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF6B3623E3.C2E9E563-ONC12569BA.0030301F@conexant.com>
Date: Tue, 19 Dec 2000 09:51:49 +0100
X-MIMETrack: Serialize by Router on NPBSMTP1/Server/Conexant(Release 5.0.5 |September 22, 2000) at
 12/19/2000 12:51:46 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


All reports I've seen mention that the driver works fine if compiled as a
module. You may
want to try that. For this reason I also don't believe the problem is the
any of the emu10k1
source files (which you diff'ed), unfortunately I haven't had much
time/means to test this
since I'm without a home PC and a SBLive.

Rui


                                                                                                                              
                    Ari Heitner                                                                                               
                    <aheitner@andre        To:     rsousa@grad.physics.sunysb.edu                                             
                    w.cmu.edu>             cc:     alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,                    
                                           emu10k1-devel@opensource.creative.com                                              
                    19/12/00 08:43         Subject:     emu10k1 broken in 2.2.18                                              
                    Please respond                                                                                            
                    to Ari Heitner                                                                                            
                                                                                                                              
                                                                                                                              





Alan/Rui,

just built 2.2.18 (on a box that's been running 2.2.14 for a very very long
time, and loading an emu10k1 module from opensource.creative.com or
wherever).

was pleased to note that emu10k1 finally made it in. Compiled and built.
Dmesg
indicated that things were detecting nicely, but attempts to play sound
result
in 'Cannot open /dev/dsp!' (not a rights problem). I had heard a bit
earlier
this evening on #debian that someone was complaining of similar problems on
a
2.2.17->2.2.18 upgrade, so on a hunch i pulled down a 2.2.17 kernel, and
make
oldconfig'd it with my 2.2.18 config.

dmesg again fine, this time it works :) so there does appear to be a
problem
there.

templestowe:~$ dmesg |less
Linux version 2.2.17 (root@templestowe) (gcc version 2.95.2 20000220
(Debian
GNU/Linux)) #1 Tue Dec 19 01:44:23 EST 2000
...
Creative EMU10K1 PCI Audio Driver, version 0.6, 01:45:48 Dec 19 2000
emu10k1: EMU10K1 rev 4 model 0x20 found, IO at 0xe400-0xe41f, IRQ 10
...

machine is running debian sid. i'll be happy to do anything else anyone
suggests to play with this. I did diff out the source file by file in
drivers/sound/emu10k1 (my *god* since when did this driver need to be 8k+
lines
of code? i just wrote a kernel and filesystem for my CMU OS class [15-412]
in
that many lines :)  ... and there's more than i'm prepared to deal with.

is this driver working for anyone else in 2.2.18? anyone recall the
reasoning
behind this patch set (i may well have missed it going by on l-k)?

perhaps this is just a known problem by now but i haven't seen mention on
l-k
so i'll risk the wrath of the appropriate gods.


Cheers,

Ari Heitner







-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
