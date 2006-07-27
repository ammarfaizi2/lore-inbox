Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbWG0Dvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWG0Dvl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 23:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWG0Dvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 23:51:41 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:20709 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751255AbWG0Dvl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 23:51:41 -0400
Message-ID: <1153972270.44c8382ea9da5@portal.student.luth.se>
Date: Thu, 27 Jul 2006 05:51:10 +0200
From: ricknu-0@student.ltu.se
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       jeff@garzik.org, adobriyan@gmail.com, vlobanov@speakeasy.net,
       jengelh@linux01.gwdg.de, getshorty_@hotmail.com,
       pwil3058@bigpond.net.au, mb@bu3sch.de, penberg@cs.helsinki.fi,
       stefanr@s5r6.in-berlin.de, larsbj@gullik.net
Subject: Re: [RFC][PATCH] A generic boolean (version 6)
References: <1153341500.44be983ca1407@portal.student.luth.se> <1153945705.44c7d069c5e18@portal.student.luth.se> <20060726180622.63be9e55.pj@sgi.com> <20060727021047.GG28284@filer.fsl.cs.sunysb.edu>
In-Reply-To: <20060727021047.GG28284@filer.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 130.240.42.170
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Citerar Josef Sipek <jsipek@fsl.cs.sunysb.edu>:

> On Wed, Jul 26, 2006 at 06:06:22PM -0700, Paul Jackson wrote:
> > Richard wrote:
> > > * removed the #undef false/true and #define false/true
> > 
> > Good - thanks.
> > 
> > +enum {
> > +	false	= 0,
> > +	true	= 1
> > +};
> 
> You probably have said it before, but why do we need this?

Well Jeff, there is no _need_ for the false and true, but it makes the code more
readable to many of us. (Why else is there all these definitions of false and true?)
There is other opinions on this and that is one of the reason* bool isn't
defined as:

enum { false, true } bool;

letting us choose our own way.
So when (hopefully) the converting to these starts, it will only affect the
files already using some sort of false and true. If the author is more
comfortable with 0 and 1's, that will be respectet (by me, at least).

Hope it make some sense.

> Josef "Jeff" Sipek.

/Richard Knutsson

PS
If I got you wrong and you meant why it can't be defined where it is used, I
refere you to Andrew's mail "[patch 1/1] consolidate TRUE and FALSE", where a
redefinition occured (of TRUE/FALSE).
DS

* another is that C99 defines the boolean type for us (as _Bool).

