Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161158AbWGIVLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161158AbWGIVLa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 17:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161160AbWGIVL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 17:11:29 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:4038 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161158AbWGIVL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 17:11:28 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc1-mm1 oops on x86_64
Date: Sun, 9 Jul 2006 23:11:52 +0200
User-Agent: KMail/1.9.3
Cc: clg@fr.ibm.com, linux-kernel@vger.kernel.org, clameter@engr.sgi.com
References: <20060709021106.9310d4d1.akpm@osdl.org> <200607092235.32921.rjw@sisk.pl> <20060709135945.dfb58b3d.akpm@osdl.org>
In-Reply-To: <20060709135945.dfb58b3d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607092311.52866.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 July 2006 22:59, Andrew Morton wrote:
> On Sun, 9 Jul 2006 22:35:32 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > On Sunday 09 July 2006 22:21, Andrew Morton wrote:
> > > On Sun, 09 Jul 2006 18:19:00 +0200
> > > Cedric Le Goater <clg@fr.ibm.com> wrote:
> > > 
> > > > Andrew Morton wrote:
> > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/
> > > > 
> > > > Kernel BUG at ...home/legoater/linux/2.6.18-rc1-mm1/mm/page_alloc.c:252
> > > 
> > > 	VM_BUG_ON((gfp_flags & (__GFP_WAIT | __GFP_HIGHMEM)) == __GFP_HIGHMEM);
> > > 
> > > With your config, __GFP_HIGHMEM=0, so wham.
> > > 
> > > I dunno, Christoph.  I think those patches are going to significantly
> > > increase the number of works-with-my-config, doesnt-with-yours scenarios.
> > 
> > This particular one has no chance to work on x86_64 at all.
> > 
> 
> Fortunately in -mm we can make this BUG go away by setting
> CONFIG_DEBUG_VM=n.
> 
> But in 2.6.18-rc1 that's a simple BUG_ON().
> 
> > So well, which one is it?
> 
> I don't understand that question, sorry.

I meant which of the patches added this VM_BUG_ON().  Sorry for not being clear.

Rafael
