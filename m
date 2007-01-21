Return-Path: <linux-kernel-owner+w=401wt.eu-S1751365AbXAUS63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbXAUS63 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 13:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbXAUS63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 13:58:29 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:63387 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbXAUS62 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 13:58:28 -0500
From: Junio C Hamano <junkio@cox.net>
To: Willy Tarreau <w@1wt.eu>
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com
Subject: Re: [Announce] GIT v1.5.0-rc2
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net>
	<7v3b6439uh.fsf@assigned-by-dhcp.cox.net>
	<20070121134308.GA24090@1wt.eu>
Date: Sun, 21 Jan 2007 10:58:26 -0800
In-Reply-To: <20070121134308.GA24090@1wt.eu> (Willy Tarreau's message of "Sun,
	21 Jan 2007 14:43:08 +0100")
Message-ID: <7v7ivg1a25.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <w@1wt.eu> writes:

> Anything you can do to make tester's life easier will always slightly
> increase the number of testers.
> ...
> Pre-release tar.gz and rpms coupled with a freshmeat announcement should
> get you a bunch of testers and newcomers. This will give the new doc a
> real trial, and will help discover traps in which beginners often fall.

One worry I had about releasing git-1.5.0-rc2-1.rpm and friends
just like the "official" ones was that people might have scripts
to automate downloading & updating of packages, and they may not
like to get "beta" installed for them.

I wonder if kernel.org machines are also affected...

>> Also, in the same spirit of giving the release an early
>> exposure, here is the current draft of 1.5.0 release notes.
>
> (...)
>
>>  - There is a configuration variable core.legacyheaders that
>>    changes the format of loose objects so that they are more
>>    efficient to pack and to send out of the repository over git
>>    native protocol, since v1.4.2.  However, loose objects
>>    written in the new format cannot be read by git older than
>>    that version; people fetching from your repository using
>>    older clients over dumb transports (e.g. http) using older
>>    versions of git will also be affected.
>> 
>>  - Since v1.4.3, configuration repack.usedeltabaseoffset allows
>>    packfile to be created in more space efficient format, which
>>    cannot be read by git older than that version.
>
> I know it's a bit late to ask, but if new on-disk format changes, isn't
> it time to bump the version to 2.0? It would be easier for many people to
> remember that GIT 1.X uses format version 1 and that GIT 2.X uses format
> version 2 with backwards compatibility with 1.X. I also think that 1.5
> is much more different from 1.0 than a mid-term 2.0 would be from current
> 1.5.

I think we could have gone either way (as you said, it is
probably a bit too late to discuss this), but it should probably
be Ok to stay at 1.X as long as these one-way-street format
updates are turned off by default.

And the above happened way before this round and people have
hopefully been happily using.  For example, v1.4.2 was done
early August 2006.

