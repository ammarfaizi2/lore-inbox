Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266250AbUIMHXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266250AbUIMHXQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 03:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266257AbUIMHXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 03:23:16 -0400
Received: from cantor.suse.de ([195.135.220.2]:34529 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266250AbUIMHXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 03:23:09 -0400
Date: Mon, 13 Sep 2004 09:23:08 +0200
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, pj@sgi.com, bcasavan@sgi.com, anton@samba.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: more numa maxnode confusions
Message-ID: <20040913072308.GB32259@wotan.suse.de>
References: <20040912200253.3d7a6ff5.pj@sgi.com> <20040913065621.GB12185@wotan.suse.de> <20040913001548.278bf672.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913001548.278bf672.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 12:15:48AM -0700, Andrew Morton wrote:
> Andi Kleen <ak@suse.de> wrote:
> >
> > On Sun, Sep 12, 2004 at 08:02:53PM -0700, Paul Jackson wrote:
> > >  2) About Aug 9, Brent Casavant sent in a patch changing the set (not get)
> > >     side calls, sys_mbind and sys_set_mempolicy, to N64.  This patch
> > >     removed the following line from the implementation of get_nodes() in
> > >     mm/mempolicy.c:
> > > 
> > > 	--maxnode;
> > 
> > Ah, I wasn't aware that this patch got merged into mainline. 
> > That was a bad thing, because it broke the ABI used by libnuma
> > subtly.
> > 
> > Please whoever merged it revert it.
> 
> Revert what?


http://linux.bkbits.net:8080/linux-2.6/cset@412b8943seoOgs2sAUXJeG1qynkYHQ?nav=index.html|src/|src/mm|related/mm/mempolicy.c

> 
> > ...
> >
> > Yes. I appended a patch. Linus or Andrew, please apply it.
> > 
> 
> Does this patch perform the above reversion, or is something additional
> needed?

It does it, and nothing else is needed.

-Andi

