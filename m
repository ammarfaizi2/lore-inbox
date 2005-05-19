Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262466AbVESMr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262466AbVESMr2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 08:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbVESMr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 08:47:28 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:28690 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262466AbVESMrO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 08:47:14 -0400
Date: Thu, 19 May 2005 13:47:11 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-os@analogic.com, Adrian Bunk <bunk@stusta.de>,
       Kyle Moffett <mrmacman_g4@mac.com>, "Gilbert, John" <JGG@dolby.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Illegal use of reserved word in system.h
In-Reply-To: <1116505655.6027.45.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61L.0505191342460.10681@blysk.ds.pg.gda.pl>
References: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net> 
 <20050518195337.GX5112@stusta.de>  <6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com>
  <20050519112840.GE5112@stusta.de>  <Pine.LNX.4.61.0505190734110.29439@chaos.analogic.com>
 <1116505655.6027.45.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2005, Arjan van de Ven wrote:

> > First off, I think we need a system-call that will return some of
> > the information that now comes from headers. PAGE_SIZE comes to
> > mind. You need this for mmap() but there doesn't seem to be any
> > way to get it. getpagesize() 'C' library just returns something
> > it's swiped from kernel headers when the library was compiled.
> > There are other things like the following that sometimes need
> 
> for getpagesize() I can see the point

 If that is the case, then that's a bug in that C library, which should be 
reported and fixed.  When starting a program, i.e. as a result of 
execve(), Linux passes the current page size in use in the auxiliary 
vector.  That value should be retrieved and used by a C library for 
platforms that support various page sizes and returned by library calls 
like getconf().  For example glibc gets it right.

  Maciej
