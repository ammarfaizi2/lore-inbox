Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWH1CLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWH1CLE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 22:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWH1CLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 22:11:04 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:29316 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932347AbWH1CLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 22:11:01 -0400
Date: Sun, 27 Aug 2006 22:10:57 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Al Boldi <a1426z@gawab.com>, Eric Van Hensbergen <ericvh@gmail.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] VFS: FS CoW using redirection
Message-ID: <20060828021057.GA30334@filer.fsl.cs.sunysb.edu>
References: <200607082041.54489.a1426z@gawab.com> <20060823172402.GC15851@wohnheim.fh-wedel.de> <20060823180552.GC28873@filer.fsl.cs.sunysb.edu> <200608262205.21397.a1426z@gawab.com> <20060827171510.GA3502@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060827171510.GA3502@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2006 at 07:15:10PM +0200, Jörn Engel wrote:
> On Sat, 26 August 2006 22:05:21 +0300, Al Boldi wrote:
... 
> > > Or you can give Unionfs a try: http://www.unionfs.org
> > 
> > UnionFS is great, but it incurs additional overhead, as it lives below the 
> > real VFS.  What could be really great, is to move some basic functionality 
> > abstractions from UnionFS into VFS proper.
> 
> If you want to make this vision happen, one of the missing pieces is a
> method for copyup, an in-kernel copying routine.  Unionfs needs is
> just the same as Jan's patches do and in the past Linus didn't like my
> approach of using sendfile for it.  You could take a stab at the
> splice code and see how that can be used for copyup.

The thing with union mounts/unionfs is that some of the functionality makes
sense to have in a file system while other parts make sense to have in the
VFS - the way I see it, namespace related bits should be in VFS while
persistent state should be done on the file system level.

Josef "Jeff" Sipek.

-- 
If I have trouble installing Linux, something is wrong. Very wrong.
		- Linus Torvalds
