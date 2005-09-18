Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbVIRKdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbVIRKdP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 06:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbVIRKdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 06:33:15 -0400
Received: from khc.piap.pl ([195.187.100.11]:7428 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1750900AbVIRKdP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 06:33:15 -0400
To: jesper.juhl@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why don't we separate menuconfig from the kernel?
References: <m364szk426.fsf@defiant.localdomain>
	<9a874849050917174635768d04@mail.gmail.com>
	<m3d5n7kwwz.fsf@defiant.localdomain>
	<9a87484905091718163bb72e58@mail.gmail.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 18 Sep 2005 12:33:12 +0200
In-Reply-To: <9a87484905091718163bb72e58@mail.gmail.com>
Message-ID: <m34q8ifyxj.fsf@defiant.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> writes:

> And if you do that, then you'd be shipping a kernel source that it
> would be impossible for users to configure without installing
> sepperate tools - and tools (unlike for example gcc) that very few
> people would have a need for outside configuring their kernel.

So what? We already have tools which are needed for just one thing.
This one is at least for configuring more than one program.

Of course, the kernel (kbuild or running the kernel) requires many
things, isn't it the UNIX philosophy?

Remember ksymoops? _That_ was a single purpose.

> I think there's a point; the kernel source should contain its own
> configuration tools.

Why only them? Why not the compiler toolchain (encoded with sharutils)
and some shell so you can bootstrap it over serial console? :-)

> Just think of how many users would complain that "the kernel is
> broken, I can't configure it" and similar.

Such users use distribution kernels. Distributions have package
dependencies which can install anything needed automatically.

How many times have you seen people complaining that the kernel is
broken as one "can't compile it" (due to missing binutils or even gcc)?

> Also, what would ensure
> that the config/build tools would always stay in sync with other
> kernel changes?

People sending patches, of course, and the maintainer doing kernel work
as well. What ensures that, say, udev stays in sync? And udev is new
and changing.

> if you extract a fresh kernel source and copy your old .config to
> .config in the new kernel source dir, then "make oldconfig" will read
> that .config and write a new one as well...

Sure, I don't know why I mentioned .config.old, they all use it the same.
Writing at 3 am, possibly.

> If someone wants to use the tools outside the kernel, then let them
> fork off a version and maintain that out-of tree. The in-kernel and
> out-of-kernel could borrow code and fixes from eachother if
> needed/wanted,

That's what is currently done, but it doesn't seem so smart from
maintenance POV. And UNIX philosophy, you know.
-- 
Krzysztof Halasa
