Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTL1SZF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 13:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbTL1SZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 13:25:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51651 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261868AbTL1SZC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 13:25:02 -0500
Date: Sun, 28 Dec 2003 18:25:00 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Willy Tarreau <willy@w.ods.org>, Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] O_DIRECTORY|O_CREAT handling
Message-ID: <20031228182500.GJ4176@parcelfarce.linux.theplanet.co.uk>
References: <3FE56A97.3060901@redhat.com> <20031221105110.GA1323@alpha.home.local> <20031228180341.GA1134@pimlott.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031228180341.GA1134@pimlott.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 28, 2003 at 01:03:41PM -0500, Andrew Pimlott wrote:
> On Sun, Dec 21, 2003 at 11:51:10AM +0100, Willy Tarreau wrote:
> >   base_dir="/tmp/tmpdir"; 
> >   do {
> >      rnd=random();
> >      sprintf(dir, "%s%d", base_dir, rnd);
> >   } while (!mkdir(dir, 0700);
> >   /* now I'm guaranteed that I'm the first to get this dir, */
> >   /* and only my UID can work in it */
> >   chdir(dir);
> >   
> > So the only race would be someone working with the same UID (or root) removing
> > the directory and replacing it with another one (or a symlink or anything)
> > between mkdir() and chdir().
> 
> If /tmp isn't sticky, anyone can do this.  I think this is the
> scenario Ulrich was referring to.

And if /etc/shadow is world-writable, anyone can do other interesting things.
Doctor, it hurts when I do it...
