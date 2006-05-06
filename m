Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWEFWZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWEFWZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 18:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWEFWZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 18:25:59 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:8579 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S932089AbWEFWZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 18:25:58 -0400
Date: Sat, 6 May 2006 16:25:57 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: minixfs bitmaps and associated lossage
Message-ID: <20060506222557.GK9609@parisc-linux.org>
References: <44560796.8010700@gmail.com> <20060506162956.GO27946@ftp.linux.org.uk> <20060506163737.GP27946@ftp.linux.org.uk> <20060506220451.GQ27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060506220451.GQ27946@ftp.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06, 2006 at 11:04:51PM +0100, Al Viro wrote:
> 	So...  What the hell can we do?  Layouts (4) and (5) are clearly
> broken and _never_ worked - there's nothing that would manage to create
> such filesystem.  So these are obvious candidates for switching - either
> to (2) (correct) or to (3) (broken, but at least match util-linux fsck.minix
> and mkfs.minix on such platforms).  The question being, what do we do with
> (3) (big-endian metadata, little-endian bitmaps) and what do we do with
> Linux fsck.minix?  Aside of repeating the mantra, that is ("All Software
> Sucks, All Hardware Sucks")...

For parisc (and I suspect many other architectures), the situation
is clear.  Nobody has ever used minixfs, and the only possible reason
to use it is for data transfer from another system.  Now, there's more
i386/minix systems in existence than there are m68k/minix, so I'd actually
prefer to switch parisc to support the LE minix format.  Or, since that
would involve doing work for something that nobody would ever use, just
disabling it on parisc.  If anyone ever wants it, they can do the work.
