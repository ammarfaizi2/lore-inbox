Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbREMEyz>; Sun, 13 May 2001 00:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261377AbREMEyg>; Sun, 13 May 2001 00:54:36 -0400
Received: from bitmover.com ([207.181.251.162]:5928 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S261375AbREMEy3>;
	Sun, 13 May 2001 00:54:29 -0400
Date: Sat, 12 May 2001 21:54:28 -0700
From: Larry McVoy <lm@bitmover.com>
Message-Id: <200105130454.VAA17842@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: more 3ware issues
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a few more data points on the 3ware 6410 card in case anyone else
is looking at this.  As I said before, this is a nicely designed card,
I like it, kudos to the 3ware folks.

Combinations which work for me:

ASUS A7V and K7V motherboards, K7@1Ghz, 3c905, 1GB - 1.5GB ram.  Works
like a champ under 2.2.19, not so great under 2.2.15 (Mandrake 7.1) nor
under 2.4.4.

Combination which does not work under 2.2.15, 2.2.19, or 2.4.4:

Abit KT7 motherboard, K7@1Ghz, 3c905, 1GB.  I strongly suspect the Abit
motherboard being the cause of the problem.  What I see is as soon as
I start a disk scrubber on all 4 drives, is stuff like

3w-xxxx: tw_post_command_packet(): Unexpected bits.
3w-xxxx: tw_check_bits(): Found unexpected bits (0x572076c0).
3w-xxxx: tw_check_bits(): Found unexpected bits (0x57206a60).
3w-xxxx: tw_post_command_packet(): Unexpected bits.
3w-xxxx: tw_interrupt(): Bad response, status = 0xc7, flags = 0x1b, unit = 0x0.
3w-xxxx: tw_check_bits(): Found unexpected bits (0x572079a0).
3w-xxxx: tw_interrupt(): Unexpected bits.
3w-xxxx: tw_interrupt(): Bad response, status = 0xc7, flags = 0x1b, unit = 0x0.
3w-xxxx: tw_check_bits(): Found unexpected bits (0x572079c0).
3w-xxxx: tw_interrupt(): Unexpected bits.
3w-xxxx: tw_scsi_eh_abort(): Abort failed for unknown Scsi_Cmnd 0xfbf4ac00, resetting card 0.
3w-xxxx: tw_scsi_eh_reset(): Reset succeeded for card 0.
3w-xxxx: tw_post_command_packet(): Unexpected bits.
3w-xxxx: tw_check_bits(): Found unexpected bits (0x57226a60).
3w-xxxx: tw_post_command_packet(): Unexpected bits.
3w-xxxx: tw_check_bits(): Found unexpected bits (0x57226a60).
3w-xxxx: tw_post_command_packet(): Unexpected bits.
3w-xxxx: tw_scsi_eh_abort(): Abort failed for unknown Scsi_Cmnd 0xfbf49e00, resetting card 0.


Those are cut and pasted from several different OS versions, so they don't
all go together.  The bottom line was that with the Abit the system was
just completely unstable and unusable.  When the problems occurred, it 
would stall all I/O for quite a while (a minute or more) and then reset
the card, unwedge, and repeat.

Again, I don't want people to take this as a slam on the 3ware cards, I
like them a lot, in fact after getting the first one to work last week
I ordered more of them, which resulted in the Abit problems.  I don't
think it's the card at all.  Everyone I know who has them likes them.
It's just that some combinations work and some don't (yet) so it's 
useful information for people to know which is which.

If Adam or anyone wants to try and debug this, I'll happliy put the machine
with the Abit and a card up on the net, you can ssh in and do whatever
you want to it, let me know.

--lm
