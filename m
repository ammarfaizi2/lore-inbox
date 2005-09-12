Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbVILIKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbVILIKX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 04:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbVILIKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 04:10:23 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:63455 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751211AbVILIKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 04:10:22 -0400
Date: Mon, 12 Sep 2005 01:09:54 -0700
From: Paul Jackson <pj@sgi.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, hpa@zytor.com, bunk@stusta.de
Subject: Re: [RFC][MEGAPATCH] Change __ASSEMBLY__ to __ASSEMBLER__ (defined
 by GCC from 2.95 to current CVS)
Message-Id: <20050912010954.70ac90e2.pj@sgi.com>
In-Reply-To: <93E9C5F9-A083-4322-A580-236E2232CCC0@mac.com>
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com>
	<20050903064124.GA31400@codepoet.org>
	<4319BEF5.2070000@zytor.com>
	<B9E70F6F-CC0A-4053-AB34-A90836431358@mac.com>
	<dfhs4u$1ld$1@terminus.zytor.com>
	<5A37B032-9BBD-4AEA-A9BF-D42AFF79BC86@mac.com>
	<9C47C740-86CF-48F1-8DB6-B547E5D098FF@mac.com>
	<97597F8E-DDCE-479F-AE8D-CC7DC75AB3C3@mac.com>
	<20050910014543.1be53260.akpm@osdl.org>
	<4FAE9F58-7153-4574-A2C3-A586C9C3CFF1@mac.com>
	<20050910150446.116dd261.akpm@osdl.org>
	<E352D8E3-771F-4A0D-9403-DBAA0C8CBB83@mac.com>
	<20050910174818.579bc287.akpm@osdl.org>
	<93E9C5F9-A083-4322-A580-236E2232CCC0@mac.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle wrote:
> This would make life a million times easier for the UML people,
> the glibc people, the klibc people, and the linux-libc-headers
> maintainer

Spraying wildly from the hip with my Uzi ...

If the several groups you list would all benefit from some particular
form of kernel headers that is not what we have now, then why don't
they pool together and have one person maintain such a header set,
keeping it current with the kernel.  It could even (Lord Linus willing)
be given a place to live in the kernel source: "the kernel-user API,
as seen from userland".

But trying to cram that header view into the same files as the kernel's
internal view of itself seems like a fools errand.

Heck, on a good day, you might even get an occassional kernel patch
that included the corresponding kernel-user API header change, rather
as happens now with the Documentation files.  And efforts to keep
stuff usable with C++ code could be welcomed on such headers, where
they are rejected for kernel internals.

Bottom line - leave all existing kernel files as they are, and add
a new subdirectory, for these new header files.  Agree amongst
yourselves (the above named groups) on a MAINTAINER, and start
crafting the headers you need, in the style to which you wish to
become accustomed.

Don't confuse theory and practice.  In theory, these new headers
present information already known to the kernel, so should not
be separate.  But in practice, the demands are sufficiently different
that it will be easier to maintain as a separate set of headers.

Better two simple answers than one convoluted answer.

... hopefully my stray bullets didn't harm any innocents.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
