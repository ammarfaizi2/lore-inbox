Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277509AbRJOMLK>; Mon, 15 Oct 2001 08:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277501AbRJOMLA>; Mon, 15 Oct 2001 08:11:00 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:25039 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S277509AbRJOMKs>;
	Mon, 15 Oct 2001 08:10:48 -0400
Date: Mon, 15 Oct 2001 08:11:20 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] "Text file busy" when overwriting libraries
In-Reply-To: <E15t6XR-0001xy-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0110150804400.8707-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Oct 2001, Alan Cox wrote:

> > Anyone can write it, but what the hell will he do without write access to
> > any place that wouldn't be mounted noexec?  Environment can be restricted
> > even if you give them shell...
> 
> He will type "perl" and interactively issue any damn syscall he likes
> subject to the normal permissions rules. Noexec is only useful for a user
> given virtually nothing.

... and will hit "permission denied" on attempt to exec /usr/bin/perl.
Blanket noexec on /usr instance mounted in his chroot with selective turning
the thing off on some binaries.  And yes, I realize that one can always
hunt for buffer overruns in sh(1)...

