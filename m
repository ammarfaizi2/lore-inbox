Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312392AbSCYLM5>; Mon, 25 Mar 2002 06:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312398AbSCYLMs>; Mon, 25 Mar 2002 06:12:48 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:7185 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S312392AbSCYLMf>; Mon, 25 Mar 2002 06:12:35 -0500
Date: Mon, 25 Mar 2002 12:12:04 +0100
From: Pavel Machek <pavel@suse.cz>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Stevie O <stevie@qrpff.net>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: fadvise syscall?
Message-ID: <20020325111203.GC3144@atrey.karlin.mff.cuni.cz>
In-Reply-To: <5.1.0.14.2.20020324013457.022907d0@whisper.qrpff.net> <3C959716.6040308@mandrakesoft.com> <3C945635.4050101@mandrakesoft.com> <3C945A5A.9673053F@zip.com.au> <5.1.0.14.2.20020317131910.0522b490@pop.cus.cam.ac.uk> <3C959716.6040308@mandrakesoft.com> <5.1.0.14.2.20020324013457.022907d0@whisper.qrpff.net> <5.1.0.14.2.20020324124410.02927620@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> >> I disagree, and here's the main reasons:
> >> >>
> >> >> * fadvise(2) usefulness extends past open(2).  It may be useful to 
> >call
> >> >> it at various points during runtime.
> >> >
> >> >open(/proc/self/fd/0, O_NEW_FLAGS)?
> >>
> >> So to use fadvise(), the system must have /proc mounted?
> >
> >I think it is way more feasible than adding new syscall.
> 
> Sorry but it is silly. (-; What's wrong with open("filename", O_FLAGS); 
> followed by fcntl(); if you want to modify them after opening. That is a 
> lot cleaner than going via proc in such a way...
> 
> posix_fadvise() can then be implemented in userspace and that can go via 
> fcntl(). That way we have the best of both worlds.

Agreed, this is better than my proposal.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
