Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262743AbTI2GE7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 02:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262808AbTI2GE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 02:04:59 -0400
Received: from mtaw6.prodigy.net ([64.164.98.56]:27873 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S262743AbTI2GE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 02:04:57 -0400
Date: Mon, 29 Sep 2003 01:05:34 -0500
From: Indraneel Majumdar <indraneel@smartpatch.net>
To: linux-kernel@vger.kernel.org
Subject: [indraneel@smartpatch.net: Re: multiple link]
Message-ID: <20030929060534.GA832@smartpatch.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I will check the archives. I looked into stat.c stat.h fs.h and
it seems that inodes can only keep one link information (or maybe I'm
wrong).

I am trying to set up a cluster and looking for a _very_ simple
scaleable distributed filesystem solution (the opengfs, lustre patches
didn't work).

Thanks,
Indraneel

On Mon, Sep 29, 2003 at 01:57:16AM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 29 Sep 2003 00:43:22 CDT, Indraneel Majumdar <indraneel@smartpatch.net>  said:
> > Hi,
> > I was wondering if it's possible to link to multiple directories at the
> > same time:
> > 
> > link <link_name> <target1> <target2> <target3>...
> 
> Not really a kernel question, but anyhow..
> 
> 'man 2 link' and 'man 2 symlink' will tell you that the system calls only make
> one link at a time.  What /bin/ln does is a userspace question, but Kerhnigan
> and Pike would likely say the Right Answer is:
> 
> % for i in target1 target2 target3; do ln link-name $i; done
> 
> If you're asking something else, such as "How do I hardlink a directory to more
> than one parent?", that *is* a kernel question, but the generic answer is "You
> don't, unless you have a novel way to identify the Right Answer for 'where does
> ../ point?'".  Check the archives, it was beaten to death a few weeks ago....
> 
