Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272952AbRIMKHX>; Thu, 13 Sep 2001 06:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272953AbRIMKHN>; Thu, 13 Sep 2001 06:07:13 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:33803 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S272952AbRIMKG4>; Thu, 13 Sep 2001 06:06:56 -0400
Date: Thu, 13 Sep 2001 12:07:06 +0200
From: Pavel Machek <pavel@suse.cz>
To: Edgar Toernig <froese@gmx.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        vojtech@ucw.cz, Hamera Erik <HAMERAE@cs.felk.cvut.cz>
Subject: Re: Booting linux using Novell NetWare Remote Program Loader
Message-ID: <20010913120706.C25204@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010909220921.A19145@bug.ucw.cz> <20010909170206.A3245@redhat.com> <20010909230920.A23392@atrey.karlin.mff.cuni.cz> <9nh5p0$3qt$1@cesium.transmeta.com> <20010911005318.C822@bug.ucw.cz> <3BA04514.D65EDF98@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3BA04514.D65EDF98@gmx.de>; from froese@gmx.de on Thu, Sep 13, 2001 at 07:33:08AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I found out I can boot it after little games with mars netware
> > emulator. However I have problems booting anything else than
> > freedos. Trying to boot zImage directly results in crc errors or in
> > errors in compressed data. Too much failures and too repeatable
> > (althrough ram seems flakey) for me to believe its hw.
> 
> I bet that's the same problem I had booting a zImage directly from an
> El-Torito CD.  The problem was the autoprobing for the floppy type
> performed by the boot loader.  It detected a 2.88 drive and issued
> corresponding read requests (track x, 36 blocks; track x+1, 36 blocks;
> ...).  The bios performs these request, but it emulates a 1.44 disk so
> the last 18 blocks of track x are actually the blocks from track x+1.
> In my case I did not even got a crc error but an immediate reboot.
> 
> I removed the autoprobing from bootsect.S and fixed it to 1.44MB format
> et voila, it worked perfectly.

Do you have patch to do that?
								Pavel

-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
