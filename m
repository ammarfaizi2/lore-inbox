Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbTLDAXh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 19:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbTLDAXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 19:23:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:23972 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262395AbTLDAXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 19:23:35 -0500
Date: Wed, 3 Dec 2003 16:23:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kendall Bennett <KendallB@scitechsoft.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <Pine.LNX.4.58.0312031533530.2055@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0312031614000.2055@home.osdl.org>
References: <3FCDE5CA.2543.3E4EE6AA@localhost> <Pine.LNX.4.58.0312031533530.2055@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Dec 2003, Linus Torvalds wrote:
>
> So being a module is not a sign of not being a derived work. It's just
> one sign that _maybe_ it might have other arguments for why it isn't
> derived.

Side note: historically, the Linux kernel module interfaces were really
quite weak, and only exported a few tens of entry-points, and really
mostly effectively only allowed character and block device drivers with
standard interfaces, and loadable filesystems.

So historically, the fact that you could load a module using nothing but
these standard interfaces tended to be a much stronger argument for not
being very tightly coupled with the kernel.

That has changed, and the kernel module interfaces we have today are MUCH
more extensive than they were back in '95 or so. These days modules are
used for pretty much everything, including stuff that is very much
"internal kernel" stuff and as a result the kind of historic "implied
barrier" part of modules really has weakened, and as a result there is not
avery strong argument for being an independent work from just the fact
that you're a module.

Similarly, historically there was a much stronger argument for things like
AFS and some of the binary drivers (long forgotten now) for having been
developed totally independently of Linux: they literally were developed
before Linux even existed, by people who had zero knowledge of Linux. That
tends to strengthen the argument that they clearly aren't derived.

In contrast, these days it would be hard to argue that a new driver or
filesystem was developed without any thought of Linux. I think the NVidia
people can probably reasonably honestly say that the code they ported had
_no_ Linux origin. But quite frankly, I'd be less inclined to believe that
for some other projects out there..

			Linus
