Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVALH6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVALH6v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 02:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVALH6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 02:58:51 -0500
Received: from [213.146.154.40] ([213.146.154.40]:9377 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261280AbVALH6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 02:58:49 -0500
Date: Wed, 12 Jan 2005 07:58:04 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: "Barry K. Nathan" <barryn@pobox.com>, Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make uselib configurable (was Re: uselib()  & 2.6.X?)
Message-ID: <20050112075804.GA13336@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andries Brouwer <aebr@win.tue.nl>,
	"Barry K. Nathan" <barryn@pobox.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58LT.0501071648160.30645@oceanic.wsisiz.edu.pl> <20050107170712.GK29176@logos.cnet> <1105136446.7628.11.camel@localhost.localdomain> <Pine.LNX.4.58.0501071609540.2386@ppc970.osdl.org> <20050107221255.GA8749@logos.cnet> <Pine.LNX.4.58.0501081042040.2386@ppc970.osdl.org> <20050111225127.GD4378@ip68-4-98-123.oc.oc.cox.net> <20050111235907.GG2760@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050111235907.GG2760@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 12:59:07AM +0100, Andries Brouwer wrote:
> s/sys_uselib/uselib/
> The system call is uselib().
> 
> Hmm - old cruft.. Why insult your users?
> I do not have source for Maple. And my xmaple binary works just fine.
> But it is a libc4 binary.
> 
> You mean "on the typical recently installed Linux system, with nothing
> but the usual Linux utilities".
> 
> People always claim that Linux is good in preserving binary compatibility.
> Don't know how true that was, but introducing such config options doesnt
> help.
> 
> Let me also mutter about something else.
> In principle configuration options are evil. Nobody wants fifty thousand
> configuration options. But I see them multiply like ioctls.
> There should be a significant gain in having a config option.
> 
> 
> Maybe some argue that there is a gain in security here. Perhaps.
> Or a gain in memory. It is negligible.
> I see mostly a loss.
> 
> There are more ancient system calls, like old_stat and oldolduname.
> Do we want separate options for each system call that is obsoleted?

Agreed to this complaint.  I still think it might be a good idea to
allow configuring obsolete syscalls out, but doing that on a per-syscall
basis sounds like a bad idea.  I always liked the way FreeBSD one
conditionals for everything that was obsoleted in a release.  So by setting
only few options you could select how old binaries you want to support,
defaulting to on for all of them.
