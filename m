Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTLIDBY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 22:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbTLIDBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 22:01:24 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:13442 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262598AbTLIDBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 22:01:22 -0500
Date: Tue, 9 Dec 2003 04:01:21 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Erik Hensema <erik@hensema.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: incorrect inode count on reiserfs
Message-ID: <20031209030121.GB3664@MAIL.13thfloor.at>
Mail-Followup-To: Erik Hensema <erik@hensema.net>,
	linux-kernel@vger.kernel.org
References: <3FD47BFC.9020008@scssoft.com> <16340.33245.887082.96412@laputa.namesys.com> <slrnbt9322.27h.erik@bender.home.hensema.net> <pan.2003.12.08.16.09.22.30237@smurf.noris.de> <slrnbt9cti.31m.erik@bender.home.hensema.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrnbt9cti.31m.erik@bender.home.hensema.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 08, 2003 at 05:24:02PM +0000, Erik Hensema wrote:
> Matthias Urlichs (smurf@smurf.noris.de) wrote:
> > Hi, Erik Hensema wrote:
> > 
> >> But innwatch checks for a out-of-inodes condition. How can it differentiate
> >> between a undefined number of inodes (field set to 0) and a system that ran
> >> out of inodes (field dropped to 0)?
> >> 
> > Create a file. Watch that succeed. Check whether this succeeds, and that
> > the number of free inodes is still zero.
> > Delete the file. Check that the number of free inodes is _still_ zero.
> > 
> > Repeat a few times, with random sub-second delay if you're feeling
> > especially paranoid today, for added confidence.
> 
> So what hack is uglier? ;-)

hmm, well, maybe the fact that an 'inode' filesystem
which ran out of inodes will not report a total of 
0 inodes could help against all this uglyness ...

best,
Herbert

> -- 
> Erik Hensema <erik@hensema.net>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
