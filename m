Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbWAaNmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWAaNmx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 08:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWAaNmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 08:42:47 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:34236 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750840AbWAaNmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 08:42:40 -0500
Date: Tue, 31 Jan 2006 14:42:39 +0100
From: Martin Mares <mj@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: mrmacman_g4@mac.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, James@superbug.co.uk, j@bitron.ch,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <mj+md-20060131.133152.15846.atrey@ucw.cz>
References: <43D7A7F4.nailDE92K7TJI@burner> <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com> <43D7B1E7.nailDFJ9MUZ5G@burner> <20060125230850.GA2137@merlin.emma.line.org> <43D8C04F.nailE1C2X9KNC@burner> <43DDFBFF.nail16Z3N3C0M@burner> <1138642683.7404.31.camel@juerg-pd.bitron.ch> <43DF3C3A.nail2RF112LAB@burner> <mj+md-20060131.104748.24740.atrey@ucw.cz> <43DF65C8.nail3B41650J9@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DF65C8.nail3B41650J9@burner>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > How exactly does Linux prevent this???
> 
> By not treating ATAPI the same as all other SCSI devices.

Sorry, but that's false. Not treating ATAPI the same can at most
complicate it, but in no way prevent.

> > How do you perform -scanbus for TCP/IP? :-)
> 
> There are various programs that do that for you.
> You could e.g. send a ping to the broadcast address in order to find hosts
> that are on the local network.

Eh, so you are just going to treate the local network differently? ;-)

> If you understand this, why then insists other people in using names like 
> /dev/hd*?

Because at least on Linux, the NAMES are the primary identifier for user
space, not numbers of some virtual SCSI buses which don't exist in the
real world anyway.

For everything else (well, except network interfaces, but that's a different
story), we refer by names. Even when using the SCSI devices for other
purposes, we refer to them by names. Why should burning a CD be different?

I believe that this is the crucial question and the one you should
answer first, before trying to force others to share your view of the world.

> And while this kind of scanning works in case that you have all devices 
> integrated inside a single SCSI implementation, it does not work for ATAPI
> because someont artificially decided to exclude one single SCSI transport 
> from the global view.

No, you are just wrongly considering something to be a global view,
which it in fact isn't.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
How do I type 'for i in *.dvi ; do xdvi $i ; done' in a GUI?
