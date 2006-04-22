Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWDVT0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWDVT0g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbWDVT0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:26:35 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:45243 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751058AbWDVTZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:25:59 -0400
Subject: Re: [PATCH] 'make headers_install' kbuild target.
From: David Woodhouse <dwmw2@infradead.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20060422142853.GB25926@mars.ravnborg.org>
References: <1145672241.16166.156.camel@shinybook.infradead.org>
	 <20060422093328.GM19754@stusta.de>
	 <1145707384.16166.181.camel@shinybook.infradead.org>
	 <20060422141410.GA25926@mars.ravnborg.org>
	 <20060422142043.GD5010@stusta.de>
	 <20060422142853.GB25926@mars.ravnborg.org>
Content-Type: text/plain
Date: Sat, 22 Apr 2006 15:47:07 +0100
Message-Id: <1145717227.11909.295.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-22 at 16:28 +0200, Sam Ravnborg wrote:
> First off:
> There are many other users that poke direct in the kernel source also.
> 
> Secondly and more importantly:
> Introducing kabi/ you will have a half solution where several users will
> have to find their stuff in two places for a longer period.
> kabi/ does not allow you to do it incrementally - it requires you to
> move everything over from a start.

Not really, because we have a 'make headers_install' target which puts
everything together in one place, cleaned up, for userspace. It can
quite happily pick up files from both the existing directories and the
new kabi/ directory. 

If Adrian wants to move stuff into a kabi/ directory as part of the
cleanups, that's fine. I think it's pointless, and I think it reduces
his chances of actually getting his cleanups merged, but if that's the
only way he'll contribute his time, then so be it. It doesn't do any
harm, technically.

But really, this whole discussion is counterproductive, IMO. 

The post-processing step to export headers to userspace is fine for now.
It lets us get on with the real work of cleaning the headers up. We've
been blocked on the trivia for too long already, and we're going down
that path again.

Once we have the actual contents of the headers classified as public vs.
private, and we know what we've got, _THEN_ we will have a clearer idea
of how those public headers should be organised. And it's _trivial_ to
move stuff around once it's been split out. It just doesn't _matter_
where we put it, for now.

What I'd really like to do is go into KS with the headers already
cleaned up, using 'make headers_install'. Show Linus the results, have a
coherent plan for how it _should_ be laid out so that the 'make
headers_install' step becomes just a copy, as Adrian and everyone else
wants. And have him actually agree to it this time.

We can't do it the other ways round. We tried that. If that was the only
way we could get Adrian to help us, then that's unfortunate, because
_this_ is the only way I think Linus is going to take it.

The end result is fairly much the same either way, and the amount of
work is the same. 

-- 
dwmw2

