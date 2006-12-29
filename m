Return-Path: <linux-kernel-owner+w=401wt.eu-S932292AbXAAQ3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbXAAQ3F (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 11:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755238AbXAAQ3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 11:29:05 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4662 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755234AbXAAQ3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 11:29:04 -0500
Date: Fri, 29 Dec 2006 10:02:23 +0000
From: Pavel Machek <pavel@suse.cz>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Arjan van de Ven <arjan@infradead.org>, Jan Harkes <jaharkes@cs.cmu.edu>,
       Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: Finding hardlinks
Message-ID: <20061229100223.GF3955@ucw.cz>
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz> <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu> <20061221185850.GA16807@delft.aura.cs.cmu.edu> <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz> <1166869106.3281.587.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>If user (or script) doesn't specify that flag, it 
> >>doesn't help. I think
> >>the best solution for these filesystems would be 
> >>either to add new syscall
> >> 	int is_hardlink(char *filename1, char *filename2)
> >>(but I know adding syscall bloat may be objectionable)
> >
> >it's also the wrong api; the filenames may have been 
> >changed under you
> >just as you return from this call, so it really is a
> >"was_hardlink_at_some_point()" as you specify it.
> >If you make it work on fd's.. it has a chance at least.
> 
> Yes, but it doesn't matter --- if the tree changes under 
> "cp -a" command, no one guarantees you what you get.
> 	int fis_hardlink(int handle1, int handle 2);
> Is another possibility but it can't detect hardlinked 
> symlinks.

Ugh. Is it even legal to hardlink symlinks?

Anyway, cp -a is not the only application that wants to do hardlink
detection.
						Pavel
-- 
Thanks for all the (sleeping) penguins.
