Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161052AbWF0J5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161052AbWF0J5S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 05:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbWF0J5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 05:57:18 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44262 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964868AbWF0J5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 05:57:17 -0400
Date: Tue, 27 Jun 2006 11:56:32 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ulrich Drepper <drepper@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Jason Baron <jbaron@redhat.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: make PROT_WRITE imply PROT_READ
Message-ID: <20060627095632.GA22666@elf.ucw.cz>
References: <fa.PuMM6IwflUYh1MWILO9rb6z4fvY@ifi.uio.no> <449B42B3.6010908@shaw.ca> <Pine.LNX.4.64.0606230934360.24102@dhcp83-5.boston.redhat.com> <1151071581.3204.14.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0606231002150.24102@dhcp83-5.boston.redhat.com> <1151072280.3204.17.camel@laptopd505.fenrus.org> <a36005b50606241145q4d1dd17dg85f80e07fb582cdb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a36005b50606241145q4d1dd17dg85f80e07fb582cdb@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >you ask for it, and the kernel is supposed to deliver the best behavior
> >it can.
> 
> The kernel should provide
> 
> - a stable, reliable interface
> 
> - a consistent interface at least accross architectures, maybe even 
> platforms
> 
> 
> Providing write-only support for memory falls into none of these
> categories.  When Jason and I discussed this my position actually was
> to disallow PROT_WRITE without PROT_READ completely, making it an
> error of mmap and mprotect.  That's perfectly legal according to POSIX
> and it will teach those who write broken code like this.

Well, some hardware can probably support write-only, and such support
can be useful for "weird" applications, such as just-in-time
compilers, etc.

Usability for "normal" C applications is probably not too high... so
why not work around it in glibc, if at all?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
