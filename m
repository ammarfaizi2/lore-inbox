Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161022AbWASE4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161022AbWASE4c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 23:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161317AbWASE4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 23:56:32 -0500
Received: from sccrmhc11.comcast.net ([63.240.77.81]:49649 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1161144AbWASE4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 23:56:31 -0500
Subject: Re: [PATCH] prototypes for *at functions & typo fix
From: Nicholas Miell <nmiell@comcast.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060118203733.5aac5ee4.akpm@osdl.org>
References: <200601190429.k0J4TWXD018136@devserv.devel.redhat.com>
	 <20060118203733.5aac5ee4.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 20:56:26 -0800
Message-Id: <1137646586.2842.6.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 20:37 -0800, Andrew Morton wrote:
> Ulrich Drepper <drepper@redhat.com> wrote:
> >
> > Do we really need the __NR_ia32_* macros?  The userlevel on x86-64 should be bi-arch and provide the native ia32 unistd.h.
> 
> I'd have thought that x86 and x86_64 could source-level-share the syscall
> table, yes.  ppc manages to.

AMD64 renumbered all the syscalls for optimal cacheline usage or
something stupid like that. I suppose the x86 emulation on AMD64 kernels
could share the i386 table, but then _NR_foo will have a different value
depending on context, and that'll just get confusing.

-- 
Nicholas Miell <nmiell@comcast.net>

