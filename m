Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbWASGhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbWASGhp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 01:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbWASGhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 01:37:45 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:39114 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S964928AbWASGho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 01:37:44 -0500
Subject: Re: [PATCH] prototypes for *at functions & typo fix
From: Nicholas Miell <nmiell@comcast.net>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <43CF2CA3.5020001@redhat.com>
References: <200601190429.k0J4TWXD018136@devserv.devel.redhat.com>
	 <20060118203733.5aac5ee4.akpm@osdl.org> <1137646586.2842.6.camel@entropy>
	 <43CF2CA3.5020001@redhat.com>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 22:37:41 -0800
Message-Id: <1137652661.2842.7.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 22:07 -0800, Ulrich Drepper wrote:
> Nicholas Miell wrote:
> > AMD64 renumbered all the syscalls for optimal cacheline usage or
> > something stupid like that. I suppose the x86 emulation on AMD64 kernels
> > could share the i386 table, but then _NR_foo will have a different value
> > depending on context, and that'll just get confusing.
> 
> Yes, the syscall numbers are quite different, especially because x86 has
> all syscalls, even the obsolete ones.
> 
> But what I mean is that the __NR_ia32_* macros in
> asm-x86-64/ia32_unistd.h aren't used anywhere in the kernel.  And in
> userland the asm-x86/unistd.h file is used when compiling x86 apps.  At
> least this is how the kernel headers for userlevel use should be set up.

Ah, that makes sense. Actually, a few of them are used (sigreturn,
rt_sigreturn, and restart_syscall), but I suppose those could be defined
locally.

-- 
Nicholas Miell <nmiell@comcast.net>

