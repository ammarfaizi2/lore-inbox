Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWJMKzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWJMKzF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 06:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWJMKzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 06:55:05 -0400
Received: from vstglbx99.vestmark.com ([208.50.5.99]:62992 "EHLO
	texas.hq.viviport.com") by vger.kernel.org with ESMTP
	id S1751211AbWJMKzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 06:55:03 -0400
Date: Fri, 13 Oct 2006 06:55:02 -0400
From: nmeyers@vestmark.com
To: Mike Galbraith <efault@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Major slab mem leak with 2.6.17 / GCC 4.1.1
Message-ID: <20061013105502.GA9773@viviport.com>
References: <20061013004918.GA8551@viviport.com> <1160727912.15431.11.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160727912.15431.11.camel@Homer.simpson.net>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 13 Oct 2006 10:55:02.0535 (UTC) FILETIME=[08C6E970:01C6EEB6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 08:25:12AM +0000, Mike Galbraith wrote:
> On Thu, 2006-10-12 at 20:49 -0400, nmeyers@vestmark.com wrote:
> 
> > I tried Catalin Marinas' kmemleak patches, and had to rebuild with
> > GCC 3.4.6 because of a 4.1.1 compiler bug that prevents compilation
> > of the patches.
> 
> Yeah, seems any remotely recent gcc hates it.  That puts a rather large
> dent in usability.
> 
> > And... building with 3.4.5 fixed the leak! So I guess I have very little
> > detail to report - except that there's a nasty leak in 2.6.17 when built
> > with 4.1.1.
> 
> If you build using 3.4.5 _without_ the kmemleak patches, do you see the
> leak again?  (ie is kmemleak altering timing, or is kernel miscompiled)

I wondered the same thing. I went back to the original source and .config
- rebuilding with 3.4.6 (3.4.5 is a typo) fixed the leak.

> 
> > If anyone has a version of kmemleak that I can build with 4.1.1, or
> > any other suggestions for instrumentation, I'd be happy to gather more
> > data - the problem is very easy for me to reproduce.
> 
> I can only suggest trying latest/greatest to see if the issue is still
> present, and if so, try to find a way that others may trigger it.

I may just do that - apparently 4.1.2 is supposed to fix the kmemleak
compile problem. My (admittedly lazy) inclination is to wait until that
comes out in a Gentoo ebuild.

Nathan


> 
> 	-Mike
> 
> 
