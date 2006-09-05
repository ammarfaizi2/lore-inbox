Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWIEDJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWIEDJR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 23:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWIEDJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 23:09:16 -0400
Received: from pat.uio.no ([129.240.10.4]:446 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932066AbWIEDJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 23:09:15 -0400
Subject: Re: [PATCH 00/22][RFC] Unionfs: Stackable Namespace Unification
	Filesystem
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Shaya Potter <spotter@cs.columbia.edu>
Cc: Pavel Machek <pavel@suse.cz>, Josef Sipek <jsipek@cs.sunysb.edu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
In-Reply-To: <1157376506.4398.15.camel@localhost.localdomain>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu>
	 <20060903110507.GD4884@ucw.cz>
	 <1157376506.4398.15.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 04 Sep 2006 23:08:58 -0400
Message-Id: <1157425739.5510.40.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.111, required 12,
	autolearn=disabled, AWL 1.89, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-04 at 09:28 -0400, Shaya Potter wrote:
> On Sun, 2006-09-03 at 11:05 +0000, Pavel Machek wrote:
> > Hi!
> > 
> > > - Modifying a Unionfs branch directly, while the union is mounted, is
> > >   currently unsupported.  Any such change may cause Unionfs to oops and it
> > >   can even result in data loss!
> > 
> > I'm not sure if that is acceptable. Even root user should be unable to
> > oops the kernel using 'normal' actions.
> 
> As I said in the other case.  imagine ext2/3 on a a san file system
> where 2 systems try to make use of it.  Will they not have issues?

Yes, but you are deliberately ignoring that NAS systems like CIFS or NFS
don't, and neither do clustered filesystems. Users of those systems
don't expect them to have issues with that sort of scenario.


