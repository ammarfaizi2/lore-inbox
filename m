Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbWEHQhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWEHQhO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 12:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWEHQhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 12:37:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43690 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932413AbWEHQhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 12:37:12 -0400
Date: Mon, 8 May 2006 12:36:50 -0400
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>,
       Daniel Hokka Zakrisson <daniel@hozac.com>, linux-kernel@vger.kernel.org,
       =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
       greg@kroah.com, matthew@wil.cx
Subject: Re: [PATCH] fs: fcntl_setlease defies lease_init assumptions
Message-ID: <20060508163650.GC3162@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Pekka Enberg <penberg@cs.helsinki.fi>,
	Daniel Hokka Zakrisson <daniel@hozac.com>,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	greg@kroah.com, matthew@wil.cx
References: <445E80DD.9090507@hozac.com> <Pine.LNX.4.64.0605072030280.3718@g5.osdl.org> <84144f020605080131r58ce2a93w6c7ba784a266bbeb@mail.gmail.com> <84144f020605080134q7e16f37fl385359c634ece8ca@mail.gmail.com> <Pine.LNX.4.64.0605080807430.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605080807430.3718@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 08:12:18AM -0700, Linus Torvalds wrote:

 > Fedora had DEBUG_SLAB enabled in their development kernel, and that 
 > actually helped a lot. But I suspect they may _not_ have it in their 
 > non-development ones, and those have a much bigger test-base, so it might 
 > well be worth it to have a good base-line that catches serious problems, 
 > and have DEBUG_SLAB enable the expensive tests.

That's correct. Though at times I'll build a one-off test kernel if I'm
suspicious about something, and push that out as a testing update before
the real update goes live.

Those typically don't get anywhere near the level of exposure as our
development kernels though, so they tend not to show up problems as often.

We also carry the 'check the redzones of non-free slabs every few minutes'
patch, which turned up some things once or twice, but nothing else in
quite a while.

		Dave

-- 
http://www.codemonkey.org.uk
