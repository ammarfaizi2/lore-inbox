Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965129AbWIED3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965129AbWIED3f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 23:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965128AbWIED3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 23:29:35 -0400
Received: from cs.columbia.edu ([128.59.16.20]:24516 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id S965126AbWIED3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 23:29:34 -0400
Subject: Re: [PATCH 00/22][RFC] Unionfs: Stackable Namespace Unification
	Filesystem
From: Shaya Potter <spotter@cs.columbia.edu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Pavel Machek <pavel@suse.cz>, Josef Sipek <jsipek@cs.sunysb.edu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
In-Reply-To: <1157425739.5510.40.camel@localhost>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu>
	 <20060903110507.GD4884@ucw.cz>
	 <1157376506.4398.15.camel@localhost.localdomain>
	 <1157425739.5510.40.camel@localhost>
Content-Type: text/plain
Date: Mon, 04 Sep 2006 23:28:43 -0400
Message-Id: <1157426923.23523.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, X-Seen-By filter1.cs.columbia.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-04 at 23:08 -0400, Trond Myklebust wrote:
> On Mon, 2006-09-04 at 09:28 -0400, Shaya Potter wrote:
> > On Sun, 2006-09-03 at 11:05 +0000, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > - Modifying a Unionfs branch directly, while the union is mounted, is
> > > >   currently unsupported.  Any such change may cause Unionfs to oops and it
> > > >   can even result in data loss!
> > > 
> > > I'm not sure if that is acceptable. Even root user should be unable to
> > > oops the kernel using 'normal' actions.
> > 
> > As I said in the other case.  imagine ext2/3 on a a san file system
> > where 2 systems try to make use of it.  Will they not have issues?
> 
> Yes, but you are deliberately ignoring that NAS systems like CIFS or NFS
> don't, and neither do clustered filesystems. Users of those systems
> don't expect them to have issues with that sort of scenario.

No.  I just view them as a backing store type system.  Yes, if you use
unionfs in an nfs context you better be sure about how the nfs backing
store is going to be used (i.e. read-only or only used by a single
user), just like if you put ext2/3 on a san block device, you better be
sure that either its only used read-only or only used by a single user.

Yes, unionfs enables you to use the backing store "incorrectly", but so
do ext2/3 or any other non clustered file system when used on a SAN.

