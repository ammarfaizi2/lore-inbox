Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269126AbTCDCk4>; Mon, 3 Mar 2003 21:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269132AbTCDCkz>; Mon, 3 Mar 2003 21:40:55 -0500
Received: from shfd-3e35393f.pool.mediaWays.net ([62.53.57.63]:6528 "EHLO
	unicorn.encapsulated.net") by vger.kernel.org with ESMTP
	id <S269126AbTCDCky>; Mon, 3 Mar 2003 21:40:54 -0500
Date: Tue, 4 Mar 2003 02:47:14 +0000
From: Beneath <ishikodzume@beneath.plus.com>
To: linux-kernel@vger.kernel.org
Subject: BUG: EXT3: linux-2.4.21-pre5
Message-Id: <20030304024714.647cc75d.ishikodzume@beneath.plus.com>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have experienced this twice now... it seems to be random, or at least
i wasn't at all doing the same things each time i experienced it.
Once i experienced it back with pre3... and now with pre5.
My apologies, i am not sure what's going on, but here is what happens:

All of a sudden, and not during any heavy disk writing sessions or
anything, things seem to stop loading up. I.e. the system is still very
much alive, just anything that requires disk access will hang. It's
happened both times in X, and i was able to switch back to VT1, where
the following error messages awaited me:
(this is as much as i could write down)

Several of these two messages:
EXT3-FS error (device ide0(3,2)) in ext3 reserve_inode_write: IO failure
EXT3-FS error (device ide0(3,2)) in ext3_get_inode ... (this then
scrolled off the screen before i could transcribe it)

Then, after tonnes of that, whenever i tried to do anything subsequent:
EXT3-FS error (device ide0(3,2)) in start_transaction: journal has
aborted

I can't get anything to work, including shutdown, so i have to do a hard
reset.

This has only happened twice in... well, since pre3 has been released,
whenever that was. So it doesn't occur too much... good luck replicating
it. Anyone else had it?

ide0 is using the HPT37x driver, which just recently started working
with 2.4.20-ac1 onwards.
I'm using reverse-ide if that makes any difference.

I know this isn't much info, but i really can't think of anything else i
can add. Nothing pertaining to this is showing up in any log files or
anything.
Really sorry about the lack of detail... anything else i could say that
would help this be fixed? I'd really like to see it gone in 2.4.21... if
not it'll be the only pre-release kernel that has ever crashed for me.

I'm not subscribed to the list, so please CC to my address.

Thank you,
 - Daniel

