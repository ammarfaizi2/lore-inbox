Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbWAZVCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbWAZVCb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 16:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbWAZVCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 16:02:31 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:34691 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964875AbWAZVCa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 16:02:30 -0500
Date: Thu, 26 Jan 2006 22:02:28 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Matthias Andree <matthias.andree@gmx.de>
cc: Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <20060126125825.GB14256@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.61.0601262146480.27891@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0601241823390.28682@yvahk01.tjqt.qr>
 <43D78585.nailD7855YVBX@burner> <20060125142155.GW4212@suse.de>
 <Pine.LNX.4.61.0601251544400.31234@yvahk01.tjqt.qr> <20060125145544.GA4212@suse.de>
 <43D7AEBF.nailDFJ7263OE@burner> <43D7B100.7040706@gmx.de> <43D7B345.nailDFJB1WWYF@burner>
 <20060125231957.GC2137@merlin.emma.line.org> <43D8C0E9.nailE1C31558S@burner>
 <20060126125825.GB14256@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Tell me how to access a ATAPI tape drive via libscg.

(I probably don't get that question.)
The top of drivers/ide/ide-tape.c shows it gets /dev/ht%d (when used 
without scsi emulation I believe). And I pick a wild guess that it gets 
/dev/sg%d when used with scsi emu.
Programs using libscg would only need to use S:I:L or ATA:/dev/ht0 (?)
I presume?



>It is *your* library, I have no interest in it as long as CD writing
>works at the moment. Either do your research or ask the public, I'm not
>going to answer or research this for you.
>
>It is not helpful that you are (1) talking about ATAPI tapes under the
>CD subject and (2) claim you know better than Linux (or Jens, for that
>matter) if you haven't researched this.

I think you (Matthias) get it slightly skewed here. As far as I am able to 
slip through the flames, libscg is used by cdrecord just as libc is used by 
all apps to have "some sort" of OS abstraction (pick some function, like 
fork()). Therefore, libscg seems +not only+ about cd writing. However, if 
you want to have a working cdrecord, you need a working libscg, just like 
you need a working libc or your system is going bye-bye.




Jan Engelhardt
-- 
