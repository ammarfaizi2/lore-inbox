Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbTJ2UCE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 15:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbTJ2UCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 15:02:04 -0500
Received: from gprs194-254.eurotel.cz ([160.218.194.254]:52867 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261473AbTJ2UCA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 15:02:00 -0500
Date: Wed, 29 Oct 2003 21:01:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: John Bradford <john@grabjohn.com>
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
Subject: Re: Blockbusting news, results get worse
Message-ID: <20031029200141.GA1941@elf.ucw.cz>
References: <785F348679A4D5119A0C009027DE33C105CDB3B0@mcoexc04.mlm.maxtor.com> <3F9D6891.5040300@namesys.com> <3F9D7666.6010504@pobox.com> <200310272003.h9RK32B2001618@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310272003.h9RK32B2001618@81-2-122-30.bradfords.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >> or put it under heavy write workload and remove
> > >> power.
> > >>
> > > Can you tell us more about what really happens to disk drives when the 
> > > power is cut while a block is being written?  We engage in a lot of 
> > > uninformed speculation, and it would be nice if someone who really knows 
> > > told us....
> > > 
> > > Do drives have enough capacitance under normal conditions to finish 
> > > writing the block?  Does ECC on the drive detect that the block was bad 
> > > and so we don't need to detect it in the FS?
> > 
> > 
> > Does it really matter to speculate about this?
> > 
> > If you don't FLUSH CACHE, you have no guarantees your data is on the 
> > platter.
> 
> I think that the idea that is floating around is to deliberately ruin
> the formatting on part of the drive in order to simulate a bad block.
> 
> Operation of disk drives immediately after a power failiure has been
> discussed before, by the way:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=100665153518652&w=2

Well, that looks like pure speculation.

BTW I *do* believe that powerfail can make the sector bad. Imagine you
bump into bad sector during write, and need to reallocate...

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
