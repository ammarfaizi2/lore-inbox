Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266175AbTBXKJ7>; Mon, 24 Feb 2003 05:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266233AbTBXKJ7>; Mon, 24 Feb 2003 05:09:59 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:9653 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S266175AbTBXKJ6>;
	Mon, 24 Feb 2003 05:09:58 -0500
Date: Mon, 24 Feb 2003 11:20:09 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Hans Reiser <reiser@namesys.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  comments on st_blksize and f_bsize for 2.5
Message-ID: <20030224102009.GB14024@win.tue.nl>
References: <3E526C94.3020109@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E526C94.3020109@namesys.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 08:25:40PM +0300, Hans Reiser wrote:

> Since a few applications, and the linux manpages, seem to not really 
> understand what these are for, they need comments like SUSv2 has for 
> them.  A larger discussion will be provided if requested.

> +	unsigned int	st_blksize;	/* Optimal I/O size */

> +	int f_bsize;	/* Filesystem blocksize */

Yes, discussion - I wouldnt mind seeing details.

The trivial part is st_blksize: all agree.
Quoting the man page:

       The value st_blksize gives the "preferred" blocksize
       for efficient file system I/O.  (Writing to a file in
       smaller chunks may cause an inefficient read-modify-rewrite.)

The nontrivial part is f_bsize. As far as I can see
BSD and SYSV and SUS all differ. And there are the use
in struct statfs and the use in struct statvfs that are
nonequivalent.

Maybe BSD f_iosize, f_bsize in statfs corresponds to
SYSV f_bsize, f_frsize in statfs. Linux is again a
bit different.

Andries
