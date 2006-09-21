Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWIUXZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWIUXZa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 19:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWIUXZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 19:25:30 -0400
Received: from pat.uio.no ([129.240.10.4]:51179 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932105AbWIUXZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 19:25:29 -0400
Subject: Re: Autofs4 breakage (was 2.6.19 -mm merge plans)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060920203947.b9b9920e.akpm@osdl.org>
References: <20060920135438.d7dd362b.akpm@osdl.org>
	 <1158789333.5639.37.camel@lade.trondhjem.org>
	 <20060920203947.b9b9920e.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 21 Sep 2006 19:25:19 -0400
Message-Id: <1158881119.5797.14.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.808, required 12,
	autolearn=disabled, AWL 1.19, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 20:39 -0700, Andrew Morton wrote:
> On Wed, 20 Sep 2006 17:55:33 -0400
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> > On Wed, 2006-09-20 at 13:54 -0700, Andrew Morton wrote:
> > 
> > > add-newline-to-nfs-dprintk.patch
> > > fs-nfs-make-code-static.patch
> > > 
> > >  NFS queue -> Trond.
> > > 
> > >  The NFS git tree breaks autofs4 submounts.  Still.
> > 
> > I still suspect that is due to a misconfigured selinux setup on your
> > machine. If autofs4 expects to be able to do mkdir() on your NFS
> > partition (something which in itself is wrong), then selinux should be
> > configured to allow it to do so.
> > 
> > Anyhow, does reverting the patch
> > 
> > http://kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=a634904a7de0d3a0bc606f608007a34e8c05bfee;hp=ddeff520f02b92128132c282c350fa72afffb84a
> > 
> > 'fix' the issue for you?
> > 
> 
> yes.

Hmm... but you aren't seeing it with a clean 2.6.18 kernel?

Cheers,
  Trond

