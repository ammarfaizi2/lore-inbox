Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbUGYL7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUGYL7y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 07:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbUGYL7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 07:59:54 -0400
Received: from fep17.inet.fi ([194.251.242.242]:17871 "EHLO fep17.inet.fi")
	by vger.kernel.org with ESMTP id S262114AbUGYL7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 07:59:52 -0400
From: Jan Knutar <jk-lkml@sci.fi>
To: Tim Wright <timw@splhi.com>
Subject: Re: New dev model (was [PATCH] delete devfs)
Date: Sun, 25 Jul 2004 14:59:46 +0300
User-Agent: KMail/1.6.2
Cc: Adrian Bunk <bunk@fs.tum.de>, Paul Jackson <pj@sgi.com>, akpm@osdl.org,
       corbet@lwn.net, linux-kernel@vger.kernel.org
References: <40FEEEBC.7080104@quark.didntduck.org> <20040722232540.GH19329@fs.tum.de> <1090549329.6113.21.camel@kryten.internal.splhi.com>
In-Reply-To: <1090549329.6113.21.camel@kryten.internal.splhi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407251459.46952.jk-lkml@sci.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That is their choice, but there's no particular need to run a kernel.org
> kernel. Unless you're messing around with the kernel or have a hot
> requirement for some new feature, why would running a stable kernel from
> e.g. Debian not suffice? Debian is free and freely available, and it's
> not the only distribution that is that way.

In the past, my experience, shared by many users, I'm sure, has been
that distribution kernels generally give you worse performance (IME RH)
and less stability (IME Fedora).

There's an increasing amount of hardware out there in wide-spread use,
which have no drivers in either kernel.org tree or distribution trees. The
fragmentation between the distributions already make it impossible to
get those drivers to compile on anything but the kernel.org tree, unless
the author of the driver is wealthy and has the resources and floorspace
to have a few different machines with different distributions installed,
and the time and resources for creating workarounds and Makefile
trickery for each and every one. I don't mean binary drivers here, as
they are usually backed by some corporation and target the usual
distributions...

Thus, we have a whole generation of users out there who grew up
with the idea that the distribution kernel is just some bloated,
bug-ridden and mostly incompatible monstrosity that is only barely
good for bootstrapping kernel.org kernel before starting to try
compile the drivers for their hardware.

Trying to change this idea is of course difficult, as everyone is
afraid of change. "Will the drivers break next release?", "Will
I have to stay with an old and exploitable kernel sometime
in the future when the drivers no longer compile on anything
but kernel.org X.Y.Z, when distro is X.Y.(Z-3)-secfix42, and kernel.org
is up to X.Y.Z+5?"

It might very well be that pushing out a large portion of the dev
burden to the periphery will be good in the long term for the
development of the kernel, but in short-term, I only see the
fragmentation problem getting worse. I hope I can be
brutally proven absolutely wrong, though. :-)
