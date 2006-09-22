Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWIVPzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWIVPzf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 11:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbWIVPzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 11:55:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56516 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964783AbWIVPze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 11:55:34 -0400
Date: Fri, 22 Sep 2006 08:55:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Autofs4 breakage (was 2.6.19 -mm merge plans)
Message-Id: <20060922085521.af242c86.akpm@osdl.org>
In-Reply-To: <1158881119.5797.14.camel@lade.trondhjem.org>
References: <20060920135438.d7dd362b.akpm@osdl.org>
	<1158789333.5639.37.camel@lade.trondhjem.org>
	<20060920203947.b9b9920e.akpm@osdl.org>
	<1158881119.5797.14.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006 19:25:19 -0400
Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> On Wed, 2006-09-20 at 20:39 -0700, Andrew Morton wrote:
> > On Wed, 20 Sep 2006 17:55:33 -0400
> > Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> > 
> > > On Wed, 2006-09-20 at 13:54 -0700, Andrew Morton wrote:
> > > 
> > > > add-newline-to-nfs-dprintk.patch
> > > > fs-nfs-make-code-static.patch
> > > > 
> > > >  NFS queue -> Trond.
> > > > 
> > > >  The NFS git tree breaks autofs4 submounts.  Still.
> > > 
> > > I still suspect that is due to a misconfigured selinux setup on your
> > > machine. If autofs4 expects to be able to do mkdir() on your NFS
> > > partition (something which in itself is wrong), then selinux should be
> > > configured to allow it to do so.
> > > 
> > > Anyhow, does reverting the patch
> > > 
> > > http://kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=a634904a7de0d3a0bc606f608007a34e8c05bfee;hp=ddeff520f02b92128132c282c350fa72afffb84a
> > > 
> > > 'fix' the issue for you?
> > > 
> > 
> > yes.
> 
> Hmm... but you aren't seeing it with a clean 2.6.18 kernel?
> 

Yes, I am.  Mainline broke.
