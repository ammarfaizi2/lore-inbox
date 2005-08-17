Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbVHQI57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbVHQI57 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 04:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbVHQI57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 04:57:59 -0400
Received: from adsl-266.mirage.euroweb.hu ([193.226.239.10]:65298 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751000AbVHQI56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 04:57:58 -0400
To: hch@infradead.org
CC: kumar.gala@freescale.com, davem@davemloft.net, paulus@samba.org,
       galak@freescale.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, zach@vmware.com
In-reply-to: <20050817083048.GA11892@infradead.org> (message from Christoph
	Hellwig on Wed, 17 Aug 2005 09:30:48 +0100)
Subject: Re: [PATCH] ppc32: removed usage of <asm/segment.h>
References: <20050816.203312.77701192.davem@davemloft.net> <032E6AED-9456-4271-9B06-C5DCE5970193@freescale.com> <20050817083048.GA11892@infradead.org>
Message-Id: <E1E5Jii-0004Yc-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 17 Aug 2005 10:56:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Aug 17, 2005 at 12:43:37AM -0500, Kumar Gala wrote:
> > >I concur, in fact we should really kill that thing off entirely.
> > 
> > I'm all for killing it off entirely but got some feedback that on  
> > i386 segment.h can be included by userspace programs.
> 
> No kernel headers can be included by userland anymore.

I know nothing about <asm/segment.h> but this generic statement is
simply not true.

There are perfectly valid uses of kernel headers from userspace.  For
example if a program uses the netlink interface, it should include
<linux/netlink.h>.  It's the interface definition after all.

Glibc headers also include <linux/*> and <asm/*> in quite few places.

Miklos
