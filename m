Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315464AbSEMB50>; Sun, 12 May 2002 21:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315466AbSEMB5Z>; Sun, 12 May 2002 21:57:25 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16146 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315464AbSEMB5Y>; Sun, 12 May 2002 21:57:24 -0400
Date: Sun, 12 May 2002 18:56:34 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Changelogs on kernel.org
In-Reply-To: <20020512203103.GA9087@gallifrey>
Message-ID: <Pine.LNX.4.44.0205121836320.15555-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 12 May 2002, Dr. David Alan Gilbert wrote:
>
> I used to read the hand written changelogs, they only used to be a half
> page or so; neatly summerising stuff into one line; I can't be bothered
> with the full changelogs  - they are obviously useful; but the hand
> written half pages are still a lot easier at a quick glance to see if
> there is anything that affects you.

Yeah, I know. Some people like the long ones, though, and they _are_
useful if you want to get a more detailed view.

I definitely don't want to maintain a separate set of short logs, but the
answer may be to just do both: have the existing long log (with no merging
of changesets, so that people see the actual commit boundaries), and a
separate "short" version that also merges the thing.

As an example, if the long version looks like this:

	<jsimmons@heisenberg.transvirtual.com>
	        A bunch of fixes.

	<jsimmons@heisenberg.transvirtual.com>
	        Pmac updates

	<jsimmons@heisenberg.transvirtual.com>
	        Some more small fixes.

	<rmk@arm.linux.org.uk>
	        [PATCH] 2.5.13: vmalloc link failure

	        The following patch fixes this, and also fixes the similar problem in
	        scsi_debug.c:
	...

The short version could look like

	jsimmons@heisenberg.transvirtual.com:
		A bunch of fixes.
		Pmac updates
		Some more small fixes.

	rmk@arm.linux.org.uk:
		[PATCH] 2.5.13: vmalloc link failure

	...

ie only take the first line, and merge entries with the same author.

Perl people, stand up.

		Linus

