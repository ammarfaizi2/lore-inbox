Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbVCNWpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbVCNWpy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 17:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbVCNWmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 17:42:23 -0500
Received: from fire.osdl.org ([65.172.181.4]:1989 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262040AbVCNWld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 17:41:33 -0500
Date: Mon, 14 Mar 2005 14:41:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] Re: inode cache, dentry cache, buffer heads usage
Message-Id: <20050314144103.0d6ed063.akpm@osdl.org>
In-Reply-To: <1110838395.24286.297.camel@dyn318077bld.beaverton.ibm.com>
References: <1110394558.24286.203.camel@dyn318077bld.beaverton.ibm.com>
	<20050310174751.522c5420.akpm@osdl.org>
	<1110835692.24286.288.camel@dyn318077bld.beaverton.ibm.com>
	<20050314141128.7da95c34.akpm@osdl.org>
	<1110838395.24286.297.camel@dyn318077bld.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> On Mon, 2005-03-14 at 14:11, Andrew Morton wrote:
> > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > >
> > > On Thu, 2005-03-10 at 17:47, Andrew Morton wrote:
> > > > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > > > >
> > > > > So, why is these slab cache are not getting purged/shrinked even
> > > > >  under memory pressure ? (I have seen lowmem as low as 6MB). What
> > > > >  can I do to keep the machine healthy ?
> > > > 
> > > > Tried increasing /proc/sys/vm/vfs_cache_pressure?  (That might not be in
> > > > 2.6.8 though).
> > > > 
> > > > 
> > > 
> > > Yep. This helped shrink the slabs, but we end up eating up lots of
> > > the lowmem in Buffers. Is there a way to shrink buffers ?
> > 
> > It would require some patchwork.  Why is it a problem?  That memory is
> > reclaimable.
> > 
> 
> Well, machine pauses for 5-30 seconds for each vi,cscope, write() etc.

Why?

> > How'd you get 1.8gig of lowmem?
> 
> 2:2 split
> 

Does a normal kernel exhibit the pauses?
