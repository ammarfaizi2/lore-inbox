Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbUCBPQO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 10:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbUCBPQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 10:16:14 -0500
Received: from inventor.gentoo.org ([216.223.235.2]:3456 "EHLO meep.gentoo.org")
	by vger.kernel.org with ESMTP id S261667AbUCBPQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 10:16:11 -0500
Subject: firewire good, USB printing fixed, CD-ROM block device IO errors
	near end of media
From: Daniel Robbins <drobbins@gentoo.org>
To: Paulo Marques <pmarques@grupopie.com>
Cc: "Barry K. Nathan" <barryn@pobox.com>, Jens Axboe <axboe@suse.de>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Mike@kordik.net,
       kpfleming@backtobasicsmgmt.com
In-Reply-To: <40448799.5030508@grupopie.com>
References: <1077933682.14653.23.camel@wave.gentoo.org>
	 <20040228021040.GA14836@kroah.com> <20040229095139.GH3149@suse.de>
	 <20040301074348.GA7646@ip68-4-255-84.oc.oc.cox.net>
	 <40448799.5030508@grupopie.com>
Content-Type: text/plain
Organization: Gentoo Technologies, Inc.
Message-Id: <1078240684.10224.36.camel@wave.gentoo.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 02 Mar 2004 08:18:04 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-02 at 06:09, Paulo Marques wrote:
> Barry K. Nathan wrote:
> 
> >  
> > +		/* We must increment writecount here, and not at the
> > +		 * end of the loop. Otherwise, the final loop iteration may
> > +		 * be skipped, leading to incomplete printer output.
> > +		 */
> 
> I'm affraid this is my fault, for correcting a bug and letting another one take 
> its place :(
> 
> It seems that this patch squashes them both. It should go in ASAP.

Sorry I have been unable to test the fix; Gentoo Linux 2004.0 just got
released and I just became... err... ultra-busy? But it does look like
others who experienced the exact problem I was having now have
functional USB, so I'd expect it to work for me too.

I'm now experiencing kernel problems (apparently this isn't a new thing)
related to how Linux maps a CD-ROM to a block device  -- problems using
dd to verify a burnt CD, where the kernel spits back random IO error
messages as it nears the end of the burned area.

If anyone is interested, you can learn more about the problems in the
following thread (I am experiencing the exact problems of the original
poster.) The posts from Joerg Schilling are probably most helpful in
finding a kernel solution to this problem: 

http://lists.debian.org/cdwrite/2003/cdwrite-200310/threads.html#00009

zisofs makes a filesystem-based verify of a CD quite a time-consuming
and inefficient process (due to seeking,) so it would be nice if a "dd"
or "readcd"-based linear CD verify worked reliably under Linux.

Regards,

Daniel

