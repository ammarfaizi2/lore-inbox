Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131586AbRDJMOj>; Tue, 10 Apr 2001 08:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131588AbRDJMO3>; Tue, 10 Apr 2001 08:14:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51204 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131586AbRDJMOS>;
	Tue, 10 Apr 2001 08:14:18 -0400
Date: Tue, 10 Apr 2001 13:14:12 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Eric S. Raymond" <esr@snark.thyrsus.com>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 1.0.0 release announcement
Message-ID: <20010410131412.A18973@flint.arm.linux.org.uk>
In-Reply-To: <200104101047.f3AAl0h07395@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200104101047.f3AAl0h07395@snark.thyrsus.com>; from esr@snark.thyrsus.com on Tue, Apr 10, 2001 at 06:47:00AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 06:47:00AM -0400, Eric S. Raymond wrote:
> On 30 March 2001 at the Kernel Summit, Keith Owens and I worked out a
> transition schedule with Linus.  Keith's rewrite of the makefile system and
> my configurator tools are officially slated to replace the present system in
> the 2.5.1 to 2.5.2 timeframe.  That, of course, is contingent on us not
> screwing up :-).

Assuming that Keiths makefiles can do everything that architecture
maintainers need it to do.

Currently, one of the many things I'm doing is trying to sort out a
working kbuild-2.5 for the ARM tree.  I have some stuff done, but there
are several things that I'm definitely not happy with, and there is
currently a whole scoop of stuff which I haven't yet found a way for
kbuild-2.5 to handle.  Its looking like the ARM trees use of kbuild-2.5
will be even more messy than its use of the current build system.

(We have around 60 machines, which key both which files get built, the
text and data address of the running kernel image, the text and data
address of the decompressor, and which vmlinux.lds.in file we use to
link the kernel.  This is currently my biggest problem that kbuild-2.5
doesn't seem to be able to handle at present.  Note that it is not
acceptable that users should have to type in 5 or so apparantly
meaningless hex addresses when they configure the kernel.)

I've yet to hear back from Keith on the issues I have with kbuild-2.5,
but I'm hopeful that he has some good suggestions...

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

