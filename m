Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261282AbTCTAIg>; Wed, 19 Mar 2003 19:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261283AbTCTAIg>; Wed, 19 Mar 2003 19:08:36 -0500
Received: from ns0.cobite.com ([208.222.80.10]:29960 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id <S261282AbTCTAIf>;
	Wed, 19 Mar 2003 19:08:35 -0500
Date: Wed, 19 Mar 2003 19:19:32 -0500 (EST)
From: David Mansfield <david@cobite.com>
X-X-Sender: david@admin
To: Andrea Arcangeli <andrea@suse.de>
cc: David Mansfield <lkml@dm.cobite.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] cvsps support for parsing BK->CVS kernel tree logs
In-Reply-To: <20030319223625.GS30541@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0303191837360.19298-100000@admin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Mar 2003, Andrea Arcangeli wrote:

> this is a critical feature for me, note that if Larry agreed of tagging
> the tree with the atomic-date of the patchset extracting those patchset
> would be an order of magnitude faster, I would pay for the RTT latency 1
> per patchset, not once per file and it would be possible to teach cvsps
> to learn diffing against the tag if it matches. Anyways stuff works now
> so I'll just wait for the RTT all the time w/o being able to use the
> real bandwidth provided by my link. As soon as the CVS tarball is
> available I'll use it for the large patch extractions.

I just looked briefly at the 'cvs server' protocol.  It looks fairly easy 
to have a 'keepalive' session with a server where multiple diffs of 
multiple files are requested.  This isn't a 5 minute fix though, but I've 
been bothered by the RTT per file as well, because we use 'ssh' to 
authenticate cvs access here, and each file is a complete ssh handshake 
which is very slow.

> One more feature wish (besides the python inteface for a quick gui) is
> the C^c killing cvsps too during a -g patch extraction, you probably
> should check the return code of cvs when extracting the patches. Right
> now I press C^z and then I killall cvsps ;)

Already fixed in my code.  I won't bother you with a diff.

> BTW, I think cvsps should be shipped together with cvs and integrated
> over time in the unstable branch, this is a major feature for any cvs
> user. Storing metadata locally is the way to go, over time the whole
> tree should be cached local (as an option). This is actually the major
> cvs improvement I seen since years. And I'm glad I can contribute to it
> unlike many kernel developers out there.

Thanks for your support,
David

-- 
/==============================\
| David Mansfield              |
| david@cobite.com             |
\==============================/

