Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVFNVTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVFNVTf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 17:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVFNVTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 17:19:35 -0400
Received: from urchin.mweb.co.za ([196.2.24.26]:59527 "EHLO urchin.mweb.co.za")
	by vger.kernel.org with ESMTP id S261342AbVFNVT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 17:19:26 -0400
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Tracking a bug in x86-64
Date: Tue, 14 Jun 2005 23:19:35 +0200
User-Agent: KMail/1.8.50
Cc: Linus Torvalds <torvalds@osdl.org>, ak@muc.de,
       linux-kernel@vger.kernel.org
References: <200506132259.22151.bonganilinux@mweb.co.za> <Pine.LNX.4.58.0506140819440.8487@ppc970.osdl.org> <20050614132721.3b55c196.akpm@osdl.org>
In-Reply-To: <20050614132721.3b55c196.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506142319.35465.bonganilinux@mweb.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 June 2005 10:27 pm, Andrew Morton wrote:
> Linus Torvalds <torvalds@osdl.org> wrote:
> >
> > The way to do the binary searach is to get the
> > 
> >  	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm1/2.6.11-mm1-broken-out.tar.gz 
> > 
> >  file, and then to apply half of the patches
> 
> Or:
> 
> - install https://savannah.nongnu.org/projects/quilt/
> 
> cd /usr/src/linux
> wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm1/2.6.11-mm1-broken-out.tar.gz
> tar xfz 2.6.11-mm1-broken-out.tar.gz
> mv broken-out patches
> mv patches/series .
> 
> Now you can do `quilt push 100' to apply 100 patches, `quilt pop 50' to
> remove half of them, etc.
> 
> Open a copy of the series file in an editor and add markers to it as you
> proceed through the search so you don't get lost.
> 
> Avoid applying obviously-broken patches.  For example, we have, in the
> series file:
> 
> posix-timers-cpu-clock-support-for-posix-timers.patch
> posix-timers-cpu-clock-support-for-posix-timers-fix.patch
> posix-timers-cpu-clock-support-for-posix-timers-fix3.patch
> 
> That's one patch plus two fixes to it.  You'd either apply all of these or none.
> 
> There's a bit of setup but once quilt is installed it's all pretty easy and
> quick.
> 

I'm busy downloading quilt, I'll let you know when I find something
