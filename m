Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030516AbWJDS1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030516AbWJDS1L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 14:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030642AbWJDS1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 14:27:11 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:37263 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S1030516AbWJDS1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 14:27:09 -0400
Date: Wed, 4 Oct 2006 20:26:55 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dave Jones <davej@redhat.com>, Arjan van de Ven <arjan@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: another attempt to kill off linux/config.h
Message-ID: <20061004182655.GA9847@uranus.ravnborg.org>
References: <20061004074434.GA13672@redhat.com> <20061004112450.GA6858@uranus.ravnborg.org> <1159962332.3000.15.camel@laptopd505.fenrus.org> <20061004180122.GC13079@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061004180122.GC13079@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 02:01:22PM -0400, Dave Jones wrote:
> On Wed, Oct 04, 2006 at 01:45:32PM +0200, Arjan van de Ven wrote:
> 
>  > > Removing it for real will be a pain for external modules.
>  > > They could of course detect that it is missing and then
>  > > drop it.
>  > > I would suggest to keep the #warning in 2.6.19 and only
>  > > remove it for real for 2.6.20.
>  > 
>  > they'll have to change anyway; delaying it one release doesn't actually
>  > change that. And you can bet on most modules ignoring the warning anyway
>  > and wait until the thing really is gone... making the value that this
>  > extra delay has basically zero. While the cost is that more false users
>  > will sneak into the kernel ;(
> 
> My thoughts exactly.  Since when did we give a damn about keeping
> external modules compiling anyway?

In kbuild quite a lot of effort has been done to make life easier
for those dealing with external modules. There are several
reasons to deal with external modules:
- Alpha stage module that is not yet ready for kernel inclusion
- Special stuff that does not belong in the kernel for som reason
- Experimental stuff of any kind

This covers maybe one fifth of all external modules but that is enough
to make proper support anyway.

That said I continue to be mystified over how much effort the external
module people put into avoiding using kbuild.
I have even seen external modules that mixed up proper kbuild
supported modules and old 2.4 style modules in the same Makefile.

And the effort trying to deal with vermagic stuff in external modules,
inspecting CFLAGS setting etc. is just countless :-(

But that does not change my point about giving these people a proper
warning in at least one kernel release.

	Sam
