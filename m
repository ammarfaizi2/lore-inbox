Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbTJJEti (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 00:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbTJJEti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 00:49:38 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:26507 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262152AbTJJEth
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 00:49:37 -0400
Date: Fri, 10 Oct 2003 05:49:09 +0100
From: Jamie Lokier <jamie@shareable.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Ulrich Drepper <drepper@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
Message-ID: <20031010044909.GB26379@mail.shareable.org>
References: <Pine.LNX.4.44.0310091525200.20936-100000@home.osdl.org> <3F85ED01.8020207@redhat.com> <20031010002248.GE7665@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031010002248.GE7665@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
> Umm...  I don't see anything equivalent to statfs(2) ->f_type in statvfs(2).
> ->f_frsize makes no sense for practically all filesystems we support.
> ->f_namemax is not well-defined ("maximum filename length" as in "you won't
> see filenames longer than..." or "attempt to create a file with name longer
> than... will fail" or "longer than that and I'm truncating";  and that is
> aside of lovely questions about the meaning of "length" - strlen()?  number
> of multibyte characters accepted by that fs? something else?)
> ->f_fsid is also practically undefined (and left 0 by practically every fs,
> so no userland code can do anything useful with it).
> ->f_flag might be useful, all right.  However, I'd like to see real-world
> examples of code (Solaris, whatever) that would use it in any meaningful
> way...

On this theme, I'd like to know:

    - are dnotify / lease / lock reliable indicators on this filesystem?
      (i.e. dnotify is reliable on all local filesystems, but not over any
      of the remote ones AFAIK).

    - is stat() reliable (local filesystems and many remote) or potentially
      out of date without open/close (NFS due to attribute cacheing)

-- Jamie
