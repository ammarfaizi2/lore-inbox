Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289319AbSAOLzs>; Tue, 15 Jan 2002 06:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289325AbSAOLzi>; Tue, 15 Jan 2002 06:55:38 -0500
Received: from codeblau.walledcity.de ([212.84.209.34]:10509 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id <S289319AbSAOLz3>;
	Tue, 15 Jan 2002 06:55:29 -0500
Date: Tue, 15 Jan 2002 12:55:44 +0100
From: Felix von Leitner <felix-dietlibc@fefe.de>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
        andersen@codepoet.org
Subject: Re: [RFC] klibc requirements
Message-ID: <20020115115544.GA20020@codeblau.de>
In-Reply-To: <20020109042331.GB31644@codeblau.de> <200201150308.g0F38rp502016@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200201150308.g0F38rp502016@saturn.cs.uml.edu>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake Albert D. Cahalan (acahalan@cs.uml.edu):
> I think the dietlibc idea has to be scrapped so we can run BSD apps.
> (and others maybe, but I'm not looking to start a flame war)

What apps are you talking about?

> DNS is very good to have. There are many things one might want
> to specify by name. NFS servers, NIS servers, SMB servers, and
> even the machine itself to get an IP via DNS.

You don't need NIS or SMB before mounting the root disk.
If you want NFS to mount your root file system, you get the IP via DHCP
normally, so you don't need DNS.  And you can't get your own IP via DNS
because you need to have an IP to use DNS.

> Even with ELF, you shouldn't need that 10 kB.

Please go ahead and implement it.
Fame and fortune await you! ;)

> Treat ELF like a.out, getting rid of the -fPIC stuff in favor of
> offsets assigned when you build the initramfs.

ELF is a standard.
You can't just go out and re-invent dynamic linking completely.
First and most importantly of all, the GNU toolchain support the ELF
standard, not my personal ELF dialect.  I have no desire to write a
linker.  I'm happy enough that I found Olaf who was willing to write an
ld.so (and I was close enough to hear all his ranting about how complex
ELF is).

> Dynamic linking should
> be:

> open
> mmap
> mmap
> close

> You know the file to open. You know what offset you need it at.
> There isn't any need for symbols. OK, that's half-dynamic,
> but it gets the job done.

Again, please do it.  I know that it would be possible.  But it would
not be standard and I don't think it's worth the effort.  The most
important reason is that static linking produces small binaries with the
diet libc and uclibc.  As long as your software does not destroy that by
having a few dozen mini binaries around, all linked against the same
monster do-it-all library, it works.

Felix
