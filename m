Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289084AbSANV6D>; Mon, 14 Jan 2002 16:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289088AbSANV5x>; Mon, 14 Jan 2002 16:57:53 -0500
Received: from waste.org ([209.173.204.2]:17815 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S289084AbSANV5o>;
	Mon, 14 Jan 2002 16:57:44 -0500
Date: Mon, 14 Jan 2002 15:57:20 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Theodore Tso <tytso@mit.edu>
cc: Juan Quintela <quintela@mandrakesoft.com>, Greg KH <greg@kroah.com>,
        <linux-kernel@vger.kernel.org>, <felix-dietlibc@fefe.de>,
        <andersen@codepoet.org>
Subject: Re: [RFC] klibc requirements, round 2
In-Reply-To: <20020114125433.A1357@thunk.org>
Message-ID: <Pine.LNX.4.43.0201141550170.31316-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, Theodore Tso wrote:

> On Sat, Jan 12, 2002 at 09:16:21PM +0100, Juan Quintela wrote:
> > >>>>> "greg" == Greg KH <greg@kroah.com> writes:
> >
> > Hi
> >
> > greg> To summarize, here's a partial list of the programs people want to run:
> > greg> - mount
> > greg> - hotplug
> > greg> - busybox
> > greg> - dhcpcd
> > greg> - image viewer
> > greg> - mkreiserfs
> > greg> - partition discovery (currently in the kernel)
> > greg> - lots of other, existing in kernel code.
> >
> > I still think that fsck at this point will be great.  You will
> > minimize the need to have the kernel special case for fsck the root fs
> > with respect to the rest of fs.
>
> The development sources for e2fsprogs will already work with diet
> libc.  Unfortunately, diet libc doesn't do shared libraries, so
> resulting binaries are sufficiently big that I doubt they would be
> interesting for initrd and rescue floppy applications (which is why I
> tried the experiment in the first place).

Let's separate out the rescue disk and normal boot scenarios here.
Obviously the ideal for a rescue disk is to include as much useful stuff
as physically possible and that's not something we should be concerning
ourselves with for normal boot.

For normal boot (which is what we are talking about, as all booting is
moving to initramfs), we want enough code to get to the point where we
mount root read-only (no fsck!) and that means enough to load modules and
possibly get NFS up. And whatever else that's already in the kernel simply
for boot that can be moved to userspace. Nothing else.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

