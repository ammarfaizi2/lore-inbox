Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266718AbTCCQRC>; Mon, 3 Mar 2003 11:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266736AbTCCQRB>; Mon, 3 Mar 2003 11:17:01 -0500
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:22768 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S266718AbTCCQQ7>; Mon, 3 Mar 2003 11:16:59 -0500
Date: Mon, 3 Mar 2003 16:27:20 +0000 (GMT)
From: Anton Altaparmakov <aia21@cantab.net>
To: Oleg Drokin <green@namesys.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>,
       mason@suse.com, trond.myklebust@fys.uio.no, jaharkes@cs.cmu.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 iget5_locked port attempt to 2.4
In-Reply-To: <20030303190417.C4513@namesys.com>
Message-ID: <Pine.SOL.3.96.1030303162451.1630C-100000@virgo.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Mar 2003, Oleg Drokin wrote:
> On Mon, Mar 03, 2003 at 03:57:19PM +0000, Anton Altaparmakov wrote:
> > > > >    It's me again, I basically got no reply for this iget5_locked patch
> > > > >    I have now. Would there be any objections if I try push it to Marcelo
> > > > >    tomorrow? ;)
> > > > I just binned it. Certainly its not the kind of stuff I want to test in -ac, 
> > > > too many VFS changes outside reiserfs
> > > Andrew Morton said "iget5_locked() looks simple enough, and as far as I can
> > > tell does not change any existing code - it just adds new stuff.",
> > > also this code (in its 2.5 incarnation) was tested in 2.5 for long time already.
> > > Also it fixes real bug (and while I have another reiserfs-only fix for the bug,
> > > it is fairly inelegant).
> > I agree it should go into 2.4 but I don't think the patches you are
> > submitting should go in. From what I can see they are an older version
> > compared to what actually went into 2.5. (I am basing this on the comments
> 
> What I am submitting is just changesets 1.373.172.1..1.373.172.6 from
> 2.5 bk tree. So these patches are what went into 2.5 (plus all the bugs I
> have made during adapting these to 2.4, of course).

That's ok then.

> > to the functions rather than thorough code comparisons but I don't have
> > time to look at it more in depth atm.) Why don't you use the actual 2.5
> > code and make new patches or at least make use of the patches that finally
> > went into 2.5?
> 
> Looking at the changelog, it seems much later on there were ifind_fast() and ifind()
> additions to this code, but I was not sure I should take these too.
> I can though, if people think that would be useful.

Up to you. Would be nice to have both. The code with the ifind() and
ilookup() functions has existed for longer I think so if your argument
is that the code has been tested in 2.5 already so can go in 2.4 then
taking that is probably better to take these, too.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

