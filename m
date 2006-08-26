Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751654AbWHZTDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbWHZTDl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 15:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbWHZTDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 15:03:41 -0400
Received: from [212.33.164.48] ([212.33.164.48]:14852 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751637AbWHZTDk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 15:03:40 -0400
From: Al Boldi <a1426z@gawab.com>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [RFC] VFS: FS CoW using redirection
Date: Sat, 26 Aug 2006 22:05:21 +0300
User-Agent: KMail/1.5
Cc: Eric Van Hensbergen <ericvh@gmail.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>
References: <200607082041.54489.a1426z@gawab.com> <20060823172402.GC15851@wohnheim.fh-wedel.de> <20060823180552.GC28873@filer.fsl.cs.sunysb.edu>
In-Reply-To: <20060823180552.GC28873@filer.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 8BIT
Message-Id: <200608262205.21397.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josef Sipek wrote:
> On Wed, Aug 23, 2006 at 07:24:02PM +0200, Jörn Engel wrote:
> > On Sun, 9 July 2006 15:50:36 +0300, Al Boldi wrote:
> > > Consider something simple like this:
> > >
> > > VFS - anyFS1 (r/w) used normally, unless ENotFound, then redirect read
> > > to \              anyFS2, or CoW from anyFS2 to anyFS1.
> > >       anyFS2 (r/o) used normally.
> >
> > That concept is known as union mount.  Jan Blunck did some patches in
> > that direction, you might be able to find them in the archives.  If
> > not, just send him a mail.

Thanks for the pointer!

So what was the rejecting theme?

> Or you can give Unionfs a try: http://www.unionfs.org

UnionFS is great, but it incurs additional overhead, as it lives below the 
real VFS.  What could be really great, is to move some basic functionality 
abstractions from UnionFS into VFS proper.


Thanks!

--
Al

