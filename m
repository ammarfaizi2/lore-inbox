Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVCVQxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVCVQxS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 11:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVCVQxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 11:53:18 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:35295 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261429AbVCVQxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 11:53:13 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.12-rc1-mm1
Date: Tue, 22 Mar 2005 08:50:35 -0800
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, arjanv@infradead.org,
       linux-kernel@vger.kernel.org
References: <20050321025159.1cabd62e.akpm@osdl.org> <200503211642.00796.jbarnes@engr.sgi.com> <20050322091814.GC3982@stusta.de>
In-Reply-To: <20050322091814.GC3982@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503220850.35948.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 22, 2005 1:18 am, Adrian Bunk wrote:
> On Mon, Mar 21, 2005 at 04:42:00PM -0800, Jesse Barnes wrote:
> > On Monday, March 21, 2005 12:25 pm, Adrian Bunk wrote:
> > > On Mon, Mar 21, 2005 at 09:15:53AM -0800, Jesse Barnes wrote:
> > > > On Monday, March 21, 2005 2:51 am, Andrew Morton wrote:
> > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1
> > > > >2-rc 1/2. 6.12-rc1-mm1/
> > > >
> > > > Andrew, please drop
> > > >
> > > > revert-allow-oem-written-modules-to-make-calls-to-ia64-oem-sal-functi
> > > >ons. patch
> > > >
> > > > The tiocx.c driver is now in the tree, and it uses those functions.
> > >
> > > IOW:
> > > The EXPORT_SYMBOL's should still be removed, but the functions
> > > themselves should stay.
> >
> > Actually, no, since tiocx can be built modular.  The patch should just be
> > dropped.
>
> ???
>
> config SGI_TIOCX
>  bool "SGI TIO CX driver support"

Hm, ok.  I just looked at the Makefile and iirc some old versions of the patch 
allowed it modular...

Jesse
