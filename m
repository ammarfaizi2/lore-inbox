Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262638AbVCXQ53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262638AbVCXQ53 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 11:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262867AbVCXQ53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 11:57:29 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:60879 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262638AbVCXQ5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 11:57:18 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ppc32/64: Map prefetchable PCI without guarded bit
Date: Thu, 24 Mar 2005 08:55:54 -0800
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1111645464.5569.15.camel@gaston> <200503240854.45741.jbarnes@engr.sgi.com>
In-Reply-To: <200503240854.45741.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503240855.55154.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, March 24, 2005 8:54 am, Jesse Barnes wrote:
> On Wednesday, March 23, 2005 10:24 pm, Benjamin Herrenschmidt wrote:
> > While experimenting with framebuffer access performances, we noticed a
> > very significant improvement in write access to it when not setting
> > the "guarded" bit on the MMU mappings. This bit basically says that
> > reads and writes won't have side effects (it allows speculation). It
> > appears that it also disables write combining.
>
> Doesn't pgprot_writecombine imply non-guarded, so can't you use it instead?
> Either way, you'll probably want to fix fbmem.c as well and turn off
> _PAGE_GUARDED?

Nevermind about this bit, I just scrolled a little further into your patch :)

Jesse
