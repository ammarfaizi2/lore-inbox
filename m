Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVCOQYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVCOQYy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 11:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVCOQXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 11:23:12 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:12768 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261403AbVCOQWF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 11:22:05 -0500
Subject: Re: [Ext2-devel] Re: inode cache, dentry cache, buffer heads usage
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ext2-devel <ext2-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050314144103.0d6ed063.akpm@osdl.org>
References: <1110394558.24286.203.camel@dyn318077bld.beaverton.ibm.com>
	 <20050310174751.522c5420.akpm@osdl.org>
	 <1110835692.24286.288.camel@dyn318077bld.beaverton.ibm.com>
	 <20050314141128.7da95c34.akpm@osdl.org>
	 <1110838395.24286.297.camel@dyn318077bld.beaverton.ibm.com>
	 <20050314144103.0d6ed063.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1110903430.24286.336.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Mar 2005 08:17:11 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-14 at 14:41, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > On Mon, 2005-03-14 at 14:11, Andrew Morton wrote:
> > > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > > >
> > > > On Thu, 2005-03-10 at 17:47, Andrew Morton wrote:
> > > > > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > > > > >
> > > > > > So, why is these slab cache are not getting purged/shrinked even
> > > > > >  under memory pressure ? (I have seen lowmem as low as 6MB). What
> > > > > >  can I do to keep the machine healthy ?
> > > > > 
> > > > > Tried increasing /proc/sys/vm/vfs_cache_pressure?  (That might not be in
> > > > > 2.6.8 though).
> > > > > 
> > > > > 
> > > > 
> > > > Yep. This helped shrink the slabs, but we end up eating up lots of
> > > > the lowmem in Buffers. Is there a way to shrink buffers ?
> > > 
> > > It would require some patchwork.  Why is it a problem?  That memory is
> > > reclaimable.
> > > 
> > 
> > Well, machine pauses for 5-30 seconds for each vi,cscope, write() etc.
> 
> Why?

Dunno. Trying to figure out whats happening here. Lowmem pressure was
the top on our list - but nothing to prove it - yet.

> 
> > > How'd you get 1.8gig of lowmem?
> > 
> > 2:2 split
> > 
> 
> Does a normal kernel exhibit the pauses?

We haven't tried 3:1 split on this machine for a while. This machine
starts to slow down over the time. (It is up for last 70 days). We are
trying to collect all the info and also try everything possible to
understand issues - before we reboot.

Thanks,
Badari

