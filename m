Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263030AbVALGLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263030AbVALGLF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 01:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbVALGLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 01:11:05 -0500
Received: from orb.pobox.com ([207.8.226.5]:60036 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S263030AbVALGKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 01:10:54 -0500
Date: Tue, 11 Jan 2005 22:10:43 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: "Barry K. Nathan" <barryn@pobox.com>,
       David Lang <dlang@digitalinsight.com>, Jesper Juhl <juhl-lkml@dif.dk>,
       Andries Brouwer <aebr@win.tue.nl>, Linus Torvalds <torvalds@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make uselib configurable (was Re: uselib()  & 2.6.X?)
Message-ID: <20050112061043.GG4325@ip68-4-98-123.oc.oc.cox.net>
References: <20050111235907.GG2760@pclin040.win.tue.nl> <Pine.LNX.4.61.0501120203510.2912@dragon.hygekrogen.localhost> <Pine.LNX.4.60.0501111714450.18921@dlang.diginsite.com> <20050111223641.GA27100@logos.cnet> <20050112023218.GF4325@ip68-4-98-123.oc.oc.cox.net> <20050112005647.GB27653@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112005647.GB27653@logos.cnet>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 10:56:47PM -0200, Marcelo Tosatti wrote:
> Out of curiosity do you have a list of such syscalls?

Not yet. I wasn't expecting to need the list quite this soon.

> "usually" is the problem - you cannot be sure what syscalls unknown
> applications are using. 
[snip]
> > And if you have programs that need it, you (or your vendor) can set the
> > config option accordingly.
> 
> The possibility is that there might be unknown applications which use
> these "obsolete" system calls. 

True, but I would expect to see a strong correlation between the use of
"obsolete" syscalls and the use of "obsolete" libraries (libc4, libc5).
Until there's a list of obsolete syscalls, we can't say for sure,
though.

> Vendors who want to support older applications (most distributions) will
> have to enable all these option(s), while users who do not need one or
> a few of them can disable accordingly ("specialized" applications).

There are at least one or two distributions (I'm thinking of vendors
named after headwear, although there are probably others) that have not
shipped libc5 compat libraries for a long while. IIRC they're also
shipping their kernels with CONFIG_BINFMT_AOUT completely disabled
(not even modular).

So, these vendors at least are (to the best of my knowledge) only
supporting older applications *up to a point*.

> I personally dont like the idea of disabling "obsolete" system calls
> with config options, but it is useful for specialized applications to
> save memory. 
> 
> Are many users going to benefit from it?

It's going to be hard to tell without full-blown code to examine and
test, but my hope is that it will be able to disable something
substantial for people who have completely abandoned libc4/libc5. And
that's many users.

Even if the final patch is unable to benefit many users, perhaps the
process of creating that patch will still be worth it if it gives us a
better idea of which syscalls are being used and which ones aren't.

-Barry K. Nathan <barryn@pobox.com>

