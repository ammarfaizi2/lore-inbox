Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbTDXJX6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 05:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbTDXJX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 05:23:58 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:54975 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S262513AbTDXJX4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 05:23:56 -0400
Date: Thu, 24 Apr 2003 11:34:27 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andrew Morton <akpm@digeo.com>, mbligh@aracnet.com,
       ncunningham@clear.net.nz, gigerstyle@gmx.ch, geert@linux-m68k.org,
       linux-kernel@vger.kernel.org
Subject: Re: Fix SWSUSP & !SWAP
Message-ID: <20030424093427.GA3084@elf.ucw.cz>
References: <1051136725.4439.5.camel@laptop-linux> <1584040000.1051140524@flay> <20030423235820.GB32577@atrey.karlin.mff.cuni.cz> <20030423170759.2b4e6294.akpm@digeo.com> <20030424002544.GC2925@elf.ucw.cz> <20030424090519.GI28253@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030424090519.GI28253@mail.jlokier.co.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Swapfile does not work, because even readonly mount wants to replay
> > logs, and that'd be disk corruption.
> 
> I don't understand.  During suspend, you just need a list of blocks to
> write to from the swapfile.  You can get that list before starting the
> actual suspend, so that writing doesn't imply any filesystem activity.
> 
> When you're resuming, you just need a list of which disk blocks to
> resume from.  Can't that list be stored in a few blocks of the
> swapfile itself, with the only critical parameter being the first
> block number to resume from?

And how do you pass that first number? Please user could you write
this down to paper and enter it on commandline during suspend?

Okay, okay, this could be made to work. You could store pointer in
swapspace or in reserved block somewhere...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
