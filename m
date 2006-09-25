Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWIYU7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWIYU7H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 16:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWIYU7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 16:59:06 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12256 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751191AbWIYU7F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 16:59:05 -0400
Date: Mon, 25 Sep 2006 12:53:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
Message-ID: <20060925105355.GA4390@elf.ucw.cz>
References: <45150CD7.4010708@aknet.ru> <4516B2C8.4050202@aknet.ru> <4516B721.5070801@redhat.com> <4516C9D0.3080606@aknet.ru> <ef6ldq$uup$1@taverner.cs.berkeley.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef6ldq$uup$1@taverner.cs.berkeley.edu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> The consensus has been to add the same checks to mprotect.  They were
> >> not left out intentionally.
> >
> >But how about the anonymous mmap with PROT_EXEC set?
> 
> I'm curious about this, too.  ld-linux.so is a purely unprivileged
> program.  It isn't setuid root.  Can you write a variant of ld-linux.so
> that reads an executable into memory off of a partition mounted noexec and
> then begins executing that code?  (perhaps by using anonymous mmap
> with

Yes, you can, but to execute your ld-linux-ignore-noexec.so variant,
you need to put it somewhere with exec permissions, right?
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
