Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274869AbTGaTzc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 15:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274870AbTGaTzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 15:55:32 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:41677 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S274869AbTGaTz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 15:55:29 -0400
Date: Thu, 31 Jul 2003 19:31:07 +0200
From: Pavel Machek <pavel@suse.cz>
To: David Brownell <david-b@pacbell.net>
Cc: Pavel Machek <pavel@suse.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       Dominik Brugger <ml.dominik83@gmx.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: OHCI problems with suspend/resume
Message-ID: <20030731173107.GC215@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0307251057300.724-100000@ida.rowland.org> <1059153629.528.2.camel@gaston> <3F21B3BF.1030104@pacbell.net> <20030726210123.GD266@elf.ucw.cz> <3F288CAB.6020401@pacbell.net> <20030731094231.GA464@elf.ucw.cz> <3F291B9E.10109@pacbell.net> <20030731140908.GB16463@atrey.karlin.mff.cuni.cz> <3F2952B1.6060805@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2952B1.6060805@pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>USB drivers don't talk suspend/resume yet, so they
> >>won't notice missing features there.  Regressions
> >>are a different story though.
> >>
> >>But I can imagine that usb-storage (or is that SCSI?)
> >>might want to veto suspending devices that are being
> >>used for some kinds of i/o.  Eventually it should exist.
> >
> >
> >For what kind of I/O? I do not see a reason for disk to veto
> >suspend. CD-burner might want to do that, but it still would be bad
> >idea... (Running on battery, battery goes low, and you destroy your CD
> >*and* your filesystem.
> 
> If it's in the middle of any kind of write, suspending would
> seem to be unwise.  Say, writing to a swap partition...

We already know it is not... We stopped all user tasks for this
purpose. Also the device has opportunity to simply wait inside
SAVE_STATE for a write to finish.

> Mostly I'm just saying that if vetoing ever makes sense
> (and I understand that it does), USB drivers will need
> to understand it too.

Agreed.
							Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
