Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261377AbREMFnb>; Sun, 13 May 2001 01:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261378AbREMFnW>; Sun, 13 May 2001 01:43:22 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:20741 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S261377AbREMFnL>; Sun, 13 May 2001 01:43:11 -0400
Date: Sat, 12 May 2001 23:35:41 -0600
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: more 3ware issues
Message-ID: <20010512233541.A4478@vger.timpanogas.org>
In-Reply-To: <200105130454.VAA17842@bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200105130454.VAA17842@bitmover.com>; from lm@bitmover.com on Sat, May 12, 2001 at 09:54:28PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am working on them with a project here, and they have a lot of issues.
Most of these issues just require some hard work.  I am seeing problems
on 2.2.19 on all machines if you cram 4 of these 8 IDE disk adapters
into a single bus.  There are some hardware issues with the cards that seem 
to show up on all systems I test on with this many adapters. 

Jeff


On Sat, May 12, 2001 at 09:54:28PM -0700, Larry McVoy wrote:
> I have a few more data points on the 3ware 6410 card in case anyone else
> is looking at this.  As I said before, this is a nicely designed card,
> I like it, kudos to the 3ware folks.
> 
> Combinations which work for me:
> 
> ASUS A7V and K7V motherboards, K7@1Ghz, 3c905, 1GB - 1.5GB ram.  Works
> like a champ under 2.2.19, not so great under 2.2.15 (Mandrake 7.1) nor
> under 2.4.4.
> 
> Combination which does not work under 2.2.15, 2.2.19, or 2.4.4:
> 
> Abit KT7 motherboard, K7@1Ghz, 3c905, 1GB.  I strongly suspect the Abit
> motherboard being the cause of the problem.  What I see is as soon as
> I start a disk scrubber on all 4 drives, is stuff like
> 
> 3w-xxxx: tw_post_command_packet(): Unexpected bits.
> 3w-xxxx: tw_check_bits(): Found unexpected bits (0x572076c0).
> 3w-xxxx: tw_check_bits(): Found unexpected bits (0x57206a60).
> 3w-xxxx: tw_post_command_packet(): Unexpected bits.
> 3w-xxxx: tw_interrupt(): Bad response, status = 0xc7, flags = 0x1b, unit = 0x0.
> 3w-xxxx: tw_check_bits(): Found unexpected bits (0x572079a0).
> 3w-xxxx: tw_interrupt(): Unexpected bits.
> 3w-xxxx: tw_interrupt(): Bad response, status = 0xc7, flags = 0x1b, unit = 0x0.
> 3w-xxxx: tw_check_bits(): Found unexpected bits (0x572079c0).
> 3w-xxxx: tw_interrupt(): Unexpected bits.
> 3w-xxxx: tw_scsi_eh_abort(): Abort failed for unknown Scsi_Cmnd 0xfbf4ac00, resetting card 0.
> 3w-xxxx: tw_scsi_eh_reset(): Reset succeeded for card 0.
> 3w-xxxx: tw_post_command_packet(): Unexpected bits.
> 3w-xxxx: tw_check_bits(): Found unexpected bits (0x57226a60).
> 3w-xxxx: tw_post_command_packet(): Unexpected bits.
> 3w-xxxx: tw_check_bits(): Found unexpected bits (0x57226a60).
> 3w-xxxx: tw_post_command_packet(): Unexpected bits.
> 3w-xxxx: tw_scsi_eh_abort(): Abort failed for unknown Scsi_Cmnd 0xfbf49e00, resetting card 0.
> 
> 
> Those are cut and pasted from several different OS versions, so they don't
> all go together.  The bottom line was that with the Abit the system was
> just completely unstable and unusable.  When the problems occurred, it 
> would stall all I/O for quite a while (a minute or more) and then reset
> the card, unwedge, and repeat.
> 
> Again, I don't want people to take this as a slam on the 3ware cards, I
> like them a lot, in fact after getting the first one to work last week
> I ordered more of them, which resulted in the Abit problems.  I don't
> think it's the card at all.  Everyone I know who has them likes them.
> It's just that some combinations work and some don't (yet) so it's 
> useful information for people to know which is which.
> 
> If Adam or anyone wants to try and debug this, I'll happliy put the machine
> with the Abit and a card up on the net, you can ssh in and do whatever
> you want to it, let me know.
> 
> --lm
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
