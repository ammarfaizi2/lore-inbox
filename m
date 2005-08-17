Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbVHQJJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbVHQJJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 05:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbVHQJJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 05:09:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:31716 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750998AbVHQJJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 05:09:25 -0400
Date: Wed, 17 Aug 2005 10:09:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: hch@infradead.org, kumar.gala@freescale.com, davem@davemloft.net,
       paulus@samba.org, galak@freescale.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, zach@vmware.com
Subject: Re: [PATCH] ppc32: removed usage of <asm/segment.h>
Message-ID: <20050817090920.GA12716@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>, kumar.gala@freescale.com,
	davem@davemloft.net, paulus@samba.org, galak@freescale.com,
	akpm@osdl.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, zach@vmware.com
References: <20050816.203312.77701192.davem@davemloft.net> <032E6AED-9456-4271-9B06-C5DCE5970193@freescale.com> <20050817083048.GA11892@infradead.org> <E1E5Jii-0004Yc-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1E5Jii-0004Yc-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2005 at 10:56:24AM +0200, Miklos Szeredi wrote:
> > On Wed, Aug 17, 2005 at 12:43:37AM -0500, Kumar Gala wrote:
> > > >I concur, in fact we should really kill that thing off entirely.
> > > 
> > > I'm all for killing it off entirely but got some feedback that on  
> > > i386 segment.h can be included by userspace programs.
> > 
> > No kernel headers can be included by userland anymore.
> 
> I know nothing about <asm/segment.h> but this generic statement is
> simply not true.
> 
> There are perfectly valid uses of kernel headers from userspace.  For
> example if a program uses the netlink interface, it should include
> <linux/netlink.h>.  It's the interface definition after all.
> 
> Glibc headers also include <linux/*> and <asm/*> in quite few places.

But these files in /usr/include/ aren't provided by the kernel anymore.

