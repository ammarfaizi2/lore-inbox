Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbVIQKLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbVIQKLI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 06:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbVIQKLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 06:11:08 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:42425 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S1751032AbVIQKLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 06:11:07 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Date: Sat, 17 Sep 2005 20:10:51 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17195.60331.386347.965053@cse.unsw.edu.au>
Cc: avuton@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc1-mm1
In-Reply-To: message from Andrew Morton on Friday September 16
References: <20050916022319.12bf53f3.akpm@osdl.org>
	<3aa654a4050916182250999557@mail.gmail.com>
	<20050916214155.29f56f30.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday September 16, akpm@osdl.org wrote:
> Avuton Olrich <avuton@gmail.com> wrote:
> >
> >  On 9/16/05, Andrew Morton <akpm@osdl.org> wrote:
> >  > 
> >  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc1/2.6.14-rc1-mm1/
> >  > (temp copy at http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.14-rc1-mm1.gz)
> > 
> >  NFS (server) is not working for me with 2.6.14-rc1-mm1, this doesn't
> >  appear to be an NFS4 specific issue, I tried without NFS4 compiled in.
> > 
> >  Going back to 2.6.13-mm1 works.
> > 
> >  When trying to start NFS I get:
> >  nfssvc: Permission Denied
> 
> It all works for me.  Would it be possible for you to generate an strace of
> the failure?

The portmap client in the kernel has changed to not used a privileged
port, and some 'portmap' servers (/usr/sbin/portmap) don't like that,
so nfsd gets an error when it tries to register with portmap, and
returns that through nfssvc.

I believe Chuck is looking into it.

NeilBrown
