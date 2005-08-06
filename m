Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbVHFAhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVHFAhL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 20:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbVHFAhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 20:37:11 -0400
Received: from mail.kroah.org ([69.55.234.183]:43739 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261818AbVHFAhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 20:37:09 -0400
Date: Fri, 5 Aug 2005 17:36:45 -0700
From: Greg KH <greg@kroah.com>
To: jt <jt@jtholmes.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 stalls Andrew M. req this extended dmesg dump
Message-ID: <20050806003645.GB5370@kroah.com>
References: <42EBB9CD.7090706@jtholmes.com> <20050730125238.327be97c.akpm@osdl.org> <20050731043710.GA18532@kroah.com> <42EE251D.40505@jtholmes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EE251D.40505@jtholmes.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2005 at 09:35:25AM -0400, jt wrote:
> Greg KH wrote:
> 
> >On Sat, Jul 30, 2005 at 12:52:38PM -0700, Andrew Morton wrote:
> > 
> >
> >>udev is doing stuff.
> >>
> >>   
> >>
> >>>[   40.691350] c16b1f40 00000082 c0115ff9 00000000 c1601530 bfd67d94 
> >>>c1601530 00000000 [   40.691544]        c1384e80 c1384520 00000000 
> >>>0000122d 8cc9bc6a 00000008 c1601530 c1601020 [   40.695744]        
> >>>c1601144 00000000 00000246 c16010c8 00000004 fffffe00 c1601020 c0121343 
> >>>[   40.699932] Call Trace:
> >>>[   40.708026]  [<c0115ff9>] do_page_fault+0x1a9/0x57a
> >>>[   40.712230]  [<c0121343>] do_wait+0x313/0x3a0
> >>>[   40.716403]  [<c0119940>] default_wake_function+0x0/0x10
> >>>[   40.720663]  [<c0119940>] default_wake_function+0x0/0x10
> >>>[   40.724858]  [<c0121479>] sys_wait4+0x29/0x30
> >>>[   40.729039]  [<c0103f99>] syscall_call+0x7/0xb
> >>>[   40.733255] udev          S 00000000     0  1443    795               
> >>>(NOTLB)
> >>>     
> >>>
> >>And it's sleeping for some reason.
> >>   
> >>
> >
> >Yes, older versions of udev (< 058) can work _really slow_ with 2.6.12.
> >Please upgrade your version of udev and see if that solves the issue or
> >not.
> >
> >thanks,
> >
> >greg k-h
> >
> >
> > 
> >
> Interseting results.
> I loaded udev 64
> and hotplug ng 002

Heh, I wouldn't recommend hotplug-ng on anyone, it's out of date, and
really not needed at all.

How about if you boot with a static /dev?  Do you still have boot issues
with that?

thanks,

greg k-h
