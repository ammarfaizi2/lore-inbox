Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288948AbSANVjC>; Mon, 14 Jan 2002 16:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289078AbSANVim>; Mon, 14 Jan 2002 16:38:42 -0500
Received: from THANK.THUNK.ORG ([216.175.175.163]:8587 "EHLO thunk.org")
	by vger.kernel.org with ESMTP id <S288948AbSANVid>;
	Mon, 14 Jan 2002 16:38:33 -0500
Date: Mon, 14 Jan 2002 12:54:33 -0500
From: Theodore Tso <tytso@mit.edu>
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
        felix-dietlibc@fefe.de, andersen@codepoet.org
Subject: Re: [RFC] klibc requirements, round 2
Message-ID: <20020114125433.A1357@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Juan Quintela <quintela@mandrakesoft.com>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, felix-dietlibc@fefe.de,
	andersen@codepoet.org
In-Reply-To: <20020110231849.GA28945@kroah.com> <m2r8ovjpey.fsf@trasno.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <m2r8ovjpey.fsf@trasno.mitica>; from quintela@mandrakesoft.com on Sat, Jan 12, 2002 at 09:16:21PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 09:16:21PM +0100, Juan Quintela wrote:
> >>>>> "greg" == Greg KH <greg@kroah.com> writes:
> 
> Hi
> 
> greg> To summarize, here's a partial list of the programs people want to run:
> greg> - mount
> greg> - hotplug
> greg> - busybox
> greg> - dhcpcd
> greg> - image viewer
> greg> - mkreiserfs
> greg> - partition discovery (currently in the kernel)
> greg> - lots of other, existing in kernel code.
> 
> I still think that fsck at this point will be great.  You will
> minimize the need to have the kernel special case for fsck the root fs
> with respect to the rest of fs.

The development sources for e2fsprogs will already work with diet
libc.  Unfortunately, diet libc doesn't do shared libraries, so
resulting binaries are sufficiently big that I doubt they would be
interesting for initrd and rescue floppy applications (which is why I
tried the experiment in the first place).

In any case, given that e2fsprogs is already portable to NetBSD and
Solaris (the latter so I can run purify to catch memory errors), it
shouldn't be particularly difficult to get e2fsprogs to run on some
other alternative libc.

						- Ted

