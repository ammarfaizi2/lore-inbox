Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVFOWVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVFOWVl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 18:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVFOWVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 18:21:40 -0400
Received: from mollusk.mweb.co.za ([196.2.24.27]:56187 "EHLO
	mollusk.mweb.co.za") by vger.kernel.org with ESMTP id S261643AbVFOWTi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 18:19:38 -0400
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Tracking a bug in x86-64
Date: Thu, 16 Jun 2005 00:20:21 +0200
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
Message-Id: <200506160020.21688.bonganilinux@mweb.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 June 2005 10:27 pm, Andrew Morton wrote:
> Linus Torvalds <torvalds@osdl.org> wrote:
> >
> > The way to do the binary searach is to get the
> >  	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm1/2.6.11-mm1-broken-out.tar.gz 
> >  file, and then to apply half of the patches
> 
> Or:
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

Hi

I've used quilt to et to the patch that is causing problems (quilt is great thanx Andrew). This is the sequence, which led me to
the possible culprit:
push 410, pop 205, pop 103, push 103, pop 51, pop 26, push 13, pop 6, push 4 and push 1
This points to: randomisation-top-of-stack-randomization.patch

Regards
