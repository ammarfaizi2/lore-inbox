Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbUK0UiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbUK0UiN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 15:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbUK0UiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 15:38:13 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:6258 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261285AbUK0UiL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 15:38:11 -0500
Date: Sat, 27 Nov 2004 21:39:18 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, hch@infradead.org,
       dwmw2@infradead.org, aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041127203918.GA7857@mars.ravnborg.org>
Mail-Followup-To: Matthew Wilcox <matthew@wil.cx>,
	David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	hch@infradead.org, dwmw2@infradead.org, aoliva@redhat.com,
	linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
References: <19865.1101395592@redhat.com> <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2004 at 04:54:33PM +0000, Matthew Wilcox wrote:
> >  (5) For userspace use (such as for glibc), the appropriate include/user*/
> >      directories should be selected and installed in /usr/include/ or wherever,
> >      and symlinks made. For example, on i386 arch boxes, you might find:
> > 
> > 	SOURCE			INSTALLED AS
> > 	======================	============
> > 	include/user/		/usr/include/user/
> > 	include/user-i386/	/usr/include/user-i386/
> > 				/usr/include/linux -> user
> > 				/usr/include/asm -> user-i386
> 
> This proposal doesn't address the asm-generic problem directly.  Can I
> presume that you intend to also create linux/include/user-generic, install
> it as /usr/include/user-generic and create an asm-generic symlink that
> points to user-generic?  A good problem file to be dealt with would
> be asm/errno.h

Do not allow asm-generic to be used direct by userspace.
The example with errno.h is handled by user-i386/errno.h which includes
asm-generic/errno.h.

Would that do the trick - yes?

	Sam
