Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbTEQU64 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 16:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbTEQU6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 16:58:52 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:48574 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S261843AbTEQU6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 16:58:48 -0400
Date: Sat, 17 May 2003 14:30:44 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
Subject: Re: [PATCH] in-core AFS multiplexor and PAG support
Message-ID: <20030517123044.GG686@zaurus.ucw.cz>
References: <8812.1052841957@warthog.warthog> <Pine.LNX.4.44.0305130929340.1678-100000@home.transmeta.com> <20030513172029.GB25295@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513172029.GB25295@delft.aura.cs.cmu.edu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The advantage of associating the PAG with the real uid rather than make it
> > per-process is that it's a lot easier to administer that way, I think. You
> > don't need to log out or anything like that to have changes take effect
> > for your session, and it is very natural to say "this user now gets key
> > X". Which is what I think you really want when you do something like enter
> > a key to an encrypted filesystem, for example.
> 
> The local user id is not a 'trusted' identity for a distributed filesystem.
> Any user still have to prove his identity by obtaining tokens. 
> 
> If someone obtains my user id on in any way (i.e. weak password/
> bufferoverflow/ root exploit), he should not be allowed to use or access
> my tokens as he hasn't proven his identity. In this case he would either

? If he has same uid as you *and* you
have >=1 process running, what prevents
him from gdb attach <that process>,
and force it to do whatever he needs
by forcing syscall?
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

