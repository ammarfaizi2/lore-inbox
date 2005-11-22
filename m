Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbVKVBNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbVKVBNl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 20:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbVKVBNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 20:13:41 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37314 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964813AbVKVBNk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 20:13:40 -0500
Date: Tue, 22 Nov 2005 01:45:31 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rob Landley <rob@landley.net>
Cc: Tarkan Erimer <tarkane@gmail.com>, linux-kernel@vger.kernel.org,
       Diego Calleja <diegocg@gmail.com>
Subject: Re: what is our answer to ZFS?
Message-ID: <20051122004531.GA15189@elf.ucw.cz>
References: <11b141710511210144h666d2edfi@mail.gmail.com> <20051121124544.9e502404.diegocg@gmail.com> <9611fa230511210619l208b10a8w77aedaa249345448@mail.gmail.com> <200511211252.04217.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200511211252.04217.rob@landley.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > If It happenned, Sun or someone has port it to linux.
> > We will need some VFS changes to handle 128 bit FS as "Jörn ENGEL"
> > mentionned previous mail in this thread. Is there any plan or action
> > to make VFS handle 128 bit File Sytems like ZFS or future 128 bit
> > File Systems ? Any VFS people reply to this, please?
> 
> I believe that on 64 bit platforms, Linux has a 64 bit clean VFS.  Python says 
> 2**64 is 18446744073709551616, and that's roughly:
> 18,446,744,073,709,551,616 bytes
> 18,446,744,073,709 megs
> 18,446,744,073 gigs
> 18,446,744 terabytes
> 18,446 ...  what are those, petabytes?
> 18 Really big lumps of data we won't be using for a while yet.
> 
> And that's just 64 bits.  Keep in mind it took us around fifty years to burn 
> through the _first_ thirty two (which makes sense, since Moore's Law says we 
> need 1 more bit every 18 months).  We may go through it faster than we went 
> through the first 32 bits, but it'll last us a couple decades at least.
> 
> Now I'm not saying we won't exhaust 64 bits eventually.  Back to chemistry, it 
> takes 6.02*10^23 protons to weigh 1 gram, and that's just about 2^79, so it's 
> feasible that someday we might be able to store more than 64 bits of data per 
> gram, let alone in big room-sized clusters.   But it's not going to be for 
> years and years, and that's a design problem for Sun.
> 
> Sun is proposing it can predict what storage layout will be efficient for as 
> yet unheard of quantities of data, with unknown access patterns, at least a 
> couple decades from now.  It's also proposing that data compression and 
> checksumming are the filesystem's job.  Hands up anybody who spots 
> conflicting trends here already?  Who thinks the 128 bit requirement came 
> from marketing rather than the engineers?

Actually, if you are storing information in single protons, I'd say
you _need_ checksumming :-).

[I actually agree with Sun here, not trusting disk is good idea. At
least you know kernel panic/oops/etc can't be caused by bit corruption on
the disk.]

								Pavel
-- 
Thanks, Sharp!
