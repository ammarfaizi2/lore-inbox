Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292167AbSBOVje>; Fri, 15 Feb 2002 16:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292168AbSBOVjW>; Fri, 15 Feb 2002 16:39:22 -0500
Received: from cpe.atm4-0-118125.0x3ef2066b.hrnxx4.customer.tele.dk ([62.242.6.107]:26856
	"EHLO mars.ravnborg.org") by vger.kernel.org with ESMTP
	id <S292161AbSBOVjI>; Fri, 15 Feb 2002 16:39:08 -0500
Date: Fri, 15 Feb 2002 22:42:35 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Your opinion on CML2 and kbuild-2.5
Message-ID: <20020215224235.A1292@mars.ravnborg.org>
Mail-Followup-To: kbuild-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
In-Reply-To: <200202150057.g1F0v8P23914@golux.thyrsus.com> <3C6CE148.5020804@dplanet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C6CE148.5020804@dplanet.ch>; from cate@dplanet.ch on Fri, Feb 15, 2002 at 11:22:00AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2002 at 11:22:00AM +0100, Giacomo Catenazzi wrote:
[Not a single word about the battle ongoing at LKLM...]
> kbuild-2.5:
> 
> It does the right things! And this should be enought to tell you that
> it should be included in the next kernels.
When Keith brought up the inclusion of kbuild-2.5 last time the general
statement was that kbuild-2.5 had one fundamental error - speed.
I have tested it a while back, and my result was not as bad as the
roumours said about kbuild-2.5.
Light .config, Pentium 266 with 64 MB RAM.
kbuild-2.4 make dep + make bzImage ~55 minutes
kbuild-2.5 make installable        ~60 minutes

Then I added one more driver.
kbuild-2.4 make dep + make bzImage ~7 minutes
kbuild-2.5 make installable        ~2 minutes

So my conclusion was that one single change where *I* had to run
make dep made it worthwhile to shift to kbuild-2.5.
I know that *I* have to run make dep far more often than
all the kernel hackes - they know what they are doing in contrast.

With respect to kbuild-2.5 inclusion, I would vote for the distributed
configuration scheme that Linus et al. suggested a while ago.
[driver.conf that included makefile.in, configure.help etc.]

When kbuild-2.5 has been extended to support it, and the link-order
have been solved then it is due time for inclusion.
Jeff Garzik & Keith O. had some discussion about the link-order
problem a while ago, but at that point in time Keith stopped the
discussion whith the statement that he did not care about 2.5,
with reference to the refusual from Linus to accept among others
the LINK_FIRST - LINK_LAST patch.
I dunno what the conclusion on the link-order issue was.

What I read between the lines is that kbuild-2.5 should not only fix
the kbuild-2.4 bugs[*], but should also address the scalability issues
that Linus raised - before he accepts it.

[*] Bugs that I see, but kernel hackers are not hit by - because
they know what they are doing.

Personal I would like to see kbuild-2.5 included ASAP. Among other stuff
I like the compressed output during compilation.

	Sam
