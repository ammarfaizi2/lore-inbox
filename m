Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbULODfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbULODfk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 22:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbULODfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 22:35:40 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:19408 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261848AbULODfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 22:35:33 -0500
Subject: Re: [RFC] dynamic syscalls revisited
From: Steven Rostedt <rostedt@goodmis.org>
To: Werner Almesberger <wa@almesberger.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1103076859.3582.66.camel@localhost.localdomain>
References: <1101741118.25841.40.camel@localhost.localdomain>
	 <20041129151741.GA5514@infradead.org>
	 <Pine.LNX.4.53.0411291740390.30846@yvahk01.tjqt.qr>
	 <cp2i3h$hs0$1@terminus.zytor.com>
	 <1102370517.25841.216.camel@localhost.localdomain>
	 <41B4DB1C.3060406@zytor.com>
	 <1102372715.25841.227.camel@localhost.localdomain>
	 <20041214201449.A4527@almesberger.net>
	 <1103076859.3582.66.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Tue, 14 Dec 2004 22:35:26 -0500
Message-Id: <1103081726.3582.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-14 at 21:14 -0500, Steven Rostedt wrote:
> On Tue, 2004-12-14 at 20:14 -0300, Werner Almesberger wrote:
> > Steven Rostedt wrote:
> > > It can be easier to send the wrong command to a device, or even the
> > > wrong device than to use a wrong system call.  
> > 
> > So invent some /dev/syscall/<syscall-device-name> and you've reduced
> > this to good old clashes in a flat name space. You can hide all the
> > ugliness, sanity checking, etc. in a library.
> > 
> 
> Already working on something. But I was a little distracted by some real
> work :-)   But I'll have a little device driver that can implement
> dynamic system calls soon, and a library that will hide the real
> ugliness.
> 
> > I also think that a more direct approach for dynamic syscalls would
> > be nice, but the current status quo is far from unbearable.
> > 
> > 

OK, my first attempt at a hack is done. If anyone wants a quick and
nasty dynamic system call interface, here it is. It should work on any
arch, although it is not user space thread safe (SMP safe though). It
dynamically creates a device that implements system calls through it.
It's a hack, but it gets around the kernel maintainers from forbidding
dynamic system calls.

get it here:  http://home.stny.rr.com/rostedt/dynamic/dsyscall_dev.tgz

-- Steve

