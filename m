Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276793AbRJDQLV>; Thu, 4 Oct 2001 12:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276922AbRJDQLL>; Thu, 4 Oct 2001 12:11:11 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:61064 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S276793AbRJDQLG>;
	Thu, 4 Oct 2001 12:11:06 -0400
Date: Thu, 4 Oct 2001 12:11:34 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: Security question: "Text file busy" overwriting executables but
 not shared libraries?
In-Reply-To: <Pine.LNX.4.33.0110040842320.8350-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0110041153560.28270-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Oct 2001, Linus Torvalds wrote:

>    In short, now you need filesystem versioning at a per-page level etc.

*ding* *ding* *ding* we have a near winner.  Remember, folks, Hurd had been
started by people who not only don't understand UNIX, but detest it.
ITS/TWENEX refugees.  And semantics in question comes from there -
they had "open and make sure that anyone who tries to modify will get
a new version, leaving one we'd opened unchanged".

> Trust me. The people who came up with MAP_COPY were stupid. Really. It's
> an idiotic concept, and it's not worth implementing.

Well, actually that's a concept that made sense on system we got mmap from[1]
They just want infection to be complete.

[1] cue Tom Lehrer singing "I got it from Agnes, she got it from Jim"

