Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313744AbSDPQLt>; Tue, 16 Apr 2002 12:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313754AbSDPQLG>; Tue, 16 Apr 2002 12:11:06 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62992 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313744AbSDPQJT>; Tue, 16 Apr 2002 12:09:19 -0400
Date: Tue, 16 Apr 2002 09:06:29 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        David Lang <david.lang@digitalinsight.com>,
        Vojtech Pavlik <vojtech@suse.cz>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.8 IDE 36
In-Reply-To: <200204161558.g3GFwMH10945@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.33.0204160902570.1319-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Apr 2002, Richard Gooch wrote:
>
> What I object to is the removal of a feature that people depend on,
> *without a replacement being made available prior to removal*. If you
> want to remove a feature, build the replacement *first*. Don't remove
> the feature and say "the rest of you can pick up the pieces".

Hey, that happens all the time - look how many times VFS changes have made
various filesystems unusable (including yours ;)

The fact is, many things are easier to fix afterwards. Particularly
because that's the only time you'll find people motivated enough to bother
about it. If you were to need to fix everything before-the-fact, nothing
fundamental would ever get fixed, simply because the people who can fix
one thing are not usually the same people who can fix another.

(Just to take an example that _isn't_ the IDE driver, this is exactly what
the more generic bio changes have been an example of - it's just
inconceivable to fix every use of the old request interface, so somebody
has to take the first step and taker the heat about it. Otherwise it never
gets anywhere)

		Linus

