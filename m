Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbUK0VSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbUK0VSP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 16:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbUK0VSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 16:18:15 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:19256 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261338AbUK0VSN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 16:18:13 -0500
Date: Sat, 27 Nov 2004 22:19:23 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, David Howells <dhowells@redhat.com>,
       torvalds@osdl.org, hch@infradead.org, matthew@wil.cx,
       dwmw2@infradead.org, aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041127211923.GA21765@mars.ravnborg.org>
Mail-Followup-To: Andreas Steinmetz <ast@domdv.de>,
	Sam Ravnborg <sam@ravnborg.org>, David Howells <dhowells@redhat.com>,
	torvalds@osdl.org, hch@infradead.org, matthew@wil.cx,
	dwmw2@infradead.org, aoliva@redhat.com, linux-kernel@vger.kernel.org,
	libc-hacker@sources.redhat.com
References: <19865.1101395592@redhat.com> <20041127210331.GB7857@mars.ravnborg.org> <41A8ED8F.5010402@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A8ED8F.5010402@domdv.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2004 at 10:11:43PM +0100, Andreas Steinmetz wrote:
> >If we go for some resturcturing of include/ then we should get rid of
> >the annoying asm symlink. Following layout deals with that:
> >
> >include/<arch>/asm		<= Files from include/asm-<arch>
> >include/<arch>/mach*		<= Files from include/mach-*
> >
> >This layout solve the symlink issue in an elegant way.
> >We need to do trivial changes to compiler options to make it work. Changing
> >compiler options is much more relaible than using symlinks.
> >
> >Then the userspace part would then be located in:
> >include/<arch>/user-asm
> >
> 
> This complicates things for bi-arch architectures like x86_64 where one 
> can use a dispatcher directory instead of a symlink to suit include/asm 
> for 32bit as well as 64bit.
X86_64 does not create any special symlinks todays so I do not see the point?
And still a symlink is just the wrong way to solve the problem.
Adjusting options to the compiler is the way to do it.

	Sam
