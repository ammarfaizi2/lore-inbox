Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbUBYXYb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 18:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbUBYXVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 18:21:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:60842 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261575AbUBYXPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 18:15:12 -0500
X-Authenticated: #20799612
Date: Thu, 26 Feb 2004 00:13:08 +0100
From: Hansjoerg Lipp <hjlipp@web.de>
To: Paul Jackson <pj@sgi.com>
Cc: aebr@win.tue.nl, jamie@shareable.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6: shebang handling in fs/binfmt_script.c
Message-ID: <20040225231308.GA7744@hobbes>
References: <20040222020911.2c8ea5c6.pj@sgi.com> <20040222155410.GA3051@hobbes> <20040222125312.11749dfd.pj@sgi.com> <20040222225750.GA27402@mail.shareable.org> <20040222214457.6f8d2224.pj@sgi.com> <20040223142215.GB30321@mail.shareable.org> <20040223173446.GA2830@pclin040.win.tue.nl> <20040223134610.3b6d01a9.pj@sgi.com> <20040224011355.GC6426@hobbes> <20040223172942.5a18528a.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040223172942.5a18528a.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 05:29:42PM -0800, Paul Jackson wrote:
> > I don't see any reason, why one should stick to the limits of some other
> > operating systems, when it's not necessary.
> 
> If I make it a habit to write portable code, then over the years, I
> cause fewer problems for myself and others.  More things "just work". 
> I've got scripts that I use that are 10 or 20 years old, and have been
> used on all manner of evironments that could not have been anticipated
> when the script was first written.

Yes, it's true, that this is often sensible. But I also think, that
sometimes we must get rid of old restrictions, that don't make much
sense.

The patch does not prevent you from writing portable scripts, but it
allows us to write scripts, that can't be written without this change
(or you need some work around like wrappers or an interpreter parsing
the shebang line on its own).

And because you could see this patch as a step towards other operating
systems to reduce the chaos the web pages mentioned in this thread
show[1], this patch might even make scripts written for other operating
systems work under Linux. So, there are not only disadvantages with
regard to portability.

Regards,

	Hansjoerg Lipp

[1] http://www.in-ulm.de/~mascheck/various/shebang/
    http://homepages.cwi.nl/~aeb/std/hashexclam-1.html
