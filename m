Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbUKSJK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbUKSJK2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 04:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbUKSJK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 04:10:28 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:9140 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261324AbUKSJDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 04:03:45 -0500
Date: Fri, 19 Nov 2004 14:33:56 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       davem@davemloft.net, prasanna@in.ibm.com, suparna@in.ibm.com
Subject: Re: [PATCH] Kprobes: wrapper to define jprobe.entry
Message-ID: <20041119090356.GA10082@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20041118102641.GB8830@in.ibm.com> <20041118144746.7daa9395.akpm@osdl.org> <20041119065258.GA6863@in.ibm.com> <20041118230506.4d20b3c9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041118230506.4d20b3c9.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 11:05:06PM -0800, Andrew Morton wrote:
> Ananth N Mavinakayanahalli <ananth@in.ibm.com> wrote:
> >
> > > >
> >  > > Here is a patch that adds a wrapper for defining jprobe.entry to make
> >  > > it easy to handle the three dword function descriptors defined by the
> >  > > PowerPC ELF ABI.
> >  > > 
> >  > > Current patch against 2.6.10-rc2-mm1 + kprobes patch for ppc64.
> >  > 
> >  > I don't have the kprobes-for-ppc64 patch here.
> >  > 
> >  > > Changes for adding this wrapper for x86, ppc64 (tested) and x86_64 
> >  > > (untested) below. The earlier method of defining jprobe.entry will
> >  > > continue to work.
> >  > 
> >  > So what should I do with this?  I'm inclined to drop it until the x86_64
> >  > part has been tested and Dave has had a go at the sparc64 version.
> > 
> >  I have now tested the patch succesfully on x86_64 and updated it for
> >  sparc64 too (Dave says the change looks good).
> 
> What is the review and testing status of the kprobes-for-ppc64 patch which
> you sent?
> 
The patch was earlier posted on the PPC64 mailing list for comments and 
Paul had reviewed it. I had to update the patch to take care of the base 
kprobe changes that were made to accomodate the x86_64 port.

The patch is tested on POWER3 (uni) and POWER4 (lpar).

Thanks,
Ananth
