Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbTJ3I2r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 03:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbTJ3I2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 03:28:47 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:7040 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262291AbTJ3I2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 03:28:45 -0500
Date: Thu, 30 Oct 2003 08:30:37 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200310300830.h9U8UbR7000423@81-2-122-30.bradfords.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Jeff Garzik <jgarzik@pobox.com>, Hans Reiser <reiser@namesys.com>,
       "Mudama, Eric" <eric_mudama@Maxtor.com>,
       "'Norman Diamond'" <ndiamond@wta.att.ne.jp>,
       "'Wes Janzen '" <superchkn@sbcglobal.net>,
       "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>,
       linux-kernel@vger.kernel.org, nikita@namesys.com,
       "'Pavel Machek '" <pavel@ucw.cz>,
       "'Justin Cormack '" <justin@street-vision.com>,
       "'Vitaly Fertman '" <vitaly@namesys.com>,
       "'Krzysztof Halasa '" <khc@pm.waw.pl>
In-Reply-To: <20031029200141.GA1941@elf.ucw.cz>
References: <785F348679A4D5119A0C009027DE33C105CDB3B0@mcoexc04.mlm.maxtor.com>
 <3F9D6891.5040300@namesys.com>
 <3F9D7666.6010504@pobox.com>
 <200310272003.h9RK32B2001618@81-2-122-30.bradfords.org.uk>
 <20031029200141.GA1941@elf.ucw.cz>
Subject: Re: Blockbusting news, results get worse
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Pavel Machek <pavel@ucw.cz>:
> Hi!
> 
> > > >> or put it under heavy write workload and remove
> > > >> power.
> > > >>
> > > > Can you tell us more about what really happens to disk drives when the 
> > > > power is cut while a block is being written?  We engage in a lot of 
> > > > uninformed speculation, and it would be nice if someone who really knows 
> > > > told us....
> > > > 
> > > > Do drives have enough capacitance under normal conditions to finish 
> > > > writing the block?  Does ECC on the drive detect that the block was bad 
> > > > and so we don't need to detect it in the FS?
> > > 
> > > 
> > > Does it really matter to speculate about this?
> > > 
> > > If you don't FLUSH CACHE, you have no guarantees your data is on the 
> > > platter.
> > 
> > I think that the idea that is floating around is to deliberately ruin
> > the formatting on part of the drive in order to simulate a bad block.
> > 
> > Operation of disk drives immediately after a power failiure has been
> > discussed before, by the way:
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=100665153518652&w=2
> 
> Well, that looks like pure speculation.
> 
> BTW I *do* believe that powerfail can make the sector bad. Imagine you
> bump into bad sector during write, and need to reallocate...

See the rest of the thread.

I think the point is that if that happened, it would be outside the
scope of the solution being suggested, and something more elaborate
such as a battery backed cache is needed if you want to guard against
that situation.

Unfortunately, I think that the re-writing due to a bad sector
requirement is going to occur often enough to make any solution which
doesn't handle it a bit pointless :-(

John.
