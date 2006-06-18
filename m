Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWFRWGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWFRWGy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 18:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWFRWGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 18:06:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:32985 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932096AbWFRWGx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 18:06:53 -0400
Date: Sun, 18 Jun 2006 23:06:50 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] Implement AT_SYMLINK_FOLLOW flag for linkat
Message-ID: <20060618220650.GG27946@ftp.linux.org.uk>
References: <200606171913.k5HJDM3U021408@devserv.devel.redhat.com> <20060618191629.GE27946@ftp.linux.org.uk> <Pine.LNX.4.64.0606181220590.5498@g5.osdl.org> <4495AC3B.4020508@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4495AC3B.4020508@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18, 2006 at 12:40:43PM -0700, Ulrich Drepper wrote:
> Linus Torvalds wrote:
> > Well, the patch as sent in does seem sane, as long as glibc doesn't start 
> > defaulting to the insane behaviour. Giving users the _ability_ to link to 
> > the symlink target is certainly not wrong, regardless of any standard. 
> > Doing it by default is another matter.
> 
> I do not intend to change the link implementation in glibc.  That would
> be majorly stupid, it'd break the ABI.
> 
> The AT_SYMLINK_FOLLOW flag to linkat was the result of the discussion
> how to resolve the issue of the conflict between POSIX and the Linux
> implementation of link (BTW: the Solaris link syscall behaves the same
> as Linux's).

... while FreeBSD still doesn't have that 4.2BSD bug fixed, the suckers.

>   This is an easy an non-intrusive way to help people who
> depend on the questionable POSIx-mandated behavior to work around the
> incompatiblity.  Nothing more.  Don't change the link syscall, don't
> assume the glibc will be changed.  This is only one little extra bit of
> new functionality.

*shrug*

Fine by me; it's not really useful, but it's not a serious bloat either.

ACKed-by: Al Viro <viro@zeniv.linux.org.uk>
