Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288579AbSA3Ijd>; Wed, 30 Jan 2002 03:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288752AbSA3IjY>; Wed, 30 Jan 2002 03:39:24 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:49358 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S288579AbSA3IjI>;
	Wed, 30 Jan 2002 03:39:08 -0500
Date: Wed, 30 Jan 2002 03:39:06 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Francesco Munda <syylk@libero.it>
Cc: LK <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130033906.I32317@havoc.gtf.org>
In-Reply-To: <200201282213.g0SMDcU25653@snark.thyrsus.com> <200201290137.g0T1bwB24120@karis.localdomain> <a354iv$ai9$1@penguin.transmeta.com> <200201300803.g0U83uB24903@karis.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200201300803.g0U83uB24903@karis.localdomain>; from syylk@libero.it on Wed, Jan 30, 2002 at 09:03:55AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 09:03:55AM +0100, Francesco Munda wrote:
> In short: I think there are too many concurrent, overlapping development
> trees, with a web of crosspatches that are honestly difficult to follow from
> my "download, make, lilo, reboot, report" viewpoint. A fragmentation in the
> to-be-tested code. A single "reference development" tree would be most
> welcome.

2.5.x is the reference development tree.

People building outside-the-kernel patchkits is indeed useful for
end users to conveniently test a bunch of patches... but attempting
to merge various concurrent trees would be murder on code quality.
Do we want XFS ACLs in the reference development tree, just to yank
or modify syscalls before the final revision?  No.  Therefore, XFS
needs to be in its own tree until its ready.

Notice the gcc team will create a branch for development, even
during a development cycle (ie. no freeze at all), just to ensure
that large or complex changes do not destabilize the tree until they
are really ready.

Finally, even in a devel cycle kernel hackers need some semblance of a
sane tree in order to do their own development.  If tons of hackers
are blazing away committing all sorts of code, you have nothing but
a tree of mass confusion, in a nice package for users to test.

	Jeff



