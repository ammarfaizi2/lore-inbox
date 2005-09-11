Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbVIKA7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbVIKA7d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 20:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbVIKA7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 20:59:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30337 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964788AbVIKA7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 20:59:32 -0400
Date: Sat, 10 Sep 2005 17:59:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: ak@suse.de, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: NUMA mempolicy /proc code in mainline shouldn't have been
 merged
Message-Id: <20050910175901.7af1e437.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0509100921260.17110@schroedinger.engr.sgi.com>
References: <200509101120.19236.ak@suse.de>
	<20050910023337.7b79db9a.akpm@osdl.org>
	<Pine.LNX.4.62.0509100921260.17110@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> On Sat, 10 Sep 2005, Andrew Morton wrote:
> 
> > Andi Kleen <ak@suse.de> wrote:
> > >
> > >  Just noticed the ugly SGI /proc/*/numa_maps code got merged.
> 
> Well its ugly because you said that the fixes to make it less ugly were 
> "useless". I can still submit those fixes that make numa_maps a part of 
> smaps and that cleanup the way policies are displayed.

It would be useful to see these.

> > >  - it presents lots of kernel internal information and mempolicy
> > >  internals (like how many people have a page mapped) etc.
> > >  to userland that shouldn't be exposed to this.
> 
> Very important information.
>

Important to whom?  Kernel developers or userspace developers?  If the
latter, what use do they actually make of it?  Shouldn't it be documented?

> > >  - there is no demonstrated application that needs it
> > >  (there was a theoretical usecase where it might be needed,
> > >  but there were better solutions proposed for this) 
> 
> Could you be more specific? The application is to figure out how memory is 
> placed. Just to cat /proc/<pid>/numa_maps. Seems to be a favorite with 
> some people.

If it's useful to application developers then fine.  It it's only useful to
kernel developers then the argument is weakened.  However there's still
quite a lot of development going on in this area, so there's still some
argument for having the monitoring ability in the mainline tree.

