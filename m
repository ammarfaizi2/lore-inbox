Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVBSP0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVBSP0Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 10:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVBSP0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 10:26:25 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:26129 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261728AbVBSP0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 10:26:19 -0500
Date: Sat, 19 Feb 2005 16:23:00 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Adrian Bunk <bunk@stusta.de>,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/smc-mca.c: cleanups
Message-ID: <20050219152300.GF1850@alpha.home.local>
References: <20050219083431.GN4337@stusta.de> <4216FBCB.8040807@pobox.com> <1108804140.6304.67.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108804140.6304.67.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2005 at 10:09:00AM +0100, Arjan van de Ven wrote:
> On Sat, 2005-02-19 at 03:41 -0500, Jeff Garzik wrote:
> > Adrian Bunk wrote:
> > > This patch contains the following cleanups:
> > > - make a needlessly global function static
> > > - make three needlessly global structs static
> > > 
> > > Since after moving the now-static stucts to smc-mca.c the file smc-mca.h 
> > > was empty except for two #define's, I've also killed the rest of 
> > > smc-mca.h .
> > 
> > It looks like the structs should be 'static const', not just 'static'.
> > 
> > This comment is applicable to similar changes, also.  Use 'const' 
> > whenever possible.
> 
> does that even have meaning in C? In C++ it does, but afaik in C it
> doesn't.

Yes it does. Often the variables declared this way will go into the text
section which is marked read-only. I've used this technique in a few very
small programs to reduce their size (I could strip off both their bss and
data sections to save space). Also, I believe that the compiler is able
to optimize code using consts, but this is pure speculation, I've not
verified it.

Willy

