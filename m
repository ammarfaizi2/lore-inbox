Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263997AbTE0TFM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 15:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264007AbTE0TFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 15:05:12 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:30968 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263997AbTE0TFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 15:05:11 -0400
Date: Tue, 27 May 2003 21:18:18 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.70
Message-ID: <20030527191818.GC19265@fs.tum.de>
References: <Pine.LNX.4.44.0305271024060.6597-100000@penguin.transmeta.com> <Pine.GSO.4.33.0305271402420.4448-100000@sweetums.bluetronic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.33.0305271402420.4448-100000@sweetums.bluetronic.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 02:09:43PM -0400, Ricky Beam wrote:
> 
> Allow me to clarify... I don't mind drivers not working.  I *do* mind
> drivers emitting hundreds of warnings and errors because dozens of things
> were changed and no one cared to update everything they broke.  In some
> cases, fixing things may be simple (eg. someone removed or renamed a field
> in a struct somewhere) and in others years of work my be required (eg.
> the new module interface.)

Many warnings are for problems that were already present in 2.4 or for
using deprecated (IOW: working) functions. It might be a thought to
probably disable deprecated warnings for stable kernel releases (read
2.6.0, 2.6.1,...) but it's not always a measurement for how far away we
are from 2.6. And besides, a full build of 2.4.20 with gcc 2.95 gives
you 103 warnings.

> In my opinion (as it was in the long long ago), everything in a "stable"
> release should at least compile cleanly -- "working" comes later after
> users have been conned into using it.

IMHO compiling and non-working (or worse: working but data-corrupting) 
is worse than non-compiling. It might be a good idea to let broken 
drivers depend on an (undefined) CONFIG_BROKEN, but this is only a minor 
detail with no influence on the 2.6 schedule.

> --Ricky

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

