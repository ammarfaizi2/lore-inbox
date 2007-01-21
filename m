Return-Path: <linux-kernel-owner+w=401wt.eu-S1751562AbXAUNnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbXAUNnS (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 08:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbXAUNnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 08:43:18 -0500
Received: from 1wt.eu ([62.212.114.60]:2112 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751545AbXAUNnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 08:43:17 -0500
Date: Sun, 21 Jan 2007 14:43:08 +0100
From: Willy Tarreau <w@1wt.eu>
To: Junio C Hamano <junkio@cox.net>
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Announce] GIT v1.5.0-rc2
Message-ID: <20070121134308.GA24090@1wt.eu>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <7v3b6439uh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7v3b6439uh.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Junio !

On Sun, Jan 21, 2007 at 03:20:06AM -0800, Junio C Hamano wrote:
> BTW, as the upcoming v1.5.0 release will introduce quite a bit of
> surface changes (although at the really core it still is the old
> git and old ways should continue to work), I am wondering if it
> would help people to try out and find wrinkles before the real
> thing for me to cut a tarball and a set of RPM packages.
> 
> Comments?

Anything you can do to make tester's life easier will always slightly
increase the number of testers. Hint: how often do you try random
software that requires that you first install CVS, SVN or arch just to
get it, compared to how often you try random software provided as tar.gz ?
Pre-release tar.gz and rpms coupled with a freshmeat announcement should
get you a bunch of testers and newcomers. This will give the new doc a
real trial, and will help discover traps in which beginners often fall.

> Also, in the same spirit of giving the release an early
> exposure, here is the current draft of 1.5.0 release notes.

(...)

>  - There is a configuration variable core.legacyheaders that
>    changes the format of loose objects so that they are more
>    efficient to pack and to send out of the repository over git
>    native protocol, since v1.4.2.  However, loose objects
>    written in the new format cannot be read by git older than
>    that version; people fetching from your repository using
>    older clients over dumb transports (e.g. http) using older
>    versions of git will also be affected.
> 
>  - Since v1.4.3, configuration repack.usedeltabaseoffset allows
>    packfile to be created in more space efficient format, which
>    cannot be read by git older than that version.

I know it's a bit late to ask, but if new on-disk format changes, isn't
it time to bump the version to 2.0 ? It would be easier for many people to
remember that GIT 1.X uses format version 1 and that GIT 2.X uses format
version 2 with backwards compatibility with 1.X. I also think that 1.5
is much more different from 1.0 than a mid-term 2.0 would be from current
1.5.

That said, kudos for the nice changelog !

Regards,
Willy

