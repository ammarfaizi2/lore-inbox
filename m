Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266308AbTAYLfq>; Sat, 25 Jan 2003 06:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266316AbTAYLfq>; Sat, 25 Jan 2003 06:35:46 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:15809 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S266308AbTAYLfp>;
	Sat, 25 Jan 2003 06:35:45 -0500
Date: Sat, 25 Jan 2003 12:44:30 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: John Bradford <john@grabjohn.com>
Cc: lkml@scienceworks.com, linux-kernel@vger.kernel.org
Subject: Re: Promise PDC20268 FastTrack 100 TX2 (PDC20268)
Message-ID: <20030125124430.B29666@ucw.cz>
References: <20030120183442.GA3440@poseidon.wasserstadt.de> <200301201912.h0KJCrru006239@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200301201912.h0KJCrru006239@darkstar.example.net>; from john@grabjohn.com on Mon, Jan 20, 2003 at 07:12:53PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2003 at 07:12:53PM +0000, John Bradford wrote:
> > I have a Promise FastTrack 100 TX2 (PDC20268) IDE-controller
> > (BIOS v2.00.0.24) used in a linux MD-RAID.  Aside from various
> > other annoying Promise-problems, I am not able to perform a
> > remote boot because the brain-dead Promise-BIOS "complains" that
> > no array is defined, and requires one to press ESC to continue
> > booting.  I would very much appreciate any tips as to how I can
> > circumvent this "feature".
> 
> Well, if you don't usually need a keyboard on that machine, in theory,
> you might be able to connect the keyboard input to the PS/2 mouse port
> of another machine, and write a program to send the correct bytes for
> that keypress to the other machine. Then, you could reboot the
> machine with the Promise card in it, then log in to the other machine,
> and run the program to send the keypress.
> 
> Not sure how practical this solution would be though...  You'd
> probably have to simulate the keyboard initialisation responses as
> well, which would make it a bit complicated

That won't work, of course - while the PS/2 and keyboard ports are the
same, they are master/slave - the computer is master and the device is
slave - you cannot connect master to master.

It'd work if you used bitbanging on the parallel port, though.

Or a keyboard with something heavy on the 'esc' key ;)

Another possibility is just to remove the BIOS from the card or tell the
on-board BIOS not to initalize it.

-- 
Vojtech Pavlik
SuSE Labs
