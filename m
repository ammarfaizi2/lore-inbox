Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWF1Tt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWF1Tt1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 15:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWF1Tt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 15:49:27 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54696 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751124AbWF1Tt0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 15:49:26 -0400
Date: Wed, 28 Jun 2006 21:49:13 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ulrich Drepper <drepper@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Jason Baron <jbaron@redhat.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: make PROT_WRITE imply PROT_READ
Message-ID: <20060628194913.GA18039@elf.ucw.cz>
References: <fa.PuMM6IwflUYh1MWILO9rb6z4fvY@ifi.uio.no> <449B42B3.6010908@shaw.ca> <Pine.LNX.4.64.0606230934360.24102@dhcp83-5.boston.redhat.com> <1151071581.3204.14.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0606231002150.24102@dhcp83-5.boston.redhat.com> <1151072280.3204.17.camel@laptopd505.fenrus.org> <a36005b50606241145q4d1dd17dg85f80e07fb582cdb@mail.gmail.com> <20060627095632.GA22666@elf.ucw.cz> <a36005b50606280943l54138e80tbda08e1607136792@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a36005b50606280943l54138e80tbda08e1607136792@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2006-06-28 09:43:22, Ulrich Drepper wrote:
> On 6/27/06, Pavel Machek <pavel@ucw.cz> wrote:
> >Usability for "normal" C applications is probably not too high... so
> >why not work around it in glibc, if at all?
> 
> Because it wouldn't affect all b inaries.  Existing code could still
> cause the problem.  Also, there are other callers of the syscalls

_There is no problem_. 

mmap() behaviour always was platform-specific, and it happens to be
quite strange on i386. So what.

> (direct, other libcs, etc).  The only reliable way to get rid of this
> problem is to enforce it in the kernel.  Since the kernel cannot make
> sense of this setting in all situations it is IMO even necessary since
> you really don't want to have anything as unstable as this code.

Current kernel behaviour is useful for specialized apps. If you do not
want to see that weirdness in regular c application, work around it in
glibc.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
