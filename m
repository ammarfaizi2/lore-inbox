Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWCBVkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWCBVkt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 16:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbWCBVks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 16:40:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:11172 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932306AbWCBVks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 16:40:48 -0500
Date: Thu, 2 Mar 2006 22:40:46 +0100 (MET)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: janak@us.ibm.com
Cc: Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org, ak@muc.de, hch@lst.de,
       paulus@samba.org, viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
       michael.kerrisk@gmx.net
MIME-Version: 1.0
References: <Pine.LNX.4.64.0603011959340.22647@g5.osdl.org>
Subject: Re: unhare() interface design questions and man page
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <27686.1141335646@www004.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to myself...

> > > Do you have any further response on this point?
> > > (There was none in your last message?)
> > 
> > I personally don't think it's worth makign UNSHARE_NEWNS just because
> > it's a flag that acts differently from the other CLONE_xxx flags.
> 
> See my comments above.  (And in case it wasn't clear, I meant 
> make a complete set of UNSHARE_* flags that mirror the 
> corresponding CLONE_* flags.)

(By the way, I meant that the flag should preferably be called 
UNSHARE_NS, not UNSHARE_NEWNS -- as noted in an earlier message
in this thread, CLONE_NEWNS was itself a bad name.)

I had another thought about why using names of the form
UNSHARE_* might be worthwhile.  It just might be that in the 
future, someone might want to add a flag that has nothing
to do with clone().  I mean some flag that somehow performs
some other modification of the behaviour or unshare(), or
perhaps unshares something that isn't shared/unshared by 
clone().  (The first possibility seems more likely than 
the second.)  In that case, it would make litte sense to
name the flag(s) CLONE_xxx.

Cheers,

Michael

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  
Grab the latest tarball at
ftp://ftp.win.tue.nl/pub/linux-local/manpages/, 
read the HOWTOHELP file and grep the source 
files for 'FIXME'.
